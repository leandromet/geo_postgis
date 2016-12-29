-- Function to validate points that represent trees, they should be inside the management units and national forest
-- FUNCAO PARA VALIDACAO E INCLUSAO DE DAS ÁRVORES NA UPA SE RETORNA "0", VALIDADO E COPIADOS
--OS REGISTROS PARA TABELA scc.scc_arvores, RETORNA NÚMERO DE ÁRVORES FORA DA TOLERâNCIA SE
--NÃO VÁLIDO. RETORNA TOTAL DE ÁRVORES REPETIDAS CASO HAJA REGISTROS IGUAIS AOS QUE SE ESTÁ
--TENTANDO INSERIR. NÃO ATUALIZA OS EXISTENTES, APENAS INCLUI OS NÃO EXISTENTES.
CREATE OR REPLACE FUNCTION scc.scc_val_arvore(id_umf integer,OUT valido boolean,
       	OUT fora_tolerancia integer, OUT repetido integer) AS $$
DECLARE org scc.temp_arvores%rowtype;
BEGIN
	valido := false;
	fora_tolerancia := (SELECT count(temp_arvores.gid) FROM temp_arvores, temp_upa 
		WHERE NOT ST_Intersects(temp_upa.shape, temp_arvores.shape) 
		AND ST_Distance(temp_upa.shape, temp_arvores.shape) > (0.00018));
	IF fora_tolerancia = 0
		THEN
			valido := true;
			repetido:=(SELECT count(scc.scc_arvores.objectid)
			    FROM scc.scc_arvores, temp_arvores
			    WHERE scc.scc_arvores.num_upa=scc.temp_arvores.num_upa
			    AND scc.scc_arvores.num_ut=scc.temp_arvores.num_ut
			    AND scc.scc_arvores.num_arvore=scc.temp_arvores.num_arvore
			    AND scc.scc_arvores.num_umf=id_umf
			  );
			INSERT INTO scc.scc_arvores (num_upa,
nom_cient, nom_com, dap_cm, altura_m, volume_m3, categoria, x, y, num_ut, num_arvore, shape, num_umf) 
	              		(SELECT scc.temp_arvores.num_upa,
scc.temp_arvores.nom_cient, scc.temp_arvores.nom_com, scc.temp_arvores.dap_cm,
scc.temp_arvores.altura_m, scc.temp_arvores.volume_m3,
scc.temp_arvores.categoria, scc.temp_arvores.x, scc.temp_arvores.y,
scc.temp_arvores.num_ut, scc.temp_arvores.num_arvore,
scc.temp_arvores.shape,id_umf
		  FROM scc.temp_arvores
		  WHERE NOT EXISTS 
		  (SELECT scc.scc_arvores.num_upa,scc.scc_arvores.num_arvore,scc.scc_arvores.num_umf
		    FROM scc.scc_arvores, temp_arvores
		    WHERE scc.scc_arvores.num_upa=scc.temp_arvores.num_upa
		    AND scc.scc_arvores.num_ut=scc.temp_arvores.num_ut
		    AND scc.scc_arvores.num_arvore=scc.temp_arvores.num_arvore
		    AND scc.scc_arvores.num_umf=id_umf
		  )
		 );	END IF;  END;
$$LANGUAGE plpgsql;



-- Código para chamar função:
--SELECT * FROM scc.scc_val_arvore(1);
