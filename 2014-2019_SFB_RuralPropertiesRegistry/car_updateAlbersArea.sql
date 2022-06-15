--alter table sfb_result.sicar_int_rl_vn add column area_ha double precision;
update sfb_result.sicar_int_rl_vn_201604_limpo set area_ha=st_area(st_transform(wkb_geometry, 102033))/10000;
--select sum(area_ha) from sfb_result.sicar_int_rl_vn;
--alter table sfb_result.sicar_int_app_vn add column area_ha double precision;
--update sfb_result.sicar_int_app_vn_201604_limpo set area_ha=st_area(st_transform(wkb_geometry, 102033))/10000;
