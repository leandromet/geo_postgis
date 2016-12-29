--- Function to validate tree pulling tracks reported on the management area

--FUNCAO PARA VALIDACAO E INCLUSAO DE TRILHAS DE ARRASTE NA UMF RETORNA "0" SE VALIDADO E SÃO COPIADOS OS REGISTROS PARA TABELA scc.scc_trilhas_arraste, RETORNA NÚMERO DE TRILHAS FORA DA UMF SE NÃO VÁLIDO. SE VÁLIDO E HOUVER TRILHAS REPETIDAS, RETONA O TOTAL.

CREATE OR REPLACE FUNCTION scc.scc_val_trilhas_arraste(id_umf integer, OUT est_val integer, OUT est_rep integer) AS $$

DECLARE org scc.temp_trilhas_arraste%rowtype;
DECLARE geom_umf geometry;

BEGIN
		geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE sde.umfs.id_umf = $1));
	est_rep := 0;
	est_val := (SELECT count(temp_trilhas_arraste.gid) FROM temp_trilhas_arraste WHERE NOT ST_Intersects(geom_umf, temp_trilhas_arraste.shape) AND ST_Distance(geom_umf, temp_trilhas_arraste.shape) > 0);
	IF est_val = 0
		THEN
				est_rep := est_rep+(SELECT count(temp_trilhas_arraste.gid) FROM scc.scc_trilhas_arraste, scc.temp_trilhas_arraste 
				  WHERE scc.scc_trilhas_arraste.comp_m=scc.temp_trilhas_arraste.comp_m
					AND scc.scc_trilhas_arraste.shape=scc.temp_trilhas_arraste.shape);
				INSERT INTO scc.scc_trilhas_arraste(num_umf, num_upa, comp_m, shape) 
	              		(SELECT $1, temp_trilhas_arraste.num_upa, temp_trilhas_arraste.comp_m, temp_trilhas_arraste.shape
				  FROM temp_trilhas_arraste
				  WHERE NOT EXISTS (SELECT scc.scc_trilhas_arraste.num_upa, scc.scc_trilhas_arraste.comp_m, scc.scc_trilhas_arraste.shape FROM scc.scc_trilhas_arraste, scc.temp_trilhas_arraste 
				  WHERE scc.scc_trilhas_arraste.comp_m=scc.temp_trilhas_arraste.comp_m
					AND scc.scc_trilhas_arraste.shape=scc.temp_trilhas_arraste.shape)
				);
				
	END IF;
END;
$$LANGUAGE plpgsql;


--SELECT * FROM scc.scc_val_trilhas_arraste(1);
