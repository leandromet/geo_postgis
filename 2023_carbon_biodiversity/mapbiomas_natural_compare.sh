--- cut region of raster

gdal_translate -projwin -44.553 -17.209 -39.349 -20.507 -of GTiff source.tif extent.tif 

--- Raster Calculator

( "extent@1" = 3 or "extent@1" = 4 or "extent@1" = 5 or "extent@1" = 11 or "extent@1" = 12 or "extent@1" = 13 or "extent@1" = 23 or "extent@1" = 25 or "extent@1" = 29 or "extent@1" = 34 or "extent@1" = 33 or "extent@1" = 49 ) 

--- Raster Calculator

( "extent_year1985@1" = 3 or "extent_year1985@1" = 4 or "extent_year1985@1" = 5 or "extent_year1985@1" = 11 or "extent_year1985@1" = 12 or "extent_year1985@1" = 13 or "extent_year1985@1" = 23 or "extent_year1985@1" = 25 or "extent_year1985@1" = 29 or "extent_year1985@1" = 34 or "extent_year1985@1" = 33 or "extent_year1985@1" = 49 ) 
OR
( "extent_year1986@1" = 3 or "extent_year1986@1" = 4 or "extent_year1986@1" = 5 or "extent_year1986@1" = 11 or "extent_year1986@1" = 12 or "extent_year1986@1" = 13 or "extent_year1986@1" = 23 or "extent_year1986@1" = 25 or "extent_year1986@1" = 29 or "extent_year1986@1" = 34 or "extent_year1986@1" = 33 or "extent_year1986@1" = 49 ) 
