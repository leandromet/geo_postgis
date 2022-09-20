select zonas.sigla,temperatur,relevo,chuva,sum(sib) as sibbr, sum(gbf) as gbif, sum(jab) as jabot, sum(spl) as splink

from 

inma_processamento.boletim_espacial_zonas_naturais zonas
,( select sigla, count(*) as sib from
inma_processamento.boletim_espacial_zonas_naturais zn,
inma_processamento.es_serra_colec_sibbr sib
  where st_intersects(zn.geom, sib.geom)
  group by sigla
) sel1

,( select sigla, count(*) as gbf from
inma_processamento.boletim_espacial_zonas_naturais zn,
inma_processamento.es_serra_colec_gbif gbf
  where st_intersects(zn.geom, gbf.geom)
  group by sigla
) sel2

,( select sigla, count(*) as jab from
inma_processamento.boletim_espacial_zonas_naturais zn,
inma_processamento.es_serra_colec_jabot jab
  where st_intersects(zn.geom, jab.geom)
  group by sigla
) sel3

,( select sigla, count(*) as spl from
inma_processamento.boletim_espacial_zonas_naturais zn,
inma_processamento.es_serra_colec_splink spl
  where st_intersects(zn.geom, spl.geom)
  group by sigla
) sel4

where
zonas.sigla = sel1.sigla and
sel1.sigla = sel2.sigla and
sel1.sigla = sel3.sigla and
sel1.sigla = sel4.sigla

group by zonas.sigla,temperatur,relevo,chuva





"AAC"	"amena"	"acidentado"	"CHUVOSA"	43493	22852	1451	73285
"AACS"	"amena"	"acidentado"	"CHUVOSA/SECA"	2993	1246	206	3084
"FAC"	"fria"	"acidentado"	"CHUVOSA"	36204	29644	3124	34468
"QAC"	"quente"	"acidentado"	"CHUVOSA"	3528	1695	667	5132
"QAS"	"quente"	"acidentado"	"SECA"	3573	1960	186	10597
"QPCS"	"quente"	"plano"	"CHUVOSA/SECA"	32	2	2	38
