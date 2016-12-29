
--Imoveis

SELECT	cod_estado,
	ind_tipo_imovel as tipo,
	count(idt_imovel) AS numero_total,
	sum(num_area_imovel) as area_total
FROM	usr_geocar_aplicacao.imovel i
	INNER JOIN
	usr_geocar_aplicacao.municipio m
	ON i.idt_municipio = m.idt_municipio
WHERE 	(flg_ativo = TRUE
	AND ind_status_imovel = 'AT'
	AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy'))
	OR (ind_status_imovel != 'AT' AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy') AND dat_atualizacao>= to_date('01/02/2016','dd/mm/yyyy'))
GROUP BY cod_estado, tipo
ORDER BY cod_estado, tipo;


-- Assentados


SELECT	cod_estado,
	count(p.cod_cpf_cnpj) AS Assentados
FROM	usr_geocar_aplicacao.imovel_pessoa p,
	usr_geocar_aplicacao.imovel i
	INNER JOIN
	usr_geocar_aplicacao.municipio m
	ON i.idt_municipio = m.idt_municipio
WHERE 	
	p.idt_imovel = i.idt_imovel AND
	((flg_ativo = TRUE
	AND ind_status_imovel = 'AT'AND i.ind_tipo_imovel = 'AST'
	AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy'))
	OR (ind_status_imovel != 'AT'AND i.ind_tipo_imovel = 'AST'
	 AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy') AND dat_atualizacao>= to_date('01/02/2016','dd/mm/yyyy')))
GROUP BY cod_estado
ORDER BY cod_estado;

--- Perfil imovel


﻿--3.3) por classes de área (0 a 100 ha; 100 a 500 ha; 500 a 1.000 ha; e superior a 1.000 ha)

--Total - Considera todos tipos de imóveis (Imóvel rural, Imóvel rural de povos e comunidades tradicionais, Imóvel rural de assentamento da reforma agrária)
SELECT	cod_estado,
	ind_tipo_imovel as tipo,
	classe_area,
	count(*) AS numero_total
FROM	(SELECT	cod_estado,
		CASE	WHEN num_area_imovel < 100 THEN '0 a 100 ha'
			WHEN num_area_imovel >= 100 AND num_modulo_fiscal < 500 THEN '100 a 500 ha'
			WHEN num_area_imovel >= 500 AND num_modulo_fiscal < 1000 THEN '500 a 1.000 ha'
			WHEN num_area_imovel >= 1000 THEN 'superior a 1.000 ha'
		END AS classe_area
	FROM	usr_geocar_aplicacao.imovel i
		INNER JOIN
		usr_geocar_aplicacao.municipio m
		ON i.idt_municipio = m.idt_municipio
	WHERE 	(flg_ativo = TRUE
	AND ind_status_imovel = 'AT'
	AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy'))
	OR (ind_status_imovel != 'AT' AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy') AND dat_atualizacao>= to_date('01/02/2016','dd/mm/yyyy')) )a
GROUP BY cod_estado,
	classe_area
ORDER BY cod_estado,
	classe_area;



﻿--3.1) Perfil dos IR cadastrados (BR, Região e UFs) 
--por classes de Módulos Fiscais (0 a 4 MF; entre 4 e 15 MF; e superior a 15MF)

--Total - Considera todos tipos de imóveis (Imóvel rural, Imóvel rural de povos e comunidades tradicionais, Imóvel rural de assentamento da reforma agrária)
SELECT	cod_estado,
	ind_tipo_imovel as tipo,
	mf,
	count(*) AS numero_total
FROM	(SELECT	cod_estado,
		CASE	WHEN num_modulo_fiscal < 4 THEN '0 a 4 MF'
			WHEN num_modulo_fiscal >= 4  AND num_modulo_fiscal < 15 THEN '4 e 15 MF'
			WHEN num_modulo_fiscal >= 15 THEN 'superior a 15MF'
		END AS mf
	FROM	usr_geocar_aplicacao.imovel i
		INNER JOIN
		usr_geocar_aplicacao.municipio m
		ON i.idt_municipio = m.idt_municipio
	WHERE 	(flg_ativo = TRUE
	AND ind_status_imovel = 'AT'
	AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy'))
	OR (ind_status_imovel != 'AT' AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy') AND dat_atualizacao>= to_date('01/02/2016','dd/mm/yyyy')) )a

GROUP BY cod_estado, tipo,
	mf
ORDER BY cod_estado, tipo,
	mf;








﻿--6.1) Área total de APP cadastrada (BR, Região e UFs)

--Total - Considera todos tipos de imóveis (Imóvel rural, Imóvel rural de povos e comunidades tradicionais, Imóvel rural de assentamento da reforma agrária)
SELECT	cod_estado,
	ind_tipo_imovel as tipo,
	SUM(rtip.num_area) AS area_total
FROM	usr_geocar_aplicacao.imovel i
	INNER JOIN
	usr_geocar_aplicacao.municipio m
	ON i.idt_municipio = m.idt_municipio
	INNER JOIN
	usr_geocar_aplicacao.rel_imovel_app_uso_restrito rtip
	ON i.idt_imovel = rtip.idt_imovel
WHERE 	(flg_ativo = TRUE
	AND ind_status_imovel = 'AT' AND idt_tema = 30
	AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy'))
	OR (ind_status_imovel = 'RE' AND idt_tema = 30 AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy') AND dat_atualizacao>= to_date('01/02/2016','dd/mm/yyyy'))
GROUP BY cod_estado, tipo
ORDER BY cod_estado, tipo;




--Remanescente em APP total


SELECT	cod_estado,
	SUM(ST_Area(ST_Transform(ST_Intersection_Error(rtip1.the_geom, rtip2.the_geom), usr_geocar_aplicacao.utmzone(ST_Centroid(i.geo_area_imovel)))) / 10000) / SUM(rtip1.num_area) AS porcentagem
FROM	usr_geocar_aplicacao.imovel i
	LEFT OUTER JOIN
	usr_geocar_aplicacao.municipio m
	ON i.idt_municipio = m.idt_municipio
	LEFT OUTER JOIN
	(SELECT	*
	FROM	usr_geocar_aplicacao.rel_imovel_app_uso_restrito
	WHERE	idt_tema = 30)rtip1
	ON i.idt_imovel = rtip1.idt_imovel
	LEFT OUTER JOIN
	(SELECT	*
	FROM	usr_geocar_aplicacao.rel_imovel_cobertura_solo
	WHERE	idt_tema = 2) rtip2
	ON  i.idt_imovel = rtip2.idt_imovle AND ST_IsValid(rtip2.the_geom) AND ST_IsValid(rtip1.the_geom)
	AND ST_Intersects(rtip1.the_geom, rtip2.the_geom)
WHERE 	
	((flg_ativo = TRUE
	AND ind_status_imovel = 'AT'AND i.ind_tipo_imovel = 'AST'
	AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy'))
	OR (ind_status_imovel != 'AT'AND i.ind_tipo_imovel = 'AST'
	 AND dat_criacao < to_date('01/02/2016','dd/mm/yyyy') AND dat_atualizacao>= to_date('01/02/2016','dd/mm/yyyy')))
GROUP BY cod_estado
ORDER BY cod_estado;
