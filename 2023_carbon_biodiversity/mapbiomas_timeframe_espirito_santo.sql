select count(*) from ibge.microrregioes_2021 , mapbiomas.uso_solo_mapbio7 where cd_micro = '32008' and st_intersects( st_transform(microrregioes_2021.geom, 4326), uso_solo_mapbio7.geom)
