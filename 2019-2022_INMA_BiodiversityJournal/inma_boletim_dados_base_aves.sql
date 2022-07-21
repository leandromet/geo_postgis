create table inma_processamento.boletim_aves_20220531_es as  

select es_colec_gbif.* from inma_processamento.es_colec_gbif
where class = 'Aves'


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





create table inma_processamento.boletim_aves_20220531 as  

select ibge_br_mu_250gc_2018.nm_municip ,es_colec_gbif.* from inma_processamento.es_colec_gbif , dados_externos.ibge_br_mu_250gc_2018
where class = 'Aves'
and nm_municip in ( 'SANTA TERESA',
'SANTA MARIA DE JETIBÁ',
'SANTA LEOPOLDINA',
'ITAGUAÇU',
'ITARANA')
and
st_INTERSECTS(ibge_br_mu_250gc_2018.geom, es_colec_gbif.geom)


create table inma_processamento.boletim_sibbr_aves_20220531_serrana as  

select ibge_br_mu_250gc_2018.nm_municip ,es_colec_sibbr.* from inma_processamento.es_colec_sibbr , dados_externos.ibge_br_mu_250gc_2018
where class = 'Aves'
and nm_municip in ( 'SANTA TERESA',
'SANTA MARIA DE JETIBÁ',
'SANTA LEOPOLDINA',
'ITAGUAÇU',
'ITARANA')
and
st_INTERSECTS(ibge_br_mu_250gc_2018.geom, es_colec_sibbr.geom)






select distinct nm_municip, ("order"), "class", count(*) from inma_processamento.es_colec_gbif , dados_externos.ibge_br_mu_250gc_2018
where class = 'Aves'
and nm_municip in ( 'SANTA TERESA',
'SANTA MARIA DE JETIBÁ',
'SANTA LEOPOLDINA',
'ITAGUAÇU',
'ITARANA')
and
st_INTERSECTS(ibge_br_mu_250gc_2018.geom, es_colec_gbif.geom)
group by nm_municip, "order", "class" order by count desc , nm_municip, "class", "order"

"SANTA TERESA"	"Passeriformes"	"Aves"	11372
"SANTA TERESA"	"Apodiformes"	"Aves"	2788
"SANTA TERESA"	"Piciformes"	"Aves"	822
"SANTA TERESA"	"Columbiformes"	"Aves"	574
"SANTA TERESA"	"Accipitriformes"	"Aves"	504
"SANTA TERESA"	"Psittaciformes"	"Aves"	383
"SANTA LEOPOLDINA"	"Passeriformes"	"Aves"	295
"SANTA TERESA"	"Tinamiformes"	"Aves"	242
"SANTA TERESA"	"Trogoniformes"	"Aves"	234
"SANTA TERESA"	"Galliformes"	"Aves"	205
"SANTA LEOPOLDINA"	"Apodiformes"	"Aves"	182
"SANTA TERESA"	"Gruiformes"	"Aves"	182
"SANTA TERESA"	"Falconiformes"	"Aves"	162
"SANTA TERESA"	"Cuculiformes"	"Aves"	135
"SANTA MARIA DE JETIBÁ"	"Passeriformes"	"Aves"	108
"SANTA TERESA"	"Strigiformes"	"Aves"	98
"SANTA TERESA"	"Charadriiformes"	"Aves"	84
"SANTA TERESA"	"Caprimulgiformes"	"Aves"	74
"SANTA TERESA"	"Pelecaniformes"	"Aves"	62
"SANTA TERESA"	"Coraciiformes"	"Aves"	58
"SANTA TERESA"	"Anseriformes"	"Aves"	51
"SANTA LEOPOLDINA"	"Piciformes"	"Aves"	30
"SANTA MARIA DE JETIBÁ"	"Piciformes"	"Aves"	28
"SANTA LEOPOLDINA"	"Columbiformes"	"Aves"	27
"SANTA LEOPOLDINA"	"Accipitriformes"	"Aves"	25
"ITARANA"	"Passeriformes"	"Aves"	21
"SANTA LEOPOLDINA"	"Cuculiformes"	"Aves"	18
"SANTA LEOPOLDINA"	"Psittaciformes"	"Aves"	14
"SANTA LEOPOLDINA"	"Falconiformes"	"Aves"	8
"SANTA LEOPOLDINA"	"Strigiformes"	"Aves"	8
"SANTA TERESA"	"Cariamiformes"	"Aves"	8
"SANTA TERESA"	"Nyctibiiformes"	"Aves"	8
"SANTA TERESA"	"Podicipediformes"	"Aves"	8
"SANTA LEOPOLDINA"	"Charadriiformes"	"Aves"	7
"SANTA LEOPOLDINA"	"Tinamiformes"	"Aves"	7
"SANTA MARIA DE JETIBÁ"	"Columbiformes"	"Aves"	7
"SANTA LEOPOLDINA"	"Gruiformes"	"Aves"	6
"SANTA MARIA DE JETIBÁ"	"Charadriiformes"	"Aves"	6
"SANTA MARIA DE JETIBÁ"	"Psittaciformes"	"Aves"	6
"SANTA MARIA DE JETIBÁ"	"Tinamiformes"	"Aves"	6
"SANTA LEOPOLDINA"	"Caprimulgiformes"	"Aves"	5
"ITARANA"	"Accipitriformes"	"Aves"	4
"ITARANA"	"Piciformes"	"Aves"	4
"SANTA LEOPOLDINA"	"Pelecaniformes"	"Aves"	4
"ITARANA"	"Columbiformes"	"Aves"	3
"ITARANA"	"Psittaciformes"	"Aves"	3
"SANTA LEOPOLDINA"	"Anseriformes"	"Aves"	3
"SANTA LEOPOLDINA"	"Cariamiformes"	"Aves"	3
"SANTA LEOPOLDINA"	"Galliformes"	"Aves"	3
"SANTA LEOPOLDINA"	"Trogoniformes"	"Aves"	3
"SANTA MARIA DE JETIBÁ"	"Strigiformes"	"Aves"	3
"ITARANA"	"Cuculiformes"	"Aves"	2
"SANTA MARIA DE JETIBÁ"	"Accipitriformes"	"Aves"	2
"SANTA MARIA DE JETIBÁ"	"Falconiformes"	"Aves"	2
"SANTA TERESA"		"Aves"	2
"ITAGUAÇU"	"Anseriformes"	"Aves"	1
"ITAGUAÇU"	"Cariamiformes"	"Aves"	1
"ITAGUAÇU"	"Psittaciformes"	"Aves"	1
"ITARANA"	"Anseriformes"	"Aves"	1
"ITARANA"	"Apodiformes"	"Aves"	1
"ITARANA"	"Cariamiformes"	"Aves"	1
"ITARANA"	"Charadriiformes"	"Aves"	1
"ITARANA"	"Falconiformes"	"Aves"	1
"ITARANA"	"Galliformes"	"Aves"	1
"ITARANA"	"Gruiformes"	"Aves"	1
"ITARANA"	"Pelecaniformes"	"Aves"	1
"ITARANA"	"Strigiformes"	"Aves"	1
"SANTA LEOPOLDINA"	"Coraciiformes"	"Aves"	1
"SANTA MARIA DE JETIBÁ"	"Apodiformes"	"Aves"	1
"SANTA MARIA DE JETIBÁ"	"Caprimulgiformes"	"Aves"	1
"SANTA MARIA DE JETIBÁ"	"Coraciiformes"	"Aves"	1
"SANTA MARIA DE JETIBÁ"	"Galliformes"	"Aves"	1
"SANTA MARIA DE JETIBÁ"	"Gruiformes"	"Aves"	1
"SANTA MARIA DE JETIBÁ"	"Procellariiformes"	"Aves"	1
"SANTA MARIA DE JETIBÁ"	"Suliformes"	"Aves"	1
"SANTA TERESA"	"Procellariiformes"	"Aves"	1
"SANTA TERESA"	"Suliformes"	"Aves"	1
