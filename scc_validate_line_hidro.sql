-- Validates reported water bodies (hidrography) on the management unity

--FUNCAO PARA VALIDACAO E INCLUSAO DE HIDROGRAFIA NA UMF RETORNA "0" SE VALIDADO E SÃO COPIADOS OS REGISTROS PARA TABELA scc.scc_hidrografia, RETORNA NÚMERO DE HIDROGRAFIA FORA DA UMF SE NÃO VÁLIDO. SE VÁLIDO E HOUVER HIDROGRAFIA REPETIDAS, RETONA O TOTAL.

CREATE OR REPLACE FUNCTION scc.scc_val_hidrografia(id_umf integer, OUT est_val integer, OUT est_rep integer) AS $$

DECLARE org scc.temp_hidrografia%rowtype;
DECLARE geom_umf geometry;

BEGIN
		geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE sde.umfs.id_umf = $1));
	est_rep := 0;
	est_val := (SELECT count(temp_hidrografia.gid) FROM temp_hidrografia WHERE ST_Intersects(geom_umf, temp_hidrografia.shape));
	IF est_val != 0
		THEN
				est_val = 0;
				est_rep := est_rep+(SELECT count(temp_hidrografia.gid) FROM scc.scc_hidrografia, scc.temp_hidrografia 
				  WHERE scc.scc_hidrografia.comp_m=scc.temp_hidrografia.comp_m
					AND scc.scc_hidrografia.shape=scc.temp_hidrografia.shape);
				INSERT INTO scc.scc_hidrografia(num_upa, comp_m, shape) 
	              		(SELECT temp_hidrografia.num_upa, temp_hidrografia.comp_m, temp_hidrografia.shape
				  FROM temp_hidrografia
				  WHERE NOT EXISTS (SELECT scc.scc_hidrografia.num_upa, scc.scc_hidrografia.comp_m, scc.scc_hidrografia.shape FROM scc.scc_hidrografia, scc.temp_hidrografia 
				  WHERE scc.scc_hidrografia.comp_m=scc.temp_hidrografia.comp_m
					AND scc.scc_hidrografia.shape=scc.temp_hidrografia.shape)
				);
		ELSE
			est_val := 1;
				
	END IF;
END;
$$LANGUAGE plpgsql;


--SELECT * FROM scc.scc_val_hidrografia(1);
