
Simplified method of comparing covers from different years of MapBiomas 7 (Brazilian Land Cover Classification), using standard QGIS tools:

- Raster Calculator;
- Pixels to points;
- Sample Raster Values;

Code and data being organized in https://github.com/leandromet/geo_postgis/tree/master/2023_carbon_biodiversity.

For all processes, database hosting, data analysis and storage it was used a notebook computer with i7-10750H processor (6 cores, 12 threads) with 16GB RAM, 1TB SSD running Ubuntu 22.10 with QGIS 3.22, PostgeSQL 14.7, PostGIS 3.2.3 and PGAdmin 4 v6.21. There was no tuning, variable change or performance adjust from the default installation of all the tools out of Ubuntu repositories via apt-get.

To create images that represent land use change and a database of pixels for combinatorial analysis time of classes in the same places over the years, for the production of maps and representation of changes in Sankey Diagram-type graphs using javascript flow diagram (https://sankeymatic.com/).

Mapbiomas consists of 30 meter resolution raster files for every year between 1985 and 2020, covering the whole Brazilian territory (4,000x4,000 kilometers). It has 25 classes of land use represented by digital numbers in the raster file, like Natural Forest, Pasture, Urban and Silviculture. 

1			  	Forest
2			  	Savana
3			  	Mangrove
4			  	Silviculture
5			  	Wetland
6			  	Coutryside
7			  	Other non Forest
8			  	Pasture
9			  	Cane
10		 		Agriculture and Pasture
11				Sand
12				Urban
13				Non Vegetated
14				Rock
15				Minning
16				Aquiculture
17				Peak
18				Waterstream
19				Soy
20				Rice
21				Other Crops
22				Coffe
23				Citrus
24				Other Perennial Crops
25				Restinga with Tree

We started by using Raster Calculator to aggregate Natural classes ( here considered classes 3, 4, 5 and 11) from blocks of years with threshold masks as simple as:

( "raster_band_1985@1" = 3 or "raster_band_1985@1" = 4 or "raster_band_1985@1" = 5 or "raster_band_1985@1" = 11 ) 
OR
( "raster_band_1986@1" = 3 or "raster_band_1986@1" = 4 or "raster_band_1986@1" = 5 or "raster_band_1986@1" = 11 ) 

Where raster_band_1986 means the raster of the year 1986 with band number 1, in this case each layer has just one band with the pixel valueas from 0 to 25.

We then multiply the results from distant periods with applied weights to visually enhance areas that lost or recovered certain land use classes. Once we had the mapped regions it is pretty hard to count all locations for many combinations with different years, like looking at same pixels that went from forest to pasture in 1988 but went back to forest in 1995 and then rock in 2005. The flux of uses has too many options for them to be organized by comparing the evolution by year and then by decades to try and see what happened in a larger region.

Since a raster file is in reality a table, in this case 36 tables with 155,239 columns and 158,459 lines, why not use it in a structured database for handling all the 885 billion pixels, as point geometries? In fact we need only 24 billion points, each with 36 attributes of 1 byte per year, and maybe we can store it in a tablespace equivalent to the original 36GB raster files.

With the objective of doing simple queries in a database that accessed all of the pixels from every year, in a way that anybody could do and use in a comprehensible and transparent way, it was created a spatial point table. With 250 million lines from a 500x700 kilometer rectangle on the Atlantic Forest, a table with 38 columns that can be queried and the land use classes grouped, spatially filtered and exported in a few seconds. 

It took about two weeks to organize and develop a methodology based on those concepts, and we reproduced the Rondônia State in the Amazon biome to verify it all went fine, with a similarly sized rectangle and just over 300 million point registries. It takes about 12 hours of processing for all pixels from a 36 band TIFF file directly to a database table. Both datasets could be filtered using PostGis functions like ST_Intersects with benefits from spatial indexes (30 minutes to build it) and even with a final size of 60GB database from 8GB raster data, the derivation of new information became much faster than reprocessing images every time you change something in the analysis algorithm.

Once we had the complete table we could filter it with an administrative division from Brazil like:

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
