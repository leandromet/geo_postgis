--Simple update function for inserting new indigenous areas from FUNAI inside the national forest registry

--FUNCAO PARA VALIDACAO E INCLUSAO DE TI NO cnfp, RETORNA TRUE SE VALIDADO (COPIA REGISTROS PARA TABELA scc.scc_upa)
 -- 

 CREATE OR REPLACE FUNCTION cnfp.f_adic_ti_mod(OUT pn boolean, OUT v_Brasil float, OUT v_TI integer) AS $$
 DECLARE valida float;
 DECLARE valida2 float;
 DECLARE valida3 integer;
 DECLARE org RECORD;
 DECLARE geom_Brasil geometry;
 DECLARE orgitem cnfp.orig_fedti%rowtype;
 DECLARE orgitem2 cnfp.adic_ti_mod%rowtype;
 BEGIN

	geom_Brasil := ST_Union(ARRAY(SELECT shape FROM cnfp.base_uf_s2000));
	valida := (SELECT count(adic_ti_mod.gid) FROM cnfp.adic_ti_mod
WHERE NOT ST_Intersects(geom_Brasil, cnfp.adic_ti_mod.shape) );
	IF valida = 0

		THEN 
			
			valida3 := 0;
			valida3:=valida3+(SELECT count(cnfp.orig_fedti.id_ti)
			    FROM cnfp.orig_fedti, cnfp.adic_ti_mod
			    WHERE cnfp.orig_fedti.fase=cnfp.adic_ti_mod.fase_ti
			    AND cnfp.orig_fedti.nome_ti=substring(cnfp.adic_ti_mod.terrai_nom for 40)
			    AND (SELECT cnfp.orig_fedti.shape~=cnfp.adic_ti_mod.shape)=TRUE
			  );
raise notice 'Valida3 = %', valida3;
			IF valida3 = 0
			THEN
					INSERT INTO cnfp.orig_fedti(uf, nome_ti, fase, shape, ano_inc_cnfp, documento, data_atual) 
					(SELECT cnfp.adic_ti_mod.uf_sigla , substring(cnfp.adic_ti_mod.terrai_nom for 40), cnfp.adic_ti_mod.fase_ti , cnfp.adic_ti_mod.shape , 2014,'Decreto', '2015-04-30'
					FROM cnfp.adic_ti_mod);
raise notice 'INSERE';
			ELSE
			      FOR orgitem IN SELECT * FROM cnfp.orig_fedti WHERE data_inativo is null 
			      LOOP
raise notice 'orgitem = %', orgitem.nome_ti;
				FOR orgitem2 IN SELECT * FROM cnfp.adic_ti_mod
			      	LOOP
				  IF ((SELECT orgitem.shape~=orgitem2.shape)=TRUE) 
					THEN
					UPDATE cnfp.orig_fedti
					SET (uf, nome_ti, fase, documento, data_atual) = 
					(orgitem2.uf_sigla, substring(orgitem2.terrai_nom for 40), orgitem2.fase_ti,'Decreto', '2015-04-30')
					WHERE cnfp.orig_fedti.id_ti=orgitem.id_ti
					;
			   	   ELSE
					IF (orgitem2.terrai_nom=orgitem.nome_ti AND orgitem2.fase_ti=orgitem.fase)
						THEN
raise notice 'orgitem2 = %', orgitem2.terrai_nom;
						UPDATE cnfp.orig_fedti
						SET (data_inativo) = 
						('2015-04-30')
						FROM cnfp.adic_ti_mod
						WHERE cnfp.orig_fedti.id_ti=orgitem.id_ti;

						INSERT INTO cnfp.orig_fedti(uf, nome_ti, fase, shape, ano_inc_cnfp, documento, data_atual) 
						VALUES (orgitem2.uf_sigla , substring(orgitem2.terrai_nom for 40), orgitem2.fase_ti , orgitem2.shape , 2015,'Decreto', '2015-04-02');
					ELSIF ((select exists(SELECT 1 FROM cnfp.orig_fedti WHERE cnfp.orig_fedti.nome_ti=substring(orgitem2.terrai_nom for 40)))=FALSE)
					THEN
						INSERT INTO cnfp.orig_fedti(uf, nome_ti, fase, shape, ano_inc_cnfp, documento, data_atual) 
						VALUES (orgitem2.uf_sigla , substring(orgitem2.terrai_nom for 40), orgitem2.fase_ti , orgitem2.shape , 2015,'Decreto', '2015-04-02');

					END IF;
					
				   END IF;
				END LOOP;
			       END LOOP;
			END IF;
	END IF;
	v_Brasil := valida;
	v_TI := valida3;
	IF valida < (0.05) AND valida3 = 0
		THEN 
			pn := TRUE;
	ELSE
		pn := FALSE;
	END IF;
 END;
 $$LANGUAGE plpgsql;

 -- Código para chamar função:
 --SELECT * FROM cnfp.f_adic_ti_mod();
