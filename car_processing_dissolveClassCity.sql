
create table sfb_result.imovel_intersect_munic as SELECT 
  municipio.cod_estado,
  municipio.idt_municipio,
  count(distinct i.idt_imovel),
  sum(i.num_area_imovel)  OVER (ORDER BY i.idt_imovel DESC) as area_antiga,
  i.idt_imovel, 
  ST_Union(ST_MakeValid(ST_Intersection(ST_MakeValid(i.wkb_geometry), ST_MakeValid(m.geo_localizacao))))
FROM 
  sfb_result.sicar_temas_20160302 i,
  usr_geocar_aplicacao.municipio m
  WHERE idt_municipio=$line AND i.idt_tema = 26 AND ST_IsValid( m.geo_localizacao) AND ST_IsValid(i.wkb_geometry) AND m.geo_localizacao&&i.wkb_geometry AND ST_Intersects(m.geo_localizacao,i.wkb_geometry);


--- Intersection RL e VN

SELECT p.ogc_fid as id1, n.ogc_fid as id2 , 
CASE     WHEN ST_CoveredBy(p.wkb_geometry, n.wkb_geometry)     
THEN ST_Multi(p.wkb_geometry)    
ELSE      ST_Multi(       ST_Intersection(p.wkb_geometry,n.wkb_geometry)       ) END AS geom   
FROM sfb_result.sicar_temas_20160302 AS p  	
INNER JOIN   sfb_result.sicar_temas_20160302 AS n      ON p.ogc_fid<2000 
and ST_IsValid(p.wkb_geometry) and ST_IsValid(n.wkb_geometry) and ST_Dimension(p.wkb_geometry)=2 and ST_Dimension(n.wkb_geometry) =2
AND p.idt_tema = 2 AND  n.idt_tema = 32 AND (ST_Intersects(p.wkb_geometry, n.wkb_geometry)
 AND NOT ST_Touches(p.wkb_geometry, n.wkb_geometry) )



CREATE TABLE sfb_result.sicar_temas_RL_VN AS (
SELECT m.idt_municipio, ST_Union(ST_Intersection(part_1.wkb_geometry, part_2.wkb_geometry))
 FROM sfb_result.sicar_temas_20160302 part_1 INNER JOIN usr_geocar_aplicacao.municipio m ON
	idt_municipio=$line AND part_1.idt_tema = 32 
	AND ST_IsValid( m.geo_localizacao) AND ST_IsValid(part_1.wkb_geometry) 
	AND m.geo_localizacao && part_1.wkb_geometry AND ST_Intersects(m.geo_localizacao,part_1.wkb_geometry)  INNER JOIN
      sfb_result.sicar_temas_20160302 part_2 ON
	 part_2.idt_tema = 2 AND part_1.wkb_geometry && part_2.wkb_geometry
	  AND ST_Intersects(part_1.wkb_geometry, part_2.wkb_geometry)
  group by m.idt_municipio
);



SELECT p.ogc_fid, n.ogc_fid
 , CASE 
   WHEN ST_CoveredBy(p.wkb_geometry, n.wkb_geometry) 
   THEN p.wkb_geometry 
   ELSE 
    ST_Multi(
      ST_Intersection(p.geom,n.geom)
      ) END AS geom 
 FROM sfb_result.sicar_temas_20160302 AS p 
	INNER JOIN usr_geocar_aplicacao.municipio m ON
	idt_municipio=$line
   INNER JOIN result.sicar_temas_20160302 AS n 
    ON  ST_IsValid(p.wkb_geometry) and ST_IsValid(n.wkb_geometry)  part_2.idt_tema = 2 AND  part_1.idt_tema = 32 AND (ST_Intersects(p.wkb_geometry, n.wkb_geometry) 
      AND NOT ST_Touches(p.wkb_geometry, n.wkb_geometry) );







CREATE TABLE sfb_result.sicar_temas_APP_VN AS (
SELECT part_1.idt_imovel, 
ST_Union(ST_MakeValid(ST_Intersection(ST_MakeValid(part_1.wkb_geometry), ST_MakeValid(part_2.wkb_geometry))))
 FROM sfb_result.sicar_temas_20160302 AS part_1,
      sfb_result.sicar_temas_20160302 AS part_2
WHERE part_1.idt_tema = 31 AND part_2.idt_tema = 2 
AND  ST_IsValid(part_1.wkb_geometry) 
AND  ST_IsValid(part_2.wkb_geometry)
AND part_1.wkb_geometry && part_2.wkb_geometry
AND ST_Intersects(part_1.wkb_geometry, part_2.wkb_geometry)
 
  
  group by part_1.idt_imovel
);



#!/bin/sh
counter=1
while read line 
	do 
	echo $counter
	counter=$((counter+1))
	echo $line
		ogr2ogr -append -f "PostgreSQL" PG:"host=host.116 user=adm dbname=car_nacional4 active_schema=sfb_result"  PG:"host=host.116 user=adm dbname=car_nacional4" -sql " SELECT m.idt_municipio, part_1.idt_imovel, part_1.wkb_geometry, ST_Union(ST_3DIntersection(ST_MakeValid(part_1.wkb_geometry), ST_MakeValid(part_2.wkb_geometry)))  FROM sfb_result.sicar_temas_20160302 part_1 INNER JOIN usr_geocar_aplicacao.municipio m ON	idt_municipio=$line AND part_1.idt_tema = 32  	AND ST_IsValid( m.geo_localizacao) AND ST_IsValid(part_1.wkb_geometry)  	AND m.geo_localizacao && part_1.wkb_geometry AND ST_Intersects(m.geo_localizacao,part_1.wkb_geometry)  INNER JOIN       sfb_result.sicar_temas_20160302 part_2 ON 	 part_2.idt_tema = 2 AND part_1.idt_tema = 32 AND part_1.wkb_geometry && part_2.wkb_geometry 	  AND ST_Intersects(part_1.wkb_geometry, part_2.wkb_geometry)   group by idt_municipio, part_1.idt_imovel, part_1.wkb_geometry" -nln sicar_int_rl_vn | sed 's/ /_/g' | sed 's/%/_/g'

done < /sfb/DADOS/car/municipios/cod_mun_teste.txt
