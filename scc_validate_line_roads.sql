-- Function that validates simple topology request, that a road on the forest management project must intersect the polygons
-- of management areas

--FUNCAO PARA VALIDACAO E INCLUSAO DE ESTRADAS NA UMF SE RETORNA "0" (est_val) SE VALIDADO E SÃO COPIADOS OS REGISTROS PARA TABELA scc.scc_estradas, RETORNA NÚMERO DE ESTRADAS FORA DA UMF SE NÃO VÁLIDO. CASO AS ESTRADAS VALIDADAS JÁ EXISTAM, DEVOLVE O NÚMERO DE ESTRADAS REPETIDAS (est_rep).

CREATE OR REPLACE FUNCTION scc.scc_val_estradas(id_umf integer, OUT est_val integer, OUT est_rep integer) AS $$

DECLARE org scc.temp_estradas%rowtype;
DECLARE geom_umf geometry;

BEGIN
		geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE sde.umfs.id_umf = $1));
	est_rep := 0;
	est_val := (SELECT count(temp_estradas.gid) FROM temp_estradas WHERE ST_Intersects(geom_umf, temp_estradas.shape));
	IF est_val != 0
		THEN
				est_val = 0;
				est_rep := est_rep+(SELECT count(temp_estradas.gid) FROM scc.scc_estradas, scc.temp_estradas 
				  WHERE scc.scc_estradas.comp_m=scc.temp_estradas.comp_m
					AND scc.scc_estradas.tipo=scc.temp_estradas.tipo);
				INSERT INTO scc.scc_estradas(num_upa, comp_m, tipo, shape) 
	              		(SELECT temp_estradas.num_upa, temp_estradas.comp_m, temp_estradas.tipo, temp_estradas.shape
				  FROM temp_estradas
				  WHERE NOT EXISTS (SELECT scc.scc_estradas.num_upa, scc.scc_estradas.comp_m, scc.scc_estradas.shape FROM scc.scc_estradas, scc.temp_estradas 
				  WHERE scc.scc_estradas.comp_m=scc.temp_estradas.comp_m
					AND scc.scc_estradas.tipo=scc.temp_estradas.tipo)
				);
		ELSE
			est_val := 1;
				
	END IF;
END;
$$LANGUAGE plpgsql;


--SELECT * FROM scc.scc_val_estradas(1);
