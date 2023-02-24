
Setting data from a pivot table in a compatible format for usage on sankeymatic.com/ 


1985		Sum - area (ha)	1990	
Forest	1985	1177.38	Countryside	1990
Forest	1985	6122385.45	Forest	1990
Forest	1985	928025.55	Pasture	1990
Forest	1985	1190.97	Urban	1990
Forest	1985	22528.71	Water	1990
Total Result		7075308.06		

1990		Sum - area (ha)	1995
Countryside	1990	1177.38	Countryside
Forest	1990	4746340.98	Forest
Forest	1990	1374437.43	Pasture
Forest	1990	1607.04	Water
Pasture	1990	53035.56	Forest
Pasture	1990	874989.99	Pasture
Urban	1990	1190.97	Urban
Water	1990	22528.71	Water
Total Result		7075308.06	




use the following formulae considering the last column is K and the first registry is on line 4:
=K4&" "&L4&" ["&ROUND(M4,0)&"] "&N4&" "&O4

to get data rearranged like this:

Forest 1985 [1177] Countryside 1990
Forest 1985 [6122385] Forest 1990
Forest 1985 [928026] Pasture 1990
Forest 1985 [1191] Urban 1990
Forest 1985 [22529] Water 1990

Countryside 1990 [1177] Countryside 1995
Forest 1990 [4746341] Forest 1995
Forest 1990 [1374437] Pasture 1995
Forest 1990 [1607] Water 1995
Pasture 1990 [53036] Forest 1995
Pasture 1990 [874990] Pasture 1995
Urban 1990 [1191] Urban 1995
Water 1990 [22529] Water 1995
