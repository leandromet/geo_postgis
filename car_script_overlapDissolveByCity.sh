#!/bin/sh


while read line 
	do 

	echo $line

	ogr2ogr -append -f "PostgreSQL" PG:"host=host.116 user=user dbname=car_nacional4 active_schema=sfb_result"  PG:"host=host.116 user=user dbname=car_nacional4" -sql " SELECT m.idt_municipio, p.ogc_fid as id1, n.ogc_fid as id2 , CASE     WHEN ST_CoveredBy(p.wkb_geometry, n.wkb_geometry)     THEN ST_Multi(ST_Intersection(m.geo_localizacao,(ST_Dump(p.wkb_geometry)).geom))    ELSE      ST_Multi(ST_Intersection(m.geo_localizacao, (ST_Dump(       ST_Intersection(p.wkb_geometry,n.wkb_geometry))).geom)       ) END AS geom   FROM sfb_result.sicar_temas_20160302 AS p  INNER JOIN usr_geocar_aplicacao.municipio m ON idt_municipio=$line AND m.geo_localizacao && p.wkb_geometry AND ST_Intersects(m.geo_localizacao,p.wkb_geometry) 	INNER JOIN   sfb_result.sicar_temas_20160302 AS n      ON  p.idt_tema = 2 AND  n.idt_tema = 32 AND p.idt_imovel=n.idt_imovel and ST_Dimension(p.wkb_geometry)=2 and ST_Dimension(n.wkb_geometry) =2 and ST_IsValid(p.wkb_geometry) and ST_IsValid(n.wkb_geometry)   AND (ST_Intersects(p.wkb_geometry, n.wkb_geometry)        AND NOT ST_Touches(p.wkb_geometry, n.wkb_geometry) )" -nln sicar_int_rl_vn | sed 's/ /_/g' | sed 's/%/_/g'


	ogr2ogr -append -f "PostgreSQL" PG:"host=host.116 user=user dbname=car_nacional4 active_schema=sfb_result"  PG:"host=host.116 user=user dbname=car_nacional4" -sql " SELECT m.idt_municipio, p.ogc_fid as id1, n.ogc_fid as id2 , CASE     WHEN ST_CoveredBy(p.wkb_geometry, n.wkb_geometry)     THEN ST_Multi(ST_Intersection(m.geo_localizacao,(ST_Dump(p.wkb_geometry)).geom))    ELSE      ST_Multi(ST_Intersection(m.geo_localizacao, (ST_Dump(       ST_Intersection(p.wkb_geometry,n.wkb_geometry))).geom)       ) END AS geom   FROM sfb_result.sicar_temas_20160302 AS p  INNER JOIN usr_geocar_aplicacao.municipio m ON idt_municipio=$line AND m.geo_localizacao && p.wkb_geometry AND ST_Intersects(m.geo_localizacao,p.wkb_geometry) 	INNER JOIN   sfb_result.sicar_temas_20160302 AS n      ON  p.idt_tema = 2 AND  n.idt_tema = 31 AND p.idt_imovel=n.idt_imovel and ST_Dimension(p.wkb_geometry)=2 and ST_Dimension(n.wkb_geometry) =2 and ST_IsValid(p.wkb_geometry) and ST_IsValid(n.wkb_geometry)   AND (ST_Intersects(p.wkb_geometry, n.wkb_geometry)        AND NOT ST_Touches(p.wkb_geometry, n.wkb_geometry) )" -nln sicar_int_app_vn | sed 's/ /_/g' | sed 's/%/_/g'

	ogr2ogr -append -f "PostgreSQL" PG:"host=host.116 user=user dbname=car_nacional4 active_schema=sfb_result"  PG:"host=host.116 user=user dbname=car_nacional4" -sql " SELECT m.idt_municipio, p.ogc_fid as id1, n.ogc_fid as id2 , CASE     WHEN ST_CoveredBy(p.wkb_geometry, n.wkb_geometry)     THEN ST_Multi(ST_Intersection(m.geo_localizacao,(ST_Dump(p.wkb_geometry)).geom))    ELSE      ST_Multi(ST_Intersection(m.geo_localizacao, (ST_Dump(       ST_Intersection(p.wkb_geometry,n.wkb_geometry))).geom)       ) END AS geom   FROM sfb_result.sicar_temas_20160302 AS p  INNER JOIN usr_geocar_aplicacao.municipio m ON idt_municipio=$line AND m.geo_localizacao && p.wkb_geometry AND ST_Intersects(m.geo_localizacao,p.wkb_geometry) 	INNER JOIN   sfb_result.sicar_temas_20160302 AS n      ON  p.idt_tema = 26 AND  n.idt_tema = 26 AND p.idt_imovel>n.idt_imovel and ST_Dimension(p.wkb_geometry)=2 and ST_Dimension(n.wkb_geometry) =2 and ST_IsValid(p.wkb_geometry) and ST_IsValid(n.wkb_geometry)   AND (ST_Intersects(p.wkb_geometry, n.wkb_geometry)        AND NOT ST_Touches(p.wkb_geometry, n.wkb_geometry) )" -nln sicar_sobrep_imov | sed 's/ /_/g' | sed 's/%/_/g'




done < /sfb/DADOS/car/municipios/cod_mun.txt
