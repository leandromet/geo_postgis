
SELECT	SUM(CASE 
		WHEN 	CASE 	WHEN flg_ativo = 1 AND dat_atualizacao >= to_date('01/03/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = 1 THEN ind_status_imovel
				WHEN flg_ativo = 0 AND dat_atualizacao >= to_date('01/03/2016','dd/mm/yyyy') THEN 'AT'
			END
		IN ('AT','PE') THEN 1
		ELSE 0
	END) AS "totalQtdCar",
	SUM(CASE 
		WHEN 	CASE 	WHEN flg_ativo = 1 AND dat_atualizacao >= to_date('01/03/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = 1 THEN ind_status_imovel
				WHEN flg_ativo = 0 AND dat_atualizacao >= to_date('01/03/2016','dd/mm/yyyy') THEN 'AT'
			END
		IN ('AT','PE') THEN i.num_area_imovel
		ELSE 0
	END) AS "totalSomaArea",
	m.cod_estado
FROM	sfb_result.sql_statement i, 
	usr_geocar_aplicacao.municipio m
WHERE 	m.idt_municipio = i.idt_municipio
	AND ((dat_criacao < to_date('01/03/2016','dd/mm/yyyy') AND ind_status_imovel IN ('AT','PE')) 
	OR (( (cod_imovel, dat_criacao) IN 
		(SELECT cod_imovel, max(dat_criacao)
		FROM 	sfb_result.sql_statement i		
		WHERE 	ind_status_imovel IN ('CA','RE') AND dat_atualizacao >= to_date('01/03/2016','dd/mm/yyyy') AND dat_criacao < to_date('01/03/2016','dd/mm/yyyy')
		GROUP BY cod_imovel))))
GROUP BY m.cod_estado
ORDER BY m.cod_estado;


SELECT	CASE	WHEN num_area_imovel < 100 THEN '0 a 100 ha'
		WHEN num_area_imovel >= 100 AND num_area_imovel < 500 THEN '100 a 500 ha'
		WHEN num_area_imovel >= 500 AND num_area_imovel < 1000 THEN '500 a 1.000 ha'
		WHEN num_area_imovel >= 1000 THEN 'superior a 1.000 ha'
	END AS "ClasseArea",
	COUNT(*) AS "totalClasseArea", sum(num_area_imovel) AS "AreaClasse",
	cod_estado
FROM	
	(SELECT	CASE 
		WHEN 	CASE 	WHEN flg_ativo = 1 AND dat_atualizacao >= to_date('01/03/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = 1 THEN ind_status_imovel
				WHEN flg_ativo = 0 AND dat_atualizacao >= to_date('01/03/2016','dd/mm/yyyy') THEN 'AT'
				END
			IN ('AT','PE') THEN num_area_imovel	
		END AS num_area_imovel,
		m.cod_estado
	FROM	sfb_result.sql_statement i, 
		usr_geocar_aplicacao.municipio m
	WHERE 	m.idt_municipio = i.idt_municipio
		AND ((dat_criacao < to_date('01/03/2016','dd/mm/yyyy') AND ind_status_imovel IN ('AT','PE')) 
	OR (( (cod_imovel, dat_criacao) IN 
		(SELECT cod_imovel, max(dat_criacao)
		FROM 	sfb_result.sql_statement i		
		WHERE 	ind_status_imovel IN ('CA','RE') AND dat_atualizacao >= to_date('01/03/2016','dd/mm/yyyy') AND dat_criacao < to_date('01/03/2016','dd/mm/yyyy')
		GROUP BY cod_imovel))))) a
WHERE	num_area_imovel IS NOT NULL
GROUP BY CASE	WHEN num_area_imovel < 100 THEN '0 a 100 ha'
		WHEN num_area_imovel >= 100 AND num_area_imovel < 500 THEN '100 a 500 ha'
		WHEN num_area_imovel >= 500 AND num_area_imovel < 1000 THEN '500 a 1.000 ha'
		WHEN num_area_imovel >= 1000 THEN 'superior a 1.000 ha'
	END,
	cod_estado;
