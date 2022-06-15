#!/bin/sh

while read line 
	do 

	echo $line


ogr2ogr  -f  "CSV" $line.csv  PG:"host=host.144 user=user dbname=db" -sql "SELECT  * FROM $line" | sed 's/ /_/g' | sed 's/%/_/g'



done < /sfb/ARQUIVO/SFB/CAR/Demandas/portal_seg/tabelas.txt
