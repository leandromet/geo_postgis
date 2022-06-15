--- Function for updating ICMBio related features on national forest registry database, mainly conservation unities


--FUNCAO PARA VALIDACAO E INCLUSAO DE UC NO cnfp, RETORNA TRUE SE VALIDADO (COPIA REGISTROS PARA TABELA cnfp.)
 -- E FALSE SE NÃO VALIDADO. DEVOLVE O PORCENTUAL DE ÁREA FORA DA UMF E QUANTAS UPA EXISTENTES ELE SE SOBREPÕE

 CREATE OR REPLACE FUNCTION cnfp.f_adic_uc
(IN anoCNFP integer, IN dataAtual date, OUT pn boolean, OUT Territorio float, OUT Verificado integer, OUT Nov_Geom integer, OUT Nov_Atrib integer, OUT Nov_Dado integer ) AS $$
 DECLARE valida float;
 DECLARE valida3 integer;
 DECLARE org RECORD;
 DECLARE geom_Brasil geometry;
 DECLARE orgitem cnfp.orig_feduc%rowtype;
 DECLARE orgitem2 cnfp.adic_uc%rowtype;
 BEGIN

	Nov_Geom := 0;
	Nov_Atrib := 0;
	Nov_Dado := 0;

	geom_Brasil := ST_Union(ARRAY(SELECT shape FROM cnfp.base_uf_s2000));
	valida := (SELECT count(adic_uc.gid) FROM cnfp.adic_uc
WHERE NOT ST_Intersects(geom_Brasil, cnfp.adic_uc.shape) );
	IF valida >= 0

		THEN 
			
			valida3 := 0;
			valida3:=valida3+(SELECT count(cnfp.orig_feduc.id_uc)
			    FROM cnfp.orig_feduc, cnfp.adic_uc
			    WHERE cnfp.orig_feduc.tipo_uc=cnfp.adic_uc.classifica
			    AND cnfp.orig_feduc.nome_uc=substring(cnfp.adic_uc.nome for 80)
			    AND (SELECT cnfp.orig_feduc.shape~=cnfp.adic_uc.shape)=TRUE
			  );
raise notice 'Valida3 = %', valida3;
			IF valida3 = 0
			THEN
					INSERT INTO cnfp.orig_feduc(nome_uc, tipo_uc, shape, ano_inc_cnfp, documento, data_atual, situacao_cnfp, bioma, anocriacao_icmbio, administra) 
					(SELECT substring(cnfp.adic_uc.nome for 80), cnfp.adic_uc.classifica , cnfp.adic_uc.shape , $1,cnfp.adic_uc.atolegal, $2, 'Ativo', cnfp.adic_uc.bioma, cnfp.adic_uc.anocriacao::numeric::integer, cnfp.adic_uc.esfera5
					FROM cnfp.adic_uc);
raise notice 'INSERE';
			ELSE
			      FOR orgitem IN SELECT * FROM cnfp.orig_feduc WHERE data_inativo is null 
			      LOOP
raise notice 'orgitem = %', orgitem.nome_uc;
				FOR orgitem2 IN SELECT * FROM cnfp.adic_uc
			      	LOOP
				  IF ((SELECT orgitem.shape~=orgitem2.shape)=TRUE) 
					THEN
					Nov_Atrib := Nov_Atrib+1;
					UPDATE cnfp.orig_feduc
					SET ( nome_uc, tipo_uc, documento, data_atual) = 
					(substring(orgitem2.nome for 80), orgitem2.classifica,orgitem2.atolegal, $2)
					WHERE cnfp.orig_feduc.id_uc=orgitem.id_uc
					;
			   	   ELSE
					IF (orgitem2.nome=orgitem.nome_uc AND orgitem2.classifica=orgitem.tipo_uc)
						THEN
raise notice 'orgitem2 = %', orgitem2.nome;
						Nov_Geom := Nov_Geom+1;
						UPDATE cnfp.orig_feduc
						SET (data_inativo, situacao_cnfp) = 
						($2, 'Inativo')
						FROM cnfp.adic_uc
						WHERE cnfp.orig_feduc.id_uc=orgitem.id_uc;

						INSERT INTO cnfp.orig_feduc(nome_uc, tipo_uc, shape, ano_inc_cnfp, documento, data_atual, situacao_cnfp, bioma, anocriacao_icmbio, administra) 
						VALUES (substring(orgitem2.nome for 80), orgitem2.classifica , orgitem2.shape , $1,orgitem2.atolegal, $2, 'Ativo', orgitem2.bioma, orgitem2.anocriacao::numeric::integer, cnfp.adic_uc.esfera5);
					ELSIF ((select exists(SELECT 1 FROM cnfp.orig_feduc WHERE cnfp.orig_feduc.nome_uc=substring(orgitem2.nome for 80)))=FALSE)
					THEN
						Nov_Dado := Nov_Dado+1;
						INSERT INTO cnfp.orig_feduc(nome_uc, tipo_uc, shape, ano_inc_cnfp, documento, data_atual, situacao_cnfp, bioma, anocriacao_icmbio, administra) 
						VALUES (substring(orgitem2.nome for 80), orgitem2.classifica , orgitem2.shape , $1,orgitem2.atolegal, $2, 'Ativo', orgitem2.bioma, orgitem2.anocriacao::numeric::integer, cnfp.adic_uc.esfera5);

					END IF;
					
				   END IF;
				END LOOP;
			       END LOOP;
			END IF;
	END IF;
	Territorio := valida;
	Verificado := valida3;
	IF valida < (0.05) AND valida3 = 0
		THEN 
			pn := TRUE;
	ELSE
		pn := FALSE;
	END IF;
 END;
 $$LANGUAGE plpgsql;

 -- Código para chamar função:
 --SELECT * FROM cnfp.f_adic_uc(2014, '2015-05-05');


--criando categorias do SNUC

 INSERT INTO cnfp.atrib_uc_categoria(tipo_uc, protecao, snuc) (SELECT DISTINCT classifica, 'Integral', 1 FROM cnfp.adic_uc);
