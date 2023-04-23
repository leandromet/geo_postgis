
Simplified method of comparing covers from different years of MapBiomas 7 (Brazilian Land Cover Classification), using standard QGIS tools:

- Raster Calculator;
- Pixels to points;
- Sample Raster Values;

Code and data being organized in https://github.com/leandromet/geo_postgis/tree/master/2023_carbon_biodiversity.

For all processes, database hosting, data analysis and storage it was used a notebook computer with i7-10750H processor (6 cores, 12 threads) with 16GB RAM, 1TB SSD running Ubuntu 22.10 with QGIS 3.22, PostgeSQL 14.7, PostGIS 3.2.3 and PGAdmin 4 v6.21. There was no tuning, variable change or performance adjust from the default installation of all the tools out of Ubuntu repositories via apt-get.

To create images that represent land use change and a database of pixels for combinatorial analysis time of classes in the same places over the years, for the production of maps and representation of changes in Sankey Diagram-type graphs using javascript flow diagram (https://sankeymatic.com/).

Mapbiomas consists of 30 meter resolution raster files for every year between 1985 and 2020, covering the whole Brazilian territory (4,000x4,000 kilometers). It has 25 classes of land use represented by digital numbers in the raster file, like Natural Forest, Pasture, Urban and Silviculture. These are the MapBiomas collection 7 classes as translated from original files:

class_id		original_name		                  translated
1		        Formação Florestal	            	Forest
2		        Formação Savânica		              Savana
3		        Mangue		                        Mangrove
4		        Silvicultura		                  Silviculture
5		        Campo Alagado e Área Pantanosa		Wetland
6		        Formação Campestre	            	Coutryside
7		        Outras Formações não Florestais		Other non Forest
8		        Pastagem		                      Pasture
9		        Cana		                          Cane
10		      Mosaico Agricultura e Pastagem		Agriculture and Pasture
11		      Praia, Duna e Areal		            Sand
12		      Área Urbana		                    Urban
13		      Outras Áreas não Vegetadas		    Non Vegetated
14		      Afloramento Rochoso	            	Rock
15		      Mineração		                      Minning
16		      Aquicultura		                    Aquiculture
17		      Apicum		                        Peak
18		      Rio, Lago e Oceano		            Waterstream
19		      Soja		                          Soy
20		      Arroz (beta)		                  Rice
21		      Outras Lavouras Temporárias		    Other Crops
22		      Café (beta)		                    Coffe
23		      Citrus (beta)		                  Citrus
24		      Outras Lavouras Perenes		        Other Perennial Crops
25		      Restinga Arborizada (beta)		    Restinga with Tree


We started by using Raster Calculator to aggregate classes ( here considered classes 1, 2, 3 and 25 for example) from blocks of years with threshold masks as simple as:

( "raster_band_1985@1" = 1 or "raster_band_1985@1" = 2 or "raster_band_1985@1" = 3 or "raster_band_1985@1" = 25 ) 
OR
( "raster_band_1986@1" = 1 or "raster_band_1986@1" = 2 or "raster_band_1986@1" = 3 or "raster_band_1986@1" = 25 ) 

Where raster_band_1986 means the raster of the year 1986 with band number 1, in this case each layer has just one band with the pixel valueas from 0 to 25.

We then multiply the results from distant periods with applied weights to visually enhance areas that lost or recovered certain land use classes. Once we had the mapped regions it is pretty hard to count all locations for many combinations with different years, like looking at same pixels that went from forest to pasture in 1988 but went back to forest in 1995 and then rock in 2005. The flux of uses has too many options for them to be organized by comparing the evolution by year and then by decades to try and see what happened in a larger region.

Since a raster file is in reality a table, in this case 36 tables with 155,239 columns and 158,459 lines, why not use it in a structured database for handling all the 885 billion pixels, as point geometries? In fact we need only 24 billion points, each with 36 attributes of 1 byte per year, and maybe we can store it in a tablespace equivalent to the original 36GB raster files.

With the objective of doing simple queries in a database that accessed all of the pixels from every year, in a way that anybody could do and use in a comprehensible and transparent way, it was created a spatial point table. With 250 million lines from a 500x700 kilometer rectangle on the Atlantic Forest, a table with 38 columns that can be queried and the land use classes grouped, spatially filtered and exported in a few seconds. 

It took about two weeks to organize and develop a methodology based on those concepts, and we reproduced the Rondônia State in the Amazon biome to verify it all went fine, with a similarly sized rectangle and just over 300 million point registries. It takes about 12 hours of processing for all pixels from a 36 band TIFF file directly to a database table. Both datasets could be filtered using PostGis functions like ST_Intersects with benefits from spatial indexes (30 minutes to build it) and even with a final size of 60GB database from 8GB raster data, the derivation of new information became much faster than reprocessing images every time you change something in the analysis algorithm.

For insertion of the spatial tables on the database we used a standard PostgreSQL with PostGIS extension, made a conexion on QGIS at the localhost with postgres administrator user. For the creation of a spatial table "mb_test" in the "mapbiomas schema of the GEO database, with one line for each pixel centroid that was the base for the analysis we used "Raster pixels to points" with the following parameters from the QGIS Log:

Algorithm 'Raster pixels to points' starting…
Input parameters:
{ 'FIELD_NAME' : 'VALUE', 'INPUT_RASTER' : '/media/lmbiondo/winlin/mapbiomas_colecao7_2022/brasil_coverage_1985_2020.tiff', 'OUTPUT' : 'postgres://dbname=\'geo\' host=localhost port=5432 user=\'postgres\' password=\'*** \' sslmode=disable table="mapbiomas"."mb_test" (geom)', 'RASTER_BAND' : 1 }

By selecting a database table as output, QGIS did the procedures for creating the table, the spatial field and uploading the results to the database. If the raster had only one band that is the final table as this algorithm creates the registries with the value of one raster band already at the second column and a serial ID on the first one.

If we wanted more bands put on the table, as we wanted as much as 36 years from MapBiomas pixel value for each line of data, we used the previous table and a multi-band raster file with the same spatial extension as input for the  "Sample raster values" , and output to a table "multi_test" in the  same "mapbiomas" schema, as the following QGIS Log data shows:

Algorithm 'Sample raster values' starting…
Input parameters:
{ 'COLUMN_PREFIX' : 'SAMPLE_', 'INPUT' : 'layername=mb_test', 'OUTPUT' : 'postgres://dbname=\'geo\' host=localhost port=5432 user=\'postgres\' password=\' *** \' sslmode=disable table="mapbiomas"."multi_test" (geom)', 'RASTERCOPY' : '/media/lmbiondo/winlin/mapbiomas_colecao7_2022/brasil_coverage_1985_2020.tiff' }


Once we had the complete table we could filter it with spatial data like an administrative division from Brazil like:

select count(*) from ibge.proc_microrregion, mapbiomas.mapbiomas_class_use 
where cd_micro = '32008' and st_intersects( proc_microrregion.geom , mapbiomas_class_use.geom)

---- result 3,931,037 pixels from 250 million

And also create aggregated data from many possible combinations of classes and years by using SQL agregattors like:
select leg1.description as class_legend, mb_1985, mb_1990, mb_1995, mb_2000,
mb_2005, mb_2010, mb_2015, mb_2020, count(*) 
from
mapbiomas.subregion , mapbiomas.mapbiomas_class_use , mapbiomas.mapbiomas_legend leg1
where 
leg1.mapbiomas=mb_01_1985 
and st_intersects( subregion.geom , mapbiomas_class_use.geom)
group by leg1.legend, mb_1985, mb_1990, mb_1995, mb_2000,
mb_2005, mb_2010, mb_2015, mb_2020

---- SELECT 8,624     Query returned successfully in 2 secs 520 msec.

By doing tests like these we could determine that we find over 8 thousand different combinations of land use evolution looking at a 5 year interval in a 12x12 kilometer square, and over 150 thousand for the 500x700 km data. Most of the combinations have less than 1 to 10 hectares but it shows how impossible it would be to look at all possibilities detectable in the area mapping and coloring approach.

With the grouped information we did diagrams of the Sankey type to see the full period and step by step change in regions with similar pixels evolution. We could differentiate protected areas from private properties, the main differences from the Atlantic Forest where tenure is consolidated from Amazon conflict areas. 

We have places that lost less than 5% of forest cover in Indigenous land, others in public settlements with over 50% of forest becoming pasture in the Amazon and in contrast the Atlantic Forest lost coverage until the early 2000´s and recovered, but the original areas are distinct from the recovered ones. For a sample close to our institution for example, we saw a 200k hectares decrease from 8 million original forests but when looking at where are all pixels we find that over a million hectare was lost and the same amount regenerated in other abandoned areas. That might indicate a loss of biodiversity and other environmental services and quality due to a lack of management is a broader point of view.
