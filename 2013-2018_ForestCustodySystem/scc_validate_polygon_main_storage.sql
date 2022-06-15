-- Validate the location of the main storage site

--FUNCAO PARA VALIDACAO E INCLUSAO DE PATIOS PRINCIPAIS NA UMF RETORNA "0" SE VALIDADO E SÃO COPIADOS OS REGISTROS PARA TABELA scc.scc_patio_PRINCIPAL, RETORNA NÚMERO DE PÁTIOS FORA DA UMF SE NÃO VÁLIDO. SE VÁLIDO E HOUVER PÁTIOS REPETIDOS, RETONA O TOTAL.

CREATE OR REPLACE FUNCTION scc.scc_val_patio_principal(id_umf integer, OUT fora_umf integer, OUT repetidos integer) AS $$

DECLARE org scc.temp_patio_principal%rowtype;
DECLARE geom_umf geometry;
BEGIN
	geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE sde.umfs.id_umf = $1));
	fora_umf := (SELECT count(temp_patio_principal.gid) FROM temp_patio_principal
WHERE NOT ST_Intersects(geom_umf, temp_patio_principal.shape) AND ST_Distance(geom_umf, temp_patio_principal.shape) > 0);
	IF fora_umf = 0
		THEN
				repetidos:=(SELECT count(scc.scc_patio_principal.objectid) FROM scc.temp_patio_principal, scc.scc_patio_principal
				    WHERE temp_patio_principal.shape=scc_patio_principal.shape AND temp_patio_principal.area_ha=scc_patio_principal.area_ha
				);

				INSERT INTO scc.scc_patio_principal( area_ha, shape) 
	              		(SELECT scc.temp_patio_principal.area_ha, scc.temp_patio_principal.shape
				 FROM temp_patio_principal
				  WHERE NOT EXISTS 
				  (SELECT  scc.scc_patio_principal.area_ha FROM scc.temp_patio_principal, scc.scc_patio_principal
				    WHERE temp_patio_principal.shape=scc_patio_principal.shape AND temp_patio_principal.area_ha=scc_patio_principal.area_ha
				  )
				);

	END IF;

END;
$$LANGUAGE plpgsql;


--SELECT * FROM scc.scc_val_patio_principal(1);
