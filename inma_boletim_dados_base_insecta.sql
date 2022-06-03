create table inma_processamento.boletim_insecta_ricardo20220531_es as  

select es_colec_gbif.* from inma_processamento.es_colec_gbif
where class in ('Arthropoda','Insecta' )


select id, cd_geocmu, nm_municip from dados_externos.ibge_br_mu_250gc_2018 where nm_municip in ( 'SANTA TERESA',
'SANTA MARIA DE JETIBÁ',
'SANTA LEOPOLDINA',
'ITAGUAÇU',
'ITARANA')

--272	"3202702"	"ITAGUAÇU"
--688	"3204500"	"SANTA LEOPOLDINA"
--1226	"3202900"	"ITARANA"
--4025	"3204609"	"SANTA TERESA"
--5425	"3204559"	"SANTA MARIA DE JETIBÁ"





create table inma_processamento.boletim_insecta_ricardo20220531 as  

select ibge_br_mu_250gc_2018.nm_municip ,es_colec_gbif.* from inma_processamento.es_colec_gbif , dados_externos.ibge_br_mu_250gc_2018
where class in ('Arthropoda','Insecta' )
and nm_municip in ( 'SANTA TERESA',
'SANTA MARIA DE JETIBÁ',
'SANTA LEOPOLDINA',
'ITAGUAÇU',
'ITARANA')
and
st_INTERSECTS(ibge_br_mu_250gc_2018.geom, es_colec_gbif.geom)


create table inma_processamento.boletim_sibbr_insecta_ricardo20220531_serra as  

select ibge_br_mu_250gc_2018.nm_municip ,es_colec_sibbr.* from inma_processamento.es_colec_sibbr , dados_externos.ibge_br_mu_250gc_2018
where class in ('Arthropoda','Insecta' )
and nm_municip in ( 'SANTA TERESA',
'SANTA MARIA DE JETIBÁ',
'SANTA LEOPOLDINA',
'ITAGUAÇU',
'ITARANA')
and
st_INTERSECTS(ibge_br_mu_250gc_2018.geom, es_colec_sibbr.geom)






select distinct nm_municip, ("order"), "class", count(*) from inma_processamento.es_colec_gbif , dados_externos.ibge_br_mu_250gc_2018
where class in ('Arthropoda','Insecta' )
and nm_municip in ( 'SANTA TERESA',
'SANTA MARIA DE JETIBÁ',
'SANTA LEOPOLDINA',
'ITAGUAÇU',
'ITARANA')
and
st_INTERSECTS(ibge_br_mu_250gc_2018.geom, es_colec_gbif.geom)
group by nm_municip, "order", "class" order by count desc , nm_municip, "class", "order"

"ITAGUAÇU"	"Insecta"	"Arthropoda"	5
"ITAGUAÇU"	"Diptera"	"Insecta"	75
"ITAGUAÇU"	"Hemiptera"	"Insecta"	2
"ITAGUAÇU"	"Hymenoptera"	"Insecta"	120
"ITARANA"	"Diptera"	"Insecta"	2
"ITARANA"	"Hemiptera"	"Insecta"	2
"ITARANA"	"Hymenoptera"	"Insecta"	21
"SANTA LEOPOLDINA"	"Insecta"	"Arthropoda"	6
"SANTA LEOPOLDINA"	"Coleoptera"	"Insecta"	5
"SANTA LEOPOLDINA"	"Diptera"	"Insecta"	221
"SANTA LEOPOLDINA"	"Hemiptera"	"Insecta"	6
"SANTA LEOPOLDINA"	"Hymenoptera"	"Insecta"	112
"SANTA LEOPOLDINA"	"Lepidoptera"	"Insecta"	121
"SANTA LEOPOLDINA"	"Megaloptera"	"Insecta"	1
"SANTA LEOPOLDINA"	"Odonata"	"Insecta"	1
"SANTA LEOPOLDINA"	"Orthoptera"	"Insecta"	2
"SANTA LEOPOLDINA"	"Phasmida"	"Insecta"	3
"SANTA LEOPOLDINA"	"Psocodea"	"Insecta"	1
"SANTA LEOPOLDINA"	"Trichoptera"	"Insecta"	2
"SANTA MARIA DE JETIBÁ"	"Insecta"	"Arthropoda"	4
"SANTA MARIA DE JETIBÁ"	"Coleoptera"	"Insecta"	1
"SANTA MARIA DE JETIBÁ"	"Diptera"	"Insecta"	29
"SANTA MARIA DE JETIBÁ"	"Hemiptera"	"Insecta"	3
"SANTA MARIA DE JETIBÁ"	"Hymenoptera"	"Insecta"	63
"SANTA MARIA DE JETIBÁ"	"Lepidoptera"	"Insecta"	11
"SANTA MARIA DE JETIBÁ"	"Orthoptera"	"Insecta"	1
"SANTA MARIA DE JETIBÁ"	"Trichoptera"	"Insecta"	1
"SANTA TERESA"	"Insecta"	"Arthropoda"	1
"SANTA TERESA"	"Coleoptera"	"Insecta"	9
"SANTA TERESA"	"Diptera"	"Insecta"	111
"SANTA TERESA"	"Ephemeroptera"	"Insecta"	14
"SANTA TERESA"	"Hemiptera"	"Insecta"	10
"SANTA TERESA"	"Hymenoptera"	"Insecta"	1177
"SANTA TERESA"	"Lepidoptera"	"Insecta"	36
"SANTA TERESA"	"Mantodea"	"Insecta"	1
"SANTA TERESA"	"Odonata"	"Insecta"	7
"SANTA TERESA"	"Orthoptera"	"Insecta"	10
"SANTA TERESA"	"Phasmida"	"Insecta"	5
"SANTA TERESA"	"Plecoptera"	"Insecta"	23
"SANTA TERESA"	"Trichoptera"	"Insecta"	18





