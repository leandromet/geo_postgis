select selc1.municipio_, nm_municip, imv, app,  rvn, rl from

dados_externos.ibge_br_mu_250gc_2018,
(select municipio_, count (*) as app
		   
from
inma_processamento.boletim_espacial_car_app app
--inma_processamento.boletim_espacial_car_imovel,
--inma_processamento.boletim_espacial_car_remanescente,
--inma_processamento.boletim_espacial_car_reserva_legal,
--inma_processamento.boletim_espacial_solos_serrana_area,
--inma_processamento.boletim_espacial_zonas_naturais,
left outer join
inma_processamento.boletim_gbif_aves_20220531_serrana gbif
on
st_intersects(gbif.geom, app.geom)

group by municipio_ ) selc1
, (select municipio_, count (*) as imv 
		   
from
--inma_processamento.boletim_espacial_car_app app
inma_processamento.boletim_espacial_car_imovel imv
--inma_processamento.boletim_espacial_car_remanescente,
--inma_processamento.boletim_espacial_car_reserva_legal,
--inma_processamento.boletim_espacial_solos_serrana_area,
--inma_processamento.boletim_espacial_zonas_naturais,
left outer join
inma_processamento.boletim_gbif_aves_20220531_serrana gbif
on
st_intersects(gbif.geom, imv.geom)
group by municipio_ ) selc2

, (select municipio_, count (*) as rvn 	   
from
inma_processamento.boletim_espacial_car_remanescente rvn
left outer join
inma_processamento.boletim_gbif_aves_20220531_serrana gbif
on
st_intersects(gbif.geom, rvn.geom)
group by municipio_ ) selc3

, (select municipio_, count (*) as rl 
		   
from
inma_processamento.boletim_espacial_car_reserva_legal rl
left outer join
inma_processamento.boletim_gbif_aves_20220531_serrana gbif
on
st_intersects(gbif.geom, rl.geom)

group by municipio_ ) selc4


where 
selc1.municipio_ = cast(ibge_br_mu_250gc_2018.cd_geocmu as int)
and selc1.municipio_ = selc2.municipio_ 
and selc1.municipio_ = selc3.municipio_ 
and selc1.municipio_ = selc4.municipio_


