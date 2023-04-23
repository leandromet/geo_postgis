Simplified method of comparing covers from different years of MapBiomas 7 (Brazilian Land Cover Classification), using standard QGIS tools:

    Raster Calculator;
    Pixels to points;
    Sample Raster Values;

Code and data being organized in https://github.com/leandromet/geo_postgis/tree/master/2023_carbon_biodiversity.

For all processes, database hosting, data analysis and storage it was used a notebook computer with i7-10750H processor (6 cores, 12 threads) with 16GB RAM, 1TB SSD running Ubuntu 22.10 with QGIS 3.22, PostgeSQL 14.7, PostGIS 3.2.3 and PGAdmin 4 v6.21. There was no tuning, variable change or performance adjust from the default installation of all the tools out of Ubuntu repositories via apt-get.

To create images that represent land use change and a database of pixels for combinatorial analysis time of classes in the same places over the years, for the production of maps and representation of changes in Sankey Diagram-type graphs using javascript flow diagram (https://sankeymatic.com/).

Mapbiomas consists of 30 meter resolution raster files for every year between 1985 and 2020, covering the whole Brazilian territory (4,000x4,000 kilometers). It has 25 classes of land use represented by digital numbers in the raster file, like Natural Forest, Pasture, Urban and Silviculture. These are the MapBiomas collection 7 classes as translated from original files:

class_id original_name translated 1 Formação Florestal Forest 2 Formação Savânica Savana 3 Mangue Mangrove 4 Silvicultura Silviculture 5 Campo Alagado e Área Pantanosa Wetland 6 Formação Campestre Coutryside 7 Outras Formações não Florestais Other non Forest 8 Pastagem Pasture 9 Cana Cane 10 Mosaico Agricultura e Pastagem Agriculture and Pasture 11 Praia, Duna e Areal Sand 12 Área Urbana Urban 13 Outras Áreas não Vegetadas Non Vegetated 14 Afloramento Rochoso Rock 15 Mineração Minning 16 Aquicultura Aquiculture 17 Apicum Peak 18 Rio, Lago e Oceano Waterstream 19 Soja Soy 20 Arroz (beta) Rice 21 Outras Lavouras Temporárias Other Crops 22 Café (beta) Coffe 23 Citrus (beta) Citrus 24 Outras Lavouras Perenes Other Perennial Crops 25 Restinga Arborizada (beta) Restinga with Tree
