--Function to validate permanent protection areas inside the management unity

--FUNCAO PARA VALIDACAO E INCLUSAO DE APP NA UMF RETORNA "0" SE VALIDADO E SÃO COPIADOS OS REGISTROS PARA TABELA scc.scc_app, RETORNA NÚMERO APP FORA DA UMF SE NÃO VÁLIDO. SE VÁLIDO E HOUVER APP REPETIDAS, RETONA O TOTAL.

CREATE OR REPLACE FUNCTION scc.scc_val_app(id_umf integer, OUT fora_umf integer, OUT repetidos integer) AS $$

DECLARE org scc.temp_app%rowtype;
DECLARE geom_umf geometry;
BEGIN
	geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE sde.umfs.id_umf = $1));
	fora_umf := (SELECT count(temp_app.gid) FROM temp_app
WHERE NOT ST_Intersects(geom_umf, temp_app.shape) AND ST_Distance(geom_umf, temp_app.shape) > 0);
	IF fora_umf = 0
		THEN
				repetidos:=(SELECT count(scc.scc_app.objectid) FROM scc.temp_app, scc.scc_app
				    WHERE temp_app.num_upa=scc_app.num_upa AND temp_app.area_ha=scc_app.area_ha
				);

				INSERT INTO scc.scc_app(num_upa, area_ha, shape) 
	              		(SELECT scc.temp_app.num_upa, scc.temp_app.area_ha, scc.temp_app.shape
				 FROM temp_app
				  WHERE NOT EXISTS 
				  (SELECT scc.scc_app.num_upa, scc.scc_app.area_ha FROM scc.temp_app, scc.scc_app
				    WHERE temp_app.num_upa=scc_app.num_upa AND temp_app.area_ha=scc_app.area_ha
				  )
				);

	END IF;

END;
$$LANGUAGE plpgsql;


--SELECT * FROM scc.scc_val_app(1);
