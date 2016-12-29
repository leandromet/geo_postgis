--1 - Imóveis por UF em: Nº e Área

SELECT	SUM(CASE 
		WHEN 	CASE 	WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = TRUE THEN ind_status_imovel
				WHEN flg_ativo = FALSE THEN 'AT'
			END
		IN ('AT','PE') THEN 1
		ELSE 0
	END) AS "totalQtdCar",
	SUM(CASE 
		WHEN	CASE 	WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = TRUE THEN ind_status_imovel
				WHEN flg_ativo = FALSE THEN 'AT'
			END
		IN ('AT','PE') THEN i.num_area_imovel
		ELSE 0
	END) AS "totalSomaArea",
	m.cod_estado
FROM	usr_geocar_aplicacao.imovel i, 
	usr_geocar_aplicacao.municipio m
WHERE 	m.idt_municipio = i.idt_municipio
	AND dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
	AND (cod_imovel, dat_criacao) IN 
		(SELECT cod_imovel, max(dat_criacao)
		FROM 	usr_geocar_aplicacao.imovel i		
		WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
		GROUP BY cod_imovel)
GROUP BY m.cod_estado
ORDER BY m.cod_estado;

--2.1 - Imóveis por UF em: Nº de IR por classe de áreas MF

SELECT	CASE	WHEN num_modulo_fiscal < 4 THEN '0 a 4 MF'
		WHEN num_modulo_fiscal >= 4  AND num_modulo_fiscal < 15 THEN '4 e 15 MF'
		WHEN num_modulo_fiscal >= 15 THEN 'superior a 15MF'
	END AS "MF",
	COUNT(*) AS "totalMF",
	cod_estado
FROM	
	(SELECT	CASE 
			WHEN 	CASE 	WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
					WHEN flg_ativo = TRUE THEN ind_status_imovel
					WHEN flg_ativo = FALSE THEN 'AT'
				END
			IN ('AT','PE') THEN num_modulo_fiscal	
		END AS num_modulo_fiscal,
		m.cod_estado
	FROM	usr_geocar_aplicacao.imovel i, 
		usr_geocar_aplicacao.municipio m
	WHERE 	m.idt_municipio = i.idt_municipio
		AND dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
		AND (cod_imovel, dat_criacao) IN 
			(SELECT cod_imovel, max(dat_criacao)
			FROM 	usr_geocar_aplicacao.imovel i		
			WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
			GROUP BY cod_imovel)) a
WHERE	num_modulo_fiscal IS NOT NULL
GROUP BY CASE	WHEN num_modulo_fiscal < 4 THEN '0 a 4 MF'
		WHEN num_modulo_fiscal >= 4  AND num_modulo_fiscal < 15 THEN '4 e 15 MF'
		WHEN num_modulo_fiscal >= 15 THEN 'superior a 15MF'
	END,
	cod_estado
ORDER BY 3, 1;

--2.2 - Imóveis por UF em: Nº de IR por classe de áreas HA

SELECT	CASE	WHEN num_area_imovel < 100 THEN '0 a 100 ha'
		WHEN num_area_imovel >= 100 AND num_area_imovel < 500 THEN '100 a 500 ha'
		WHEN num_area_imovel >= 500 AND num_area_imovel < 1000 THEN '500 a 1.000 ha'
		WHEN num_area_imovel >= 1000 THEN 'superior a 1.000 ha'
	END AS "ClasseArea",
	COUNT(*) AS "totalClasseArea",
	cod_estado
FROM	
	(SELECT	CASE 
			WHEN 	CASE 	WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
					WHEN flg_ativo = TRUE THEN ind_status_imovel
					WHEN flg_ativo = FALSE THEN 'AT'
				END
			IN ('AT','PE') THEN num_area_imovel	
		END AS num_area_imovel,
		m.cod_estado
	FROM	usr_geocar_aplicacao.imovel i, 
		usr_geocar_aplicacao.municipio m
	WHERE 	m.idt_municipio = i.idt_municipio
		AND dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
		AND (cod_imovel, dat_criacao) IN 
			(SELECT cod_imovel, max(dat_criacao)
			FROM 	usr_geocar_aplicacao.imovel i		
			WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
			GROUP BY cod_imovel)) a
WHERE	num_area_imovel IS NOT NULL
GROUP BY CASE	WHEN num_area_imovel < 100 THEN '0 a 100 ha'
		WHEN num_area_imovel >= 100 AND num_area_imovel < 500 THEN '100 a 500 ha'
		WHEN num_area_imovel >= 500 AND num_area_imovel < 1000 THEN '500 a 1.000 ha'
		WHEN num_area_imovel >= 1000 THEN 'superior a 1.000 ha'
	END,
	cod_estado;

--3 - área por UF de: Remanescentes de vegetação nativa

SELECT	SUM(CASE 
		WHEN	CASE 	WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = TRUE THEN ind_status_imovel
				WHEN flg_ativo = FALSE THEN 'AT'
			END
		IN ('AT','PE') THEN rtip.num_area
		ELSE 0
	END) AS "totalSomaAreaVN",
	m.cod_estado
FROM	usr_geocar_aplicacao.imovel i, 
	usr_geocar_aplicacao.municipio m,
	usr_geocar_aplicacao.rel_tema_imovel_poligono rtip
WHERE 	m.idt_municipio = i.idt_municipio
	AND i.idt_imovel = rtip.idt_imovel 
	AND rtip.idt_tema = 2
	AND dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
	AND (cod_imovel, dat_criacao) IN 
		(SELECT cod_imovel, max(dat_criacao)
		FROM 	usr_geocar_aplicacao.imovel i		
		WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
		GROUP BY cod_imovel)
GROUP BY m.cod_estado
ORDER BY m.cod_estado;

--4 - área por UF de: Reserva Legal

SELECT	SUM(CASE 
		WHEN	CASE 	WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = TRUE THEN ind_status_imovel
				WHEN flg_ativo = FALSE THEN 'AT'
			END
		IN ('AT','PE') THEN rtip.num_area
		ELSE 0
	END) AS "totalSomaAreaRL",
	m.cod_estado
FROM	usr_geocar_aplicacao.imovel i, 
	usr_geocar_aplicacao.municipio m,
	usr_geocar_aplicacao.rel_tema_imovel_poligono rtip
WHERE 	m.idt_municipio = i.idt_municipio
	AND i.idt_imovel = rtip.idt_imovel 
	AND rtip.idt_tema = 32
	AND dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
	AND (cod_imovel, dat_criacao) IN 
		(SELECT cod_imovel, max(dat_criacao)
		FROM 	usr_geocar_aplicacao.imovel i		
		WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
		GROUP BY cod_imovel)
GROUP BY m.cod_estado
ORDER BY m.cod_estado;

--5 - área por UF de: APP

SELECT	SUM(CASE 
		WHEN	CASE 	WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = TRUE THEN ind_status_imovel
				WHEN flg_ativo = FALSE THEN 'AT'
			END
		IN ('AT','PE') THEN rtip.num_area
		ELSE 0
	END) AS "totalSomaAreaAPP",
	m.cod_estado
FROM	usr_geocar_aplicacao.imovel i, 
	usr_geocar_aplicacao.municipio m,
	usr_geocar_aplicacao.rel_tema_imovel_poligono rtip
WHERE 	m.idt_municipio = i.idt_municipio
	AND i.idt_imovel = rtip.idt_imovel 
	AND rtip.idt_tema = 30
	AND dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
	AND (cod_imovel, dat_criacao) IN 
		(SELECT cod_imovel, max(dat_criacao)
		FROM 	usr_geocar_aplicacao.imovel i		
		WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
		GROUP BY cod_imovel)
GROUP BY m.cod_estado
ORDER BY m.cod_estado;

--6 - área por UF de: APP com Vegetação

SELECT	SUM(CASE 
		WHEN	CASE 	WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = TRUE THEN ind_status_imovel
				WHEN flg_ativo = FALSE THEN 'AT'
			END
		IN ('AT','PE') THEN ST_Area(ST_Transform(ST_Intersection_Error(rtip.the_geom, rtip2.the_geom), usr_geocar_aplicacao.utmzone(ST_Centroid(i.geo_area_imovel)))) / 10000
		ELSE 0
	END) AS "totalSomaAreaAPPVN",
	m.cod_estado
FROM	usr_geocar_aplicacao.imovel i
	LEFT OUTER JOIN
	usr_geocar_aplicacao.municipio m
	ON m.idt_municipio = i.idt_municipio
	LEFT OUTER JOIN
	usr_geocar_aplicacao.rel_tema_imovel_poligono rtip
	ON i.idt_imovel = rtip.idt_imovel 
	AND rtip.idt_tema = 30
	LEFT OUTER JOIN
	usr_geocar_aplicacao.rel_tema_imovel_poligono rtip2
	ON i.idt_imovel = rtip2.idt_imovel 
	AND rtip2.idt_tema = 2
	AND ST_Intersects(rtip.the_geom, rtip2.the_geom)
WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
	AND (cod_imovel, dat_criacao) IN 
		(SELECT cod_imovel, max(dat_criacao)
		FROM 	usr_geocar_aplicacao.imovel i		
		WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
		GROUP BY cod_imovel)
GROUP BY m.cod_estado
ORDER BY m.cod_estado;

--7 - área por UF de: RL com Vegetação

SELECT	SUM(CASE 
		WHEN	CASE 	WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = TRUE THEN ind_status_imovel
				WHEN flg_ativo = FALSE THEN 'AT'
			END
		IN ('AT','PE') THEN ST_Area(ST_Transform(ST_Intersection_Error(rtip.the_geom, rtip2.the_geom), usr_geocar_aplicacao.utmzone(ST_Centroid(i.geo_area_imovel)))) / 10000
		ELSE 0
	END) AS "totalSomaAreaRLVN",
	m.cod_estado
FROM	usr_geocar_aplicacao.imovel i
	LEFT OUTER JOIN
	usr_geocar_aplicacao.municipio m
	ON m.idt_municipio = i.idt_municipio
	LEFT OUTER JOIN
	usr_geocar_aplicacao.rel_tema_imovel_poligono rtip
	ON i.idt_imovel = rtip.idt_imovel 
	AND rtip.idt_tema = 32
	LEFT OUTER JOIN
	usr_geocar_aplicacao.rel_tema_imovel_poligono rtip2
	ON i.idt_imovel = rtip2.idt_imovel 
	AND rtip2.idt_tema = 2
	AND ST_Intersects(rtip.the_geom, rtip2.the_geom)
WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
	AND (cod_imovel, dat_criacao) IN 
		(SELECT cod_imovel, max(dat_criacao)
		FROM 	usr_geocar_aplicacao.imovel i		
		WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
		GROUP BY cod_imovel)
GROUP BY m.cod_estado
ORDER BY m.cod_estado;

--8 - Assentamentos por UF: assentados; assentamentos; área;
--Query para total e area e numero de assentados por estado

SELECT	SUM(CASE
                WHEN    CASE    WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
                                WHEN flg_ativo = TRUE THEN ind_status_imovel
                                WHEN flg_ativo = FALSE THEN 'AT'
                        END
                IN ('AT','PE') THEN qtd_pessoa_imovel.totalAssentados
                ELSE 0
        END) AS "totalAssentados",
	SUM(CASE
                WHEN    CASE    WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
                                WHEN flg_ativo = TRUE THEN ind_status_imovel
                                WHEN flg_ativo = FALSE THEN 'AT'
                        END
                IN ('AT','PE') THEN 1
                ELSE 0
        END) AS "totalQtdAssentamento",
	SUM(CASE
                WHEN    CASE    WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
                                WHEN flg_ativo = TRUE THEN ind_status_imovel
                                WHEN flg_ativo = FALSE THEN 'AT'
                        END
                IN ('AT','PE') THEN i.num_area_imovel
                ELSE 0
        END) AS "totalSomaArea",
        m.cod_estado
FROM    usr_geocar_aplicacao.imovel i,
        usr_geocar_aplicacao.municipio m,
        (SELECT	count(*) AS totalAssentados, 
		idt_imovel
        FROM 	usr_geocar_aplicacao.imovel_pessoa
        GROUP BY idt_imovel) qtd_pessoa_imovel
WHERE   m.idt_municipio = i.idt_municipio
        AND qtd_pessoa_imovel.idt_imovel = i.idt_imovel
        AND dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
        AND (cod_imovel, dat_criacao) IN
                (SELECT cod_imovel, max(dat_criacao)
                FROM    usr_geocar_aplicacao.imovel i
                WHERE   dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
			AND ind_tipo_imovel = 'AST'
                GROUP BY cod_imovel)
GROUP BY m.cod_estado
ORDER BY m.cod_estado;

--9 - Adesão ao PRA por UF: Nº

SELECT	SUM(CASE 
		WHEN 	CASE 	WHEN flg_ativo = TRUE AND dat_atualizacao > to_date('01/01/2016','dd/mm/yyyy') THEN 'AT'
				WHEN flg_ativo = TRUE THEN ind_status_imovel
				WHEN flg_ativo = FALSE THEN 'AT'
			END
		IN ('AT','PE') THEN 1
		ELSE 0
	END) AS "totalQtdCar",
	m.cod_estado
FROM	usr_geocar_aplicacao.imovel i, 
	usr_geocar_aplicacao.municipio m,
	usr_geocar_aplicacao.resposta_imovel ri
WHERE 	m.idt_municipio = i.idt_municipio
	AND i.idt_imovel = ri.idt_imovel
	AND ri.idt_resposta_pergunta = 1
	AND dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
	AND (cod_imovel, dat_criacao) IN 
		(SELECT cod_imovel, max(dat_criacao)
		FROM 	usr_geocar_aplicacao.imovel i		
		WHERE 	dat_criacao < to_date('01/01/2016','dd/mm/yyyy')
		GROUP BY cod_imovel)
GROUP BY m.cod_estado
ORDER BY m.cod_estado;
