create table inma_processamento.es_colec_equal_gbsb as

select gb.id as gb_id,sb.id as sd_id, gb.geom as geom_gb,
sb.geom as geom_sb from

inma_processamento.es_colec_gbif gb, 
inma_processamento.es_colec_sibbr sb

where 
st_intersects(gb.geom , sb.geom)

group by gb_id, sd_id
