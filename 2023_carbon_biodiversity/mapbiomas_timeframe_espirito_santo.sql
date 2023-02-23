---- Microrregion Santa Teresa 
nm_mun :
Itaguaçu
Itarana
Santa Leopoldina
Santa Maria de Jetibá
Santa Teresa
São Roque do Canaã


---- count registries inside the selected region geometry - necessarily same projection and with built spatial indexes, if using st_Transform it wont benefit from index


select count(*) from ibge.proc_microrregioes_2021_4326_rupestre, mapbiomas.uso_solo_mapbio7 
where cd_micro = '32008' and st_intersects( proc_microrregioes_2021_4326_rupestre.geom , uso_solo_mapbio7.geom)

---- result 3931037 pixels

---- create table with mapbiomas data from that region

create table mapbiomas.santa_teresa_micro_1985_2020_5yr_eng as

select leg1.legend as class_1985, mb_01_1985, mb_06_1990, mb_11_1995, mb_16_2000,
mb_21_2005, mb_26_2010, mb_31_2015, mb_36_2020, count(*) from
ibge.proc_microrregioes_2021_4326_rupestre , mapbiomas.uso_solo_mapbio7 , mapbiomas.mapbiomas_legend leg1
where 
leg1.mapbiomas=mb_01_1985 and cd_micro = '32008' and st_intersects( proc_microrregioes_2021_4326_rupestre.geom , uso_solo_mapbio7.geom)
group by leg1.legend, mb_01_1985, mb_06_1990, mb_11_1995, mb_16_2000,
mb_21_2005, mb_26_2010, mb_31_2015, mb_36_2020

order by count desc


--- Rupestre areas for PCI project

select count(*) from mapbiomas.campos_rupestres_pci_2023, mapbiomas.uso_solo_mapbio7 
where st_intersects( campos_rupestres_pci_2023.geom , uso_solo_mapbio7.geom)

---- result 161893 pixels
create table mapbiomas.campos_rupestres_1985_2020_5yr_eng as

select leg1.description as classe1985, leg1.legend as class_1985, mb_01_1985, mb_06_1990, mb_11_1995, mb_16_2000,
mb_21_2005, mb_26_2010, mb_31_2015, mb_36_2020, count(*) from
mapbiomas.campos_rupestres_pci_2023 , mapbiomas.uso_solo_mapbio7 , mapbiomas.mapbiomas_legend leg1
where 
leg1.mapbiomas=mb_01_1985 and st_intersects( campos_rupestres_pci_2023.geom , uso_solo_mapbio7.geom)
group by leg1.legend, mb_01_1985, mb_06_1990, mb_11_1995, mb_16_2000,
mb_21_2005, mb_26_2010, mb_31_2015, mb_36_2020

order by count desc
---- SELECT 8624     Query returned successfully in 2 secs 520 msec.
