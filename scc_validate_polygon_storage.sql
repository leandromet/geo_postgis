
-- Function to validate storage areas that should be inside the management unit
--FUNCAO PARA VALIDACAO E INCLUSAO DE PATIOS DE ESTOCAGEM NA UMF SE RETORNA "0" SE VALIDADO E SÃO COPIADOS OS REGISTROS PARA TABELA scc.scc_patios_estocagem, RETORNA NÚMERO DE PÁTIOS FORA DA UMF SE NÃO VÁLIDO. SE VÁLIDO E HOUVER PÁTIOS REPETIDOS, RETONA O TOTAL.

CREATE OR REPLACE FUNCTION scc.scc_val_patios_estocagem(id_umf integer, OUT fora_umf integer, OUT repetidos integer) AS $$

DECLARE org scc.temp_patios%rowtype;
DECLARE geom_umf geometry;
BEGIN
	geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE sde.umfs.id_umf = $1));
	fora_umf := (SELECT count(temp_patios.gid) FROM temp_patios
WHERE NOT ST_Intersects(geom_umf, temp_patios.shape) );
	IF fora_umf = 0
		THEN
				repetidos:=(SELECT count(scc.scc_patios_estocagem.objectid) FROM scc.temp_patios, scc.scc_patios_estocagem
				    WHERE temp_patios.num_upa=scc_patios_estocagem.num_upa AND temp_patios.cod_pat=scc_patios_estocagem.cod_pat
				);

				INSERT INTO scc.scc_patios_estocagem(num_upa, cod_pat, shape, num_umf) 
	              		(SELECT scc.temp_patios.num_upa, scc.temp_patios.cod_pat, scc.temp_patios.shape, $1
				 FROM temp_patios
				  WHERE NOT EXISTS 
				  (SELECT scc.scc_patios_estocagem.num_upa, scc.scc_patios_estocagem.cod_pat FROM scc.temp_patios, scc.scc_patios_estocagem
				    WHERE temp_patios.num_upa=scc_patios_estocagem.num_upa AND temp_patios.cod_pat=scc_patios_estocagem.cod_pat AND scc.scc_patios_estocagem.num_umf=$1
				  )
				);






	END IF;

END;
$$LANGUAGE plpgsql;


SELECT * FROM scc.scc_val_patios_estocagem(1);
