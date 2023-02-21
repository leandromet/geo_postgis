
processing.run("gdal:merge", {'INPUT':['/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1985_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1986_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1987_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1988_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1989_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1990_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1991_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1992_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1993_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1994_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1995_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1996_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1997_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1998_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_1999_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2000_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2001_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2002_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2003_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2004_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2005_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2006_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2007_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2008_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2009_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2010_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2011_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2012_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2013_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2014_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2015_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2016_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2017_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2018_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2019_extent.tif','/media/lmbiondo/winlin/rupestre/mapbiomas_7_recorte/brasil_coverage_2020_extent.tif'],'PCT':False,'SEPARATE':True,'NODATA_INPUT':None,'NODATA_OUTPUT':None,'OPTIONS':'COMPRESS=DEFLATE|PREDICTOR=2|ZLEVEL=9','EXTRA':'','DATA_TYPE':0,'OUTPUT':'/media/lmbiondo/winlin/mapbiomas_colecao7_2022/brasil_coverage_1985_2020.tiff'})

processing.run("native:rastersampling", {'INPUT':'postgres://dbname=\'geo\' host=localhost port=5432 user=\'lmbiondo\' password=\'lmb2000\' sslmode=disable key=\'id\' type=Point checkPrimaryKeyUnicity=\'1\' table="public"."mapbiomas_rupestre" (geom)','RASTERCOPY':'/media/lmbiondo/winlin/mapbiomas_colecao7_2022/brasil_coverage_1985_2020.tiff','COLUMN_PREFIX':'mb_','OUTPUT':'postgres://dbname=\'geo\' host=localhost port=5432 user=\'lmbiondo\' password=\'lm\' sslmode=disable table="mapbiomas"."uso_solo_mapbio7" (geom)'})

select mb_1, mb_6 , mb_11 ,mb_16 , mb_21 , mb_26 , mb_31 , mb_36, count(*) 
from mapbiomas.uso_solo_mapbio7 
group by mb_1, mb_6 , mb_11 ,mb_16 , mb_21 , mb_26 , mb_31 , mb_36
order by count desc




create table rondonia.mb_mudanca_1985_2020_5yr as

select leg1.description as class_1985, mb_01_1985, mb_06_1990, mb_11_1995, mb_16_2000,
mb_21_2005, mb_26_2010, mb_31_2015, mb_36_2020, leg2.description as class_2020, count(*) from
rondonia.mb_rondonia_17_20 , rondonia.mb_rondonia_85_16, mapbiomas.mapbiomas_legend leg1,  mapbiomas.mapbiomas_legend leg2
where 
mb_rondonia_17_20.id=mb_rondonia_85_16.id and leg1.mapbiomas=mb_01_1985 and leg2.mapbiomas=mb_36_2020
group by leg1.description, mb_01_1985, mb_06_1990, mb_11_1995, mb_16_2000,
mb_21_2005, mb_26_2010, mb_31_2015, mb_36_2020, leg2.description

order by count desc
