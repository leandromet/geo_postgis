
create table sfb_result.mata_gid_municipios as
SELECT 
  substring(imovel.cod_imovel for 2) as uf, 
  substring(imovel.cod_imovel from 4 for 7) as geocod,
  mata_imoveis.gid
FROM 
  sig.imovel, 
  sfb_result.mata_imoveis
WHERE 
  mata_imoveis.gid = imovel.gid;




 create table sfb_result.intersect_bb_mata as 
SELECT 
  imovel.id_imovel
FROM 
  sig.imovel, 
  sfb_dados.mata_atlantica
WHERE 
  (imovel.the_geom && mata_atlantica.geom) ;


create table sfb_result.intersect_mata as 
SELECT 
  imovel.id_imovel
FROM 
  sig.imovel, 
  sfb_dados.mata_atlantica,
  sfb_result.intersect_bb_mata
WHERE 
  imovel.id_imovel=intersect_bb_mata.id_imovel and
  ST_Intersects(imovel.the_geom, mata_atlantica.geom) ;

create table sfb_result.mata_imoveis as

SELECT 
  distinct(imovel.gid), 
  imovel.nu_area, 
  imovel.nu_modulo_fiscal, 
  imovel.the_geom
FROM 
  sfb_result.intersect_mata, 
  sig.imovel
WHERE 
  imovel.id_imovel = intersect_mata.id_imovel;


create table sfb_result.mata_vegetacao as
SELECT 
  distinct(vegetacao_nativa.gid), 
  vegetacao_nativa.nu_area, 
  vegetacao_nativa.the_geom
FROM 
  sfb_result.intersect_mata, 
  sig.vegetacao_nativa
WHERE 
  vegetacao_nativa.id_imovel = intersect_mata.id_imovel;
