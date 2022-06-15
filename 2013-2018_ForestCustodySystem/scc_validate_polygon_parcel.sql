--Function to validate the permanent maintened parcel of forest for the management unit

--FUNCAO PARA VALIDACAO E INCLUSAO DE PARCELAS PERMANENTES NA UMF SE RETORNA "0" SE VALIDADO E SÃO COPIADOS OS REGISTROS PARA TABELA scc.scc_parcelas, RETORNA NÚMERO DE PARCELAS FORA DA UMF SE NÃO VÁLIDO. SE VÁLIDO E HOUVER PARCELAS REPETIDAS, RETORNA O TOTAL.

CREATE OR REPLACE FUNCTION scc.scc_val_parcelas(id_umf integer, OUT fora_umf integer, OUT repetidos integer)  AS $$


DECLARE org scc.temp_parcelas%rowtype;
DECLARE geom_umf geometry;
BEGIN
	geom_umf := ST_Union(ARRAY(SELECT shape FROM sde.umfs WHERE sde.umfs.id_umf = $1));
	fora_umf := (SELECT count(scc.temp_parcelas.gid) FROM scc.temp_parcelas
WHERE NOT ST_Intersects(geom_umf, scc.temp_parcelas.shape) AND
ST_Distance(geom_umf, scc.temp_parcelas.shape) > 0);
	IF fora_umf = 0
		THEN
				repetidos:=(SELECT
count(scc.scc_parcelas_permanentes.objectid) FROM scc.temp_parcelas, scc.scc_parcelas_permanentes
				    WHERE
$1=scc_parcelas_permanentes.num_umf AND
temp_parcelas.num_upa=scc_parcelas_permanentes.num_upa AND
temp_parcelas.cod_par=scc_parcelas_permanentes.cod_par
				);
				INSERT INTO
scc.scc_parcelas_permanentes(num_umf, num_upa, cod_par, shape) 
	              		(SELECT $1, scc.temp_parcelas.num_upa,
scc.temp_parcelas.cod_par, scc.temp_parcelas.shape
				   FROM scc.temp_parcelas
				  WHERE NOT EXISTS
				   (SELECT scc.temp_parcelas.shape,
scc.scc_parcelas_permanentes.shape FROM scc.temp_parcelas, scc.scc_parcelas_permanentes
				    WHERE ST_Equals(scc.temp_parcelas.shape, scc.scc_parcelas_permanentes.shape))
				);
			
	END IF;

END;
$$LANGUAGE plpgsql;


--SELECT * FROM scc.scc_val_parcelas(1);
