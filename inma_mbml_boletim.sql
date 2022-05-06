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
