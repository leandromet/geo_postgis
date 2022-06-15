#!/bin/sh




ogr2ogr -f "CSV" mirim_20161209_imovel.csv PG:"host=host.144 user=usuario dbname=db" -sql "SELECT SUM(CASE    WHEN  CASE  WHEN flg_ativo = true AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') THEN 'AT'     WHEN flg_ativo = true THEN ind_status_imovel     WHEN flg_ativo = false AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') THEN 'AT'    END   IN ('AT','PE') THEN 1   ELSE 0  END) AS totalQtdCar,  SUM(CASE    WHEN  CASE  WHEN flg_ativo = true AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') THEN 'AT'     WHEN flg_ativo = true THEN ind_status_imovel     WHEN flg_ativo = false AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') THEN 'AT'    END   IN ('AT','PE') THEN i.num_area_imovel   ELSE 0  END) AS totalSomaArea,  m.cod_estado FROM  usr_geocar_aplicacao.imovel i,   usr_geocar_aplicacao.municipio m WHERE m.idt_municipio=1100106 and  m.idt_municipio = i.idt_municipio  AND ((dat_criacao < to_date('09/12/2016','dd/mm/yyyy') AND ind_status_imovel IN ('AT','PE'))   OR (( (cod_imovel, dat_criacao) IN    (SELECT cod_imovel, max(dat_criacao)   FROM   usr_geocar_aplicacao.imovel i     WHERE  ind_status_imovel IN ('CA','RE') AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') AND dat_criacao < to_date('09/12/2016','dd/mm/yyyy')   GROUP BY cod_imovel)))) GROUP BY m.cod_estado ORDER BY m.cod_estado;"



 ogr2ogr -f "CSV" mirim_20161209_imovel_tipo_imovel.csv PG:"host=host.144 user=usuario dbname=db" -sql "SELECT SUM(CASE    WHEN  CASE  WHEN flg_ativo = true AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') THEN 'AT'     WHEN flg_ativo = true THEN ind_status_imovel     WHEN flg_ativo = false AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') THEN 'AT'    END   IN ('AT','PE') THEN 1   ELSE 0  END) AS totalQtdCar,  SUM(CASE    WHEN  CASE  WHEN flg_ativo = true AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') THEN 'AT'     WHEN flg_ativo = true THEN ind_status_imovel     WHEN flg_ativo = false AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') THEN 'AT'    END   IN ('AT','PE') THEN i.num_area_imovel   ELSE 0  END) AS totalSomaArea, i.ind_tipo_imovel,  m.cod_estado FROM  usr_geocar_aplicacao.imovel i,   usr_geocar_aplicacao.municipio m WHERE  m.idt_municipio=1100106 and  m.idt_municipio = i.idt_municipio  AND ((dat_criacao < to_date('09/12/2016','dd/mm/yyyy') AND ind_status_imovel IN ('AT','PE'))   OR (( (cod_imovel, dat_criacao) IN    (SELECT cod_imovel, max(dat_criacao)   FROM   usr_geocar_aplicacao.imovel i     WHERE  ind_status_imovel IN ('CA','RE') AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') AND dat_criacao < to_date('09/12/2016','dd/mm/yyyy')   GROUP BY cod_imovel)))) GROUP BY  m.cod_estado, i.ind_tipo_imovel ORDER BY m.cod_estado, i.ind_tipo_imovel;" 
  
 
 ogr2ogr -f "CSV" mirim_20161209_assentados.csv PG:"host=host.144 user=usuario dbname=db" -sql "SELECT cod_estado, ind_tipo_imovel, count(p.cod_cpf_cnpj) AS Assentados FROM usr_geocar_aplicacao.imovel_pessoa p,  usr_geocar_aplicacao.imovel i  INNER JOIN  usr_geocar_aplicacao.municipio m  ON i.idt_municipio = m.idt_municipio WHERE m.idt_municipio=1100106 and i.ind_tipo_imovel IN ('AST', 'PCT')   AND p.idt_imovel = i.idt_imovel AND m.idt_municipio = i.idt_municipio  AND ((dat_criacao < to_date('09/12/2016','dd/mm/yyyy') AND flg_ativo = true AND ind_status_imovel IN ('AT','PE'))   OR (( (cod_imovel, dat_criacao) IN    (SELECT cod_imovel, max(dat_criacao)   FROM   usr_geocar_aplicacao.imovel i     WHERE  m.idt_municipio=1100106 and i.ind_tipo_imovel IN ('AST', 'PCT')  AND ind_status_imovel IN ('CA','RE') AND dat_atualizacao >= to_date('09/12/2016','dd/mm/yyyy') AND dat_criacao < to_date('09/12/2016','dd/mm/yyyy')   GROUP BY cod_imovel)))) GROUP BY m.cod_estado, ind_tipo_imovel ORDER BY m.cod_estado;"


ogr2ogr -f "CSV" mirim_20161209_imoveisMF.csv PG:"host=host.144 user=usuario dbname=db" -sql "SELECT	cod_estado, 	mf, 	count(idt_imovel) AS numero_total, sum(num_area_imovel) as area FROM	(SELECT	cod_estado, idt_imovel, num_area_imovel, 		CASE	WHEN num_modulo_fiscal < 4 THEN '0 a 4 MF' 			WHEN num_modulo_fiscal >= 4  AND num_modulo_fiscal < 15 THEN '4 e 15 MF' 			WHEN num_modulo_fiscal >= 15 THEN 'superior a 15MF' 		END AS mf 	FROM	usr_geocar_aplicacao.imovel i 		INNER JOIN 		usr_geocar_aplicacao.municipio m 		ON i.idt_municipio = m.idt_municipio 	WHERE  m.idt_municipio=1100106 and 	(flg_ativo = TRUE 	AND ind_status_imovel = 'AT' 	AND dat_criacao < to_date('09/12/2016','dd/mm/yyyy')) 	OR (ind_status_imovel != 'AT' AND dat_criacao < to_date('09/12/2016','dd/mm/yyyy') AND dat_atualizacao>= to_date('09/12/2016','dd/mm/yyyy')) )a  GROUP BY cod_estado, 	mf ORDER BY cod_estado, 	mf;"










