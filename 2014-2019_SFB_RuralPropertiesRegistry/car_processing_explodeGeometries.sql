drop table sfb_result.sicar_int_rl_vn_201604_limpo;
create table sfb_result.sicar_int_rl_vn_201604_limpo as
select id, geom, idt_municipio from (select ogc_fid as id, idt_municipio, ST_GeometryN(wkb_geometry,generate_series(1,ST_NumGeometries(wkb_geometry))) AS geom from sfb_result.sicar_int_rl_vn_201604)
 as foo where geometrytype(geom)='POLYGON';


--select distinct GeometryType(geom) from sfb_result.sicar_int_rl_vn_201604_limpo;
