--Function to validate ponds reported on the management site

--FUNCAO PARA VALIDACAO E INCLUSAO DE ESPELHOS D'ÁGUA NA UMF RETORNA "0" SE VALIDADO E SÃO COPIADOS OS REGISTROS PARA TABELA scc.scc_espelho_dagua, RETORNA NÚMERO DE ESPELHOS FORA DA UMF SE NÃO VÁLIDO. SE VÁLIDO E HOUVER ESPELHOS REPETIDOS, RETONA O TOTAL.

CREATE OR REPLACE FUNCTION scc.scc_val_espelho_dagua(id_umf integer, OUT fora_umf integer, OUT repetidos integer) AS $$

DECLARE org scc.temp_espelho_dagua%rowtype;
DECLARE geom_umf geometry;
BEGIN
	geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE sde.umfs.id_umf = $1));
	fora_umf := (SELECT count(temp_espelho_dagua.area_ha) FROM temp_espelho_dagua
WHERE NOT ST_Intersects(geom_umf, temp_espelho_dagua.shape) AND ST_Distance(geom_umf, temp_espelho_dagua.shape) > 0);
	IF fora_umf = 0
		THEN
				repetidos:=(SELECT count(scc.scc_espelho_dagua.objectid) FROM scc.temp_espelho_dagua, scc.scc_espelho_dagua
				    WHERE temp_espelho_dagua.num_upa=scc_espelho_dagua.num_upa AND temp_espelho_dagua.area_ha=scc_espelho_dagua.area_ha
				);

				INSERT INTO scc.scc_espelho_dagua(num_upa, area_ha, shape) 
	              		(SELECT scc.temp_espelho_dagua.num_upa, scc.temp_espelho_dagua.area_ha, scc.temp_espelho_dagua.shape
				 FROM temp_espelho_dagua
				  WHERE NOT EXISTS 
				  (SELECT scc.scc_espelho_dagua.num_upa, scc.scc_espelho_dagua.area_ha FROM scc.temp_espelho_dagua, scc.scc_espelho_dagua
				    WHERE temp_espelho_dagua.num_upa=scc_espelho_dagua.num_upa AND temp_espelho_dagua.area_ha=scc_espelho_dagua.area_ha
				  )
				);

	END IF;

END;
$$LANGUAGE plpgsql;


--SELECT * FROM scc.scc_val_espelho_dagua(1);
