


create table dissolve_imovel_munic_BR_15MF as SELECT m.cod_estado, m.idt_municipio,
 m.nom_municipio, sum(i.num_area_imovel) as AreaOrig, count(i.idt_imovel) as imoveis, ST_Union(i.geo_area_imovel)
FROM 
  "usr_geocar_aplicacao"."imovel" i
INNER JOIN
  "usr_geocar_aplicacao"."municipio" m 
ON
  m.cod_estado in ('DF', 'GO', 'TO', 'MA') AND
  i.flg_ativo=TRUE AND 
  i.ind_status_imovel = 'AT'AND
  i.num_modulo_fiscal > 15 AND
  i.num_area_imovel < 2000000 AND
  i.num_modulo_fiscal < 3000
  i.geo_area_imovel && m.geo_localizacao AND
  ST_Intersects (i.geo_area_imovel, m.geo_localizacao )
GROUP BY m.cod_estado, m.idt_municipio;



---intersecção municipios e imoveis


create table brasil_intersect as SELECT 
  municipio.cod_estado,
  municipio.idt_municipio,
  imovel_jan2016.gid,
  imovel_jan2016.cod_imovel, 
  imovel_jan2016.ind_status, 
  imovel_jan2016.ind_tipo_i, 
  imovel_jan2016.nom_imovel, 
  imovel_jan2016.num_fracao,  
  imovel_jan2016.num_modulo, 
  imovel_jan2016.dat_criaca,  
  ST_MakeValid(ST_Intersection(ST_MakeValid(imovel_jan2016.shape), ST_MakeValid(municipio.geo_localizacao)))

FROM 
  usr_geocar_aplicacao.imovel_jan2016, 
  usr_geocar_aplicacao.municipio
  WHERE ST_IsValid( municipio.geo_localizacao) AND ST_IsValid(imovel_jan2016.shape) AND municipio.geo_localizacao&&imovel_jan2016.shape AND ST_Intersects(municipio.geo_localizacao,imovel_jan2016.shape);



--- Brasil por modulo e tipo
create table dissolve_imovel_munic_BR AS 
SELECT	cod_estado, nom_municipio, sum(num_area_imovel) as AreaOrig, count(distinct(idt_imovel)) as imoveis, count(cod_cpf_cnpj) as pessoas, ST_Union(geo_area_imovel),
	ind_tipo_imovel as tipo,
	mf
	
FROM	(SELECT	p.cod_cpf_cnpj, m.cod_estado, m.idt_municipio, m.nom_municipio, num_area_imovel, i.idt_imovel, geo_area_imovel,ind_tipo_imovel,
		CASE	WHEN num_modulo_fiscal <= 4 THEN '0a4MF'
			WHEN num_modulo_fiscal > 4  AND num_modulo_fiscal <= 15 THEN '4a15MF'
			WHEN num_modulo_fiscal > 15 AND num_modulo_fiscal <= 1000 THEN 'sup15MF'
			WHEN num_modulo_fiscal > 15 AND num_modulo_fiscal > 1000 THEN 'sup1000MF'
		END AS mf
	FROM	usr_geocar_aplicacao.imovel_pessoa p,usr_geocar_aplicacao.imovel i
		INNER JOIN
		usr_geocar_aplicacao.municipio m
		ON i.idt_municipio = m.idt_municipio
	AND flg_ativo = TRUE
	AND ind_status_imovel = 'AT'
	WHERE p.idt_imovel = i.idt_imovel)a

GROUP BY cod_estado,nom_municipio, tipo,
	mf
ORDER BY cod_estado,nom_municipio, tipo,
	mf;

---- Apenas municipios


create table dissolve_municipios_br as SELECT 
  dissolve_imovel_munic_br.cod_estado, 
  dissolve_imovel_munic_br.nom_municipio, 
  sum(dissolve_imovel_munic_br.areaorig) as areaorig, 
  sum(dissolve_imovel_munic_br.imoveis) as imoveis, 
  sum(dissolve_imovel_munic_br.pessoas) as pessoas, 
  ST_Union(dissolve_imovel_munic_br.st_union) as geom
FROM 
  public.dissolve_imovel_munic_br WHERE mf !='sup1000MF'
  group by   dissolve_imovel_munic_br.cod_estado, 
  dissolve_imovel_munic_br.nom_municipio;


--- Temas por municipio


SELECT    rel_tema_imovel_poligono.idt_tema, ST_Union(rel_tema_imovel_poligono.the_geom) as geom,    sum(rel_tema_imovel_poligono.num_area),    count(distinct(rel_tema_imovel_poligono.idt_imovel)),       municipio.nom_municipio,    municipio.cod_estado 
FROM    usr_geocar_aplicacao.imovel,usr_geocar_aplicacao.tema,usr_geocar_aplicacao.rel_tema_imovel_poligono,usr_geocar_aplicacao.municipio


group by cod_estado, nom_municipio, rel_tema_imovel_poligono.idt_tema

order by  cod_estado, nom_municipio, rel_tema_imovel_poligono.idt_tema;






create table dissolve_imovel_munic_BR_teste AS 
SELECT	cod_estado, nom_municipio, sum(num_area_imovel) as AreaOrig, count(distinct(idt_imovel)) as imoveis, count(cod_cpf_cnpj) as pessoas, ST_Union(geo_area_imovel),
	ind_tipo_imovel as tipo,
	mf
	
FROM	(SELECT	p.cod_cpf_cnpj, m.cod_estado, m.idt_municipio, m.nom_municipio, num_area_imovel, i.idt_imovel, geo_area_imovel,ind_tipo_imovel,
		CASE	WHEN num_modulo_fiscal <= 4 THEN '0a4MF'
			WHEN num_modulo_fiscal > 4  AND num_modulo_fiscal <= 15 THEN '4a15MF'
			WHEN num_modulo_fiscal > 15 AND num_modulo_fiscal <= 1000 THEN 'sup15MF'
			WHEN num_modulo_fiscal > 15 AND num_modulo_fiscal > 1000 THEN 'sup1000MF'
		END AS mf
	FROM	usr_geocar_aplicacao.imovel_pessoa p,usr_geocar_aplicacao.imovel i
		INNER JOIN
		usr_geocar_aplicacao.municipio m
		ON i.idt_municipio = m.idt_municipio
	AND m.cod_estado in ('DF', 'GO', 'TO', 'MA')
	AND flg_ativo = TRUE
	AND ind_status_imovel = 'AT'
	WHERE p.idt_imovel = i.idt_imovel)a

GROUP BY cod_estado,nom_municipio, tipo,
	mf
ORDER BY cod_estado,nom_municipio, tipo,
	mf;


  
