--Validate working subdivisions of the anual management unity

--FUNCAO PARA VALIDACAO E INCLUSAO DE UNIDADES DE TRABALHO NA UMF RETORNA "0" SE VALIDADO E SÃO COPIADOS OS REGISTROS PARA TABELA scc.scc_unidade_trabalho, RETORNA NÚMERO DE UTS FORA DA UMF SE NÃO VÁLIDO. SE VÁLIDO E HOUVER UTS REPETIDOS, RETONA O TOTAL.

CREATE OR REPLACE FUNCTION scc.scc_val_unidade_trabalho(id_umf integer, OUT fora_umf integer, OUT repetidos integer) AS $$

DECLARE org scc.temp_unidade_trabalho%rowtype;
DECLARE geom_umf geometry;
BEGIN
	geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE sde.umfs.id_umf = $1));
	fora_umf := (SELECT count(temp_unidade_trabalho.gid) FROM temp_unidade_trabalho
WHERE NOT ST_Intersects(geom_umf, temp_unidade_trabalho.shape) AND ST_Distance(geom_umf, temp_unidade_trabalho.shape) > 0);
	IF fora_umf = 0
		THEN
				repetidos:=(SELECT count(scc.scc_unidade_trabalho.objectid) FROM scc.temp_unidade_trabalho, scc.scc_unidade_trabalho
				    WHERE temp_unidade_trabalho.num_upa=scc_unidade_trabalho.num_upa AND temp_unidade_trabalho.area_ha=scc_unidade_trabalho.area_ha
				);

				INSERT INTO scc.scc_unidade_trabalho(num_upa, area_ha, cod_ut, shape) 
	              		(SELECT scc.temp_unidade_trabalho.num_upa, scc.temp_unidade_trabalho.area_ha, scc.temp_unidade_trabalho.cod_ut, scc.temp_unidade_trabalho.shape
				 FROM temp_unidade_trabalho
				  WHERE NOT EXISTS 
				  (SELECT scc.scc_unidade_trabalho.num_upa, scc.scc_unidade_trabalho.cod_ut FROM scc.temp_unidade_trabalho, scc.scc_unidade_trabalho
				    WHERE temp_unidade_trabalho.num_upa=scc_unidade_trabalho.num_upa AND temp_unidade_trabalho.cod_ut=scc_unidade_trabalho.cod_ut
				  )
				);

	END IF;

END;
$$LANGUAGE plpgsql;


--SELECT * FROM scc.scc_val_unidade_trabalho(1);
