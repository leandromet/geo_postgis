--Function to validate an Anual Production Unit inside an Area conceaded to forest management

--FUNCAO PARA VALIDACAO E INCLUSAO DE UPA NA UMF, RETORNA TRUE SE VALIDADO (COPIA REGISTROS PARA TABELA scc.scc_upa)
 -- E FALSE SE NÃO VALIDADO. DEVOLVE O PORCENTUAL DE ÁREA FORA DA UMF E QUANTAS UPA EXISTENTES ELE SE SOBREPÕE SE FOR O CASO
-- NA INCLUSÃO VERIFICA SE JÁ EXISTE OUTRO REGISTRO COM MESMO UMF E UPA QUE ESTÃO MARCADOS COMO INATIVOS (ATIVO = 0) 
-- CASO EXISTAM, ADICIONA UMA CENTENA NO NÚMERO DA UPA PARA CADA REGISTRO IGUAL EXISTENTE

 CREATE OR REPLACE FUNCTION scc.scc_val_upa(id_umf integer, OUT pn boolean, OUT v_umf float, OUT v_upa integer) AS $$
 DECLARE valida float;
 DECLARE valida2 float;
 DECLARE valida3 integer;
 DECLARE addicupa integer;
 DECLARE org RECORD;
 DECLARE geom_umf geometry;
 DECLARE geom_upa geometry;
 DECLARE orgupa scc.scc_upa%rowtype;
 BEGIN

	geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE
 sde.umfs.id_umf = $1));
	geom_upa := ST_Union(ARRAY(SELECT temp_upa.shape FROM scc.temp_upa));
	valida := (SELECT (1 - ST_Area(ST_Intersection(geom_upa, geom_umf)) / ST_Area(geom_upa))
			WHERE ST_Intersects(geom_upa, geom_umf)
		   );
	org := (SELECT (num_upa , area_ha , geom_upa) 
			FROM scc.temp_upa
		);
	IF valida < (0.05)
		THEN 
			valida3 := 0;
			FOR orgupa IN SELECT * FROM scc.scc_upa WHERE scc_upa.ativo=TRUE
				LOOP
				  valida2 := (SELECT (ST_Area(ST_Union(ST_Intersection(geom_upa, orgupa.shape))) / ST_Area(geom_upa))
					     WHERE ST_Intersects(geom_upa, orgupa.shape)
					   );
					IF valida2 > (0.05)
						THEN
							valida3 := valida3+1;
					END IF;
				END LOOP;
			IF valida3 = 0
				THEN
					addicupa = (SELECT count(scc.scc_upa.objectid)  FROM scc.scc_upa WHERE scc.scc_upa.num_umf = $1 AND scc.scc_upa.num_upa = org.f1 AND scc.scc_upa.ativo=FALSE);
					INSERT INTO scc.scc_upa (num_upa, area_ha, shape, num_umf, ativo) 
					VALUES(org.f1+addicupa, org.f2, org.f3, $1, TRUE);
			END IF;
	END IF;
	v_umf := valida;
	v_upa := valida3;
	IF valida < (0.05) AND valida3 = 0
		THEN 
			pn := TRUE;
	ELSE
		pn := FALSE;
	END IF;
 END;
 $$LANGUAGE plpgsql;


 -- Código para chamar função:
 --SELECT * FROM scc.scc_val_upa(1);
