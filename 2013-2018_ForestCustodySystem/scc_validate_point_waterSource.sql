---function to validate reported water sources on the management unity

--FUNCAO PARA VALIDACAO E INCLUSAO DE NASCENTES NA UMF RETORNA "0" SE VALIDADO E SÃO COPIADOS OS REGISTROS PARA TABELA scc.scc_nascentes, RETORNA NÚMERO DE NASCENTES FORA DA UMF SE NÃO VÁLIDO. SE VÁLIDO E HOUVER PÁTIOS REPETIDOS, RETONA O TOTAL.

CREATE OR REPLACE FUNCTION scc.scc_val_nascentes(id_umf integer, OUT fora_umf integer, OUT repetidos integer) AS $$

DECLARE org scc.temp_nascentes%rowtype;
DECLARE geom_umf geometry;
BEGIN
	geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE sde.umfs.id_umf = $1));
	fora_umf := (SELECT count(temp_nascentes.gid) FROM temp_nascentes
WHERE NOT ST_Intersects(geom_umf, temp_nascentes.shape) AND ST_Distance(geom_umf, temp_nascentes.shape) > 0);
	IF fora_umf = 0
		THEN
				repetidos:=(SELECT count(scc.scc_nascentes.objectid) FROM scc.temp_nascentes, scc.scc_nascentes
				    WHERE temp_nascentes.num_upa=scc_nascentes.num_upa AND temp_nascentes.shape=scc_nascentes.shape
				);

				INSERT INTO scc.scc_nascentes(num_upa, shape) 
	              		(SELECT scc.temp_nascentes.num_upa, scc.temp_nascentes.shape
				 FROM temp_nascentes
				  WHERE NOT EXISTS 
				  (SELECT scc.scc_nascentes.num_upa, scc.scc_nascentes.shape FROM scc.temp_nascentes, scc.scc_nascentes
				    WHERE temp_nascentes.num_upa=scc_nascentes.num_upa AND temp_nascentes.shape=scc_nascentes.shape
				  )
				);

	END IF;

END;
$$LANGUAGE plpgsql;


--SELECT * FROM scc.scc_val_nascentes(1);
