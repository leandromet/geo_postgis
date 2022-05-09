create table inma_processamento.splma_munic_uf as

select id_slma , geom, nm_estado,cd_geocmu,nm_municip
from (
select slma.id as id_slma,slma.geom, nm_estado
from
inma_processamento.species_link_mata_atlantica slma, dados_externos.ibge_br_uf_250gc_2018 ibge_uf
where
st_intersects(slma.geom, ibge_uf.geom) 
)A
inner join
(
select
slma2.id as id_slma2, cd_geocmu, nm_municip
from
inma_processamento.species_link_mata_atlantica slma2, dados_externos.ibge_br_mu_250gc_2018 ibge_mu
where
st_intersects(slma2.geom, ibge_mu.geom) 
)B 
on A.id_slma=B.id_slma2






select kingdom, count(*) 
from
inma_processamento.species_link_mata_atlantica 
group by kingdom order by kingdom




select nm_estado, kingdom, count(*) 
from
inma_processamento.species_link_mata_atlantica, dados_externos.ibge_br_uf_250gc_2018 
where
kingdom in ('Plantae','Animalia') and
st_intersects(species_link_mata_atlantica.geom, ibge_br_uf_250gc_2018.geom)
group by nm_estado, kingdom order by nm_estado, kingdom





select distinct(phylum) from inma_processamento.species_link_mata_atlantica  

select distinct(kingdom) from inma_processamento.species_link_mata_atlantica  

select nm_estado,st_area(st_transform(geom, 102033 ))/10000
from
 dados_externos.ibge_br_uf_250gc_2018 
order by nm_estado
