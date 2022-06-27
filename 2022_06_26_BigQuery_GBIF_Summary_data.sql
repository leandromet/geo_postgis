----Bigquery GBIF summary queries

SELECT countrycode,basisofrecord, kingdom,phylum,class,`order` as ord,family, genus,species,year, count(*)  FROM `bigquery-public-data.gbif.occurrences`
where countrycode ='BR' and species is not null and year > 1800 and year <2023
 group by countrycode,stateprovince,basisofrecord,kingdom, phylum, class,ord,family,genus,species, year order by kingdom, phylum, class,ord,family,genus,species, year
 
 
 ---- consult all records for geographical points
 
SELECT gbifid,ST_geogpoint(decimallongitude,decimallatitude) as geom , basisofrecord, kingdom,phylum,class,`order` as ord,family, genus,species,year FROM `bigquery-public-data.gbif.occurrences`
where countrycode ='BR' and year > 1800 and year <2023 and (decimallatitude between -90 and 90) and (decimallongitude between -180 and 180)
 
 
 
