#!/bin/sh



ogr2ogr -f "CSV" procerrado_201605_imoveisMF3.csv PG:"host=host.144 user=user dbname=banco" -sql "SELECT	cod_estado,  nom_municipio, 	mf, 	count(idt_imovel) AS num_maio, sum(num_area_imovel) as area_maio FROM	(SELECT	cod_estado,  m.nom_municipio, idt_imovel, num_area_imovel, 		CASE	WHEN num_modulo_fiscal < 4 THEN '0 a 4 MF' 			WHEN num_modulo_fiscal >= 4  AND num_modulo_fiscal < 15 THEN '4 e 15 MF' 			WHEN num_modulo_fiscal >= 15 THEN 'superior a 15MF' 		END AS mf 	FROM	usr_geocar_aplicacao.imovel i 		INNER JOIN 		usr_geocar_aplicacao.municipio m 		ON i.idt_municipio = m.idt_municipio 	WHERE cod_estado in ('BA','MA','PI','TO') and (flg_ativo = TRUE 	AND ind_status_imovel = 'AT' 	AND dat_criacao < to_date('01/06/2016','dd/mm/yyyy')) )a  GROUP BY cod_estado, nom_municipio ,  	mf ORDER BY cod_estado , nom_municipio, mf;"

ogr2ogr -f "CSV" procerrado_201604_imoveisMF3.csv PG:"host=host.144 user=user dbname=banco" -sql "SELECT	cod_estado,  nom_municipio, 	mf, 	count(idt_imovel) AS num_abril, sum(num_area_imovel) as area_abril FROM	(SELECT	cod_estado,  m.nom_municipio, idt_imovel, num_area_imovel, 		CASE	WHEN num_modulo_fiscal < 4 THEN '0 a 4 MF' 			WHEN num_modulo_fiscal >= 4  AND num_modulo_fiscal < 15 THEN '4 e 15 MF' 			WHEN num_modulo_fiscal >= 15 THEN 'superior a 15MF' 		END AS mf 	FROM	usr_geocar_aplicacao.imovel i 		INNER JOIN 		usr_geocar_aplicacao.municipio m 		ON i.idt_municipio = m.idt_municipio 	WHERE cod_estado in ('BA','MA','PI','TO') and (flg_ativo = TRUE 	AND ind_status_imovel = 'AT' 	AND dat_criacao < to_date('01/05/2016','dd/mm/yyyy'))	)a  GROUP BY cod_estado, nom_municipio ,  	mf ORDER BY cod_estado , nom_municipio, mf;"

ogr2ogr -f "CSV" procerrado_201603_imoveisMF3.csv PG:"host=host.144 user=user dbname=banco" -sql "SELECT	cod_estado,  nom_municipio, 	mf, 	count(idt_imovel) AS num_marco, sum(num_area_imovel) as area_marco FROM	(SELECT	cod_estado,  m.nom_municipio, idt_imovel, num_area_imovel, 		CASE	WHEN num_modulo_fiscal < 4 THEN '0 a 4 MF' 			WHEN num_modulo_fiscal >= 4  AND num_modulo_fiscal < 15 THEN '4 e 15 MF' 			WHEN num_modulo_fiscal >= 15 THEN 'superior a 15MF' 		END AS mf 	FROM	usr_geocar_aplicacao.imovel i 		INNER JOIN 		usr_geocar_aplicacao.municipio m 		ON i.idt_municipio = m.idt_municipio 	WHERE cod_estado in ('BA','MA','PI','TO') and (flg_ativo = TRUE 	AND ind_status_imovel = 'AT' 	AND dat_criacao < to_date('01/04/2016','dd/mm/yyyy'))  )a  GROUP BY cod_estado, nom_municipio ,  	mf ORDER BY cod_estado , nom_municipio, mf;"

ogr2ogr -f "CSV" procerrado_201602_imoveisMF3.csv PG:"host=host.144 user=user dbname=banco" -sql "SELECT	cod_estado,  nom_municipio, 	mf, 	count(idt_imovel) AS num_fevereiro, sum(num_area_imovel) as area_fevereiro FROM	(SELECT	cod_estado,  m.nom_municipio, idt_imovel, num_area_imovel, 		CASE	WHEN num_modulo_fiscal < 4 THEN '0 a 4 MF' 			WHEN num_modulo_fiscal >= 4  AND num_modulo_fiscal < 15 THEN '4 e 15 MF' 			WHEN num_modulo_fiscal >= 15 THEN 'superior a 15MF' 		END AS mf 	FROM	usr_geocar_aplicacao.imovel i 		INNER JOIN 		usr_geocar_aplicacao.municipio m 		ON i.idt_municipio = m.idt_municipio 	WHERE cod_estado in ('BA','MA','PI','TO') and (flg_ativo = TRUE 	AND ind_status_imovel = 'AT' 	AND dat_criacao < to_date('01/03/2016','dd/mm/yyyy'))  )a  GROUP BY cod_estado, nom_municipio , 	mf ORDER BY cod_estado , nom_municipio, mf;"







