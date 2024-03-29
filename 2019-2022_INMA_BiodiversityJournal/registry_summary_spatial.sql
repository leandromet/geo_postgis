sibbr

select nm_municip, selc1.kingdom, selc1."class", selc1."order", selc1.family, sum(sibbr) as sibbr, sum(imv) as imv, sum(app) as app,  sum(rvn) as rvn, sum(rl) as rl from

dados_externos.ibge_br_mu_250gc_2018
, (select nm_municip as nm_munic_sibbr,kingdom, "class", "order",family , count ( distinct sibbr.id) as sibbr	   
from
inma_processamento.es_serra_colec_sibbr sibbr, dados_externos.ibge_br_mu_250gc_2018 munic
where nm_municip in ( 'SANTA TERESA',
'SANTA MARIA DE JETIBÁ',
'SANTA LEOPOLDINA',
'ITAGUAÇU',
'ITARANA') and
st_INTERSECTS(sibbr.geom, munic.geom)
group by nm_municip,kingdom, "class", "order" , family) selc0

, (select municipio_,kingdom, "class", "order", family, count ( distinct sibbr.id) as app	   
from
inma_processamento.boletim_espacial_car_app app
left outer join
inma_processamento.es_serra_colec_sibbr sibbr
on
st_intersects(sibbr.geom, app.geom)
group by municipio_,kingdom, "class", "order", family ) selc1

, (select municipio_,kingdom, "class", "order", family, count ( distinct sibbr.id) as imv 	   
from
inma_processamento.boletim_espacial_car_imovel imv
left outer join
inma_processamento.es_serra_colec_sibbr sibbr
on
st_intersects(sibbr.geom, imv.geom)
group by municipio_,kingdom, "class", "order", family ) selc2

,(select municipio_,kingdom, "class", "order", family, count ( distinct sibbr.id) as rvn 	   
from
inma_processamento.boletim_espacial_car_remanescente rvn
left outer join
inma_processamento.es_serra_colec_sibbr sibbr
on
st_intersects(sibbr.geom, rvn.geom)
group by municipio_,kingdom, "class", "order", family ) selc3

,(select municipio_,kingdom, "class", "order", family, count ( distinct sibbr.id) as rl 	   
from
inma_processamento.boletim_espacial_car_reserva_legal rl
left outer join
inma_processamento.es_serra_colec_sibbr sibbr
on
st_intersects(sibbr.geom, rl.geom)
group by municipio_,kingdom, "class", "order", family ) selc4


where 
selc1.municipio_ = cast(ibge_br_mu_250gc_2018.cd_geocmu as int)
and nm_municip = nm_munic_sibbr
and selc1.municipio_ = selc2.municipio_ 
and selc1.municipio_ = selc3.municipio_ 
and selc1.municipio_ = selc4.municipio_
and selc1."class" = selc2."class"
and selc1."class" = selc3."class"
and selc1."class" = selc4."class"
and selc1."class" = selc0."class"
and selc1."order" = selc2."order"
and selc1."order" = selc3."order"
and selc1."order" = selc4."order"
and selc1."order" = selc0."order"
and selc1.family = selc2.family
and selc1.family = selc3.family
and selc1.family = selc4.family
and selc1.family = selc0.family

group by nm_municip, selc1.kingdom, selc1."class", selc1."order",selc1.family















gbif

select nm_municip,selc1.kingdom, selc1."class",selc1."order", selc1.family, sum(gbif) as gbif, sum(imv) as imv, sum(app) as app,  sum(rvn) as rvn, sum(rl) as rl from


dados_externos.ibge_br_mu_250gc_2018,
(select nm_municip as nm_munic_gbif,kingdom,"class","order", family, count ( distinct gbif.id) as gbif	   
from
inma_processamento.es_serra_colec_gbif gbif
group by nm_municip,kingdom,"class","order", family ) selc0
,
(select municipio_,kingdom,"class","order", family, count ( distinct gbif.id) as app	   
from
inma_processamento.boletim_espacial_car_app app
left outer join
inma_processamento.es_serra_colec_gbif gbif
on
st_intersects(gbif.geom, app.geom)
group by municipio_,kingdom,"class","order", family ) selc1
, (select municipio_,kingdom,"class","order", family, count ( distinct gbif.id) as imv 	   
from
inma_processamento.boletim_espacial_car_imovel imv
left outer join
inma_processamento.es_serra_colec_gbif gbif
on
st_intersects(gbif.geom, imv.geom)
group by municipio_,kingdom,"class","order", family ) selc2

, (select municipio_,kingdom,"class","order", family, count ( distinct gbif.id) as rvn 	   
from
inma_processamento.boletim_espacial_car_remanescente rvn
left outer join
inma_processamento.es_serra_colec_gbif gbif
on
st_intersects(gbif.geom, rvn.geom)
group by municipio_,kingdom,"class","order", family ) selc3

, (select municipio_,kingdom,"class","order", family, count ( distinct gbif.id) as rl 
		   
from
inma_processamento.boletim_espacial_car_reserva_legal rl
left outer join
inma_processamento.es_serra_colec_gbif gbif
on
st_intersects(gbif.geom, rl.geom)

group by municipio_,kingdom,"class","order", family ) selc4


where 
selc1.municipio_ = cast(ibge_br_mu_250gc_2018.cd_geocmu as int)
and nm_municip = nm_munic_gbif
and selc1.municipio_ = selc2.municipio_ 
and selc1.municipio_ = selc3.municipio_ 
and selc1.municipio_ = selc4.municipio_
and selc1."class" = selc2."class"
and selc1."class" = selc3."class"
and selc1."class" = selc4."class"
and selc1."class" = selc0."class"
and selc1."order" = selc2."order"
and selc1."order" = selc3."order"
and selc1."order" = selc4."order"
and selc1."order" = selc0."order"
and selc1.family = selc2.family
and selc1.family = selc3.family
and selc1.family = selc4.family
and selc1.family = selc0.family

group by nm_municip, selc1.kingdom, selc1."class", selc1."order",selc1.family







serrana
select selc1.municipio_, nm_municip, imv, app,  rvn, rl from


dados_externos.ibge_br_mu_250gc_2018,
(select municipio_, count ( distinct gbif.id) as app	   
from
inma_processamento.boletim_espacial_car_app app
left outer join
inma_processamento.es_serra_colec_gbif gbif
on
st_intersects(gbif.geom, app.geom)
group by municipio_ ) selc1
, (select municipio_, count ( distinct gbif.id) as imv 	   
from
inma_processamento.boletim_espacial_car_imovel imv
left outer join
inma_processamento.es_serra_colec_gbif gbif
on
st_intersects(gbif.geom, imv.geom)
group by municipio_ ) selc2

, (select municipio_, count ( distinct gbif.id) as rvn 	   
from
inma_processamento.boletim_espacial_car_remanescente rvn
left outer join
inma_processamento.es_serra_colec_gbif gbif
on
st_intersects(gbif.geom, rvn.geom)
group by municipio_ ) selc3

, (select municipio_, count ( distinct gbif.id) as rl 
		   
from
inma_processamento.boletim_espacial_car_reserva_legal rl
left outer join
inma_processamento.es_serra_colec_gbif gbif
on
st_intersects(gbif.geom, rl.geom)

group by municipio_ ) selc4


where 
selc1.municipio_ = cast(ibge_br_mu_250gc_2018.cd_geocmu as int)
and selc1.municipio_ = selc2.municipio_ 
and selc1.municipio_ = selc3.municipio_ 
and selc1.municipio_ = selc4.municipio_
















aves
select selc1.municipio_, nm_municip, imv, app,  rvn, rl from
dados_externos.ibge_br_mu_250gc_2018,
(select municipio_, count ( distinct gbif.id) as app	   
from
inma_processamento.boletim_espacial_car_app app
left outer join
inma_processamento.boletim_gbif_aves_20220531_serrana gbif
on
st_intersects(gbif.geom, app.geom)
group by municipio_ ) selc1
, (select municipio_, count ( distinct gbif.id) as imv 	   
from
inma_processamento.boletim_espacial_car_imovel imv
left outer join
inma_processamento.boletim_gbif_aves_20220531_serrana gbif
on
st_intersects(gbif.geom, imv.geom)
group by municipio_ ) selc2

, (select municipio_, count ( distinct gbif.id) as rvn 	   
from
inma_processamento.boletim_espacial_car_remanescente rvn
left outer join
inma_processamento.boletim_gbif_aves_20220531_serrana gbif
on
st_intersects(gbif.geom, rvn.geom)
group by municipio_ ) selc3

, (select municipio_, count ( distinct gbif.id) as rl 
		   
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


aves	18931,0000				
geocodigo	municipio	imovel	app	rvn	rl
3203130	JOÃO NEIVA	0	0	0	0
3204500	SANTA LEOPOLDINA	261	0	112	1
3201308	CARIACICA	0	0	0	0
3204955	SÃO ROQUE DO CANAÃ	0	0	0	0
3200805	BAIXO GUANDU	0	0	0	0
3204609	SANTA TERESA	4210	195	2848	381
3201506	COLATINA	0	0	0	0
3204559	SANTA MARIA DE JETIBÁ	163	0	55	5
3202900	ITARANA	42	0	0	0
3202702	ITAGUAÇU	0	0	0	0
3202207	FUNDÃO	0	0	0	0
3201902	DOMINGOS MARTINS	0	0	0	0
3200102	AFONSO CLÁUDIO	0	0	0	0
3203163	LARANJA DA TERRA	0	0	0	0
3205002	SERRA	0	0	0	0
		4676	195	3015	387
