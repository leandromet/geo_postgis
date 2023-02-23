1	3	Formação Florestal	#006400	Forest
2	4	Formação Savânica	#00ff00	Savana
3	5	Mangue	#687537	Mangrove
4	9	Silvicultura	#ad4413	Silviculture
5	11	Campo Alagado e Área Pantanosa	#45c2a5	Wetland
6	12	Formação Campestre	#b8af4f	Coutryside
7	13	Outras Formações não Florestais	#f1c232	Other non Forest
8	15	Pastagem	#ffd966	Pasture
9	20	Cana	#c27ba0	Cane
10	21	Mosaico de Agricultura e Pastagem	#fff3bf	Agriculture and Pasture
11	23	Praia, Duna e Areal	#dd7e6b	Sand
12	24	Área Urbana	#aa0000	Urban
13	25	Outras Áreas não Vegetadas	#ff3d3d	Non Vegetated
14	29	Afloramento Rochoso	#665a3a	Rock
15	30	Mineração	#af2a2a	Minning
16	31	Aquicultura	#02106f	Aquiculture
17	34	Apicum	#968c46	Peak
18	33	Rio, Lago e Oceano	#0000ff	Waterstream
19	39	Soja	#e075ad	Soy
20	40	Arroz (beta)	#982c9e	Rice
21	41	Outras Lavouras Temporárias	#e787f8	Other Crops
22	46	Café (beta)	#cca0d4	Coffe
23	47	Citrus (beta)	#d082de	Citrus
24	48	Outras Lavouras Perenes	#cd49e4	Other Perennial Crops
25	49	Restinga Arborizada (beta)	#6b9932	Restinga with Tree

with above table put on a table P2:U26, use the following to agregate the codes as substitution of classes: 
=","&CHAR(34)&Q2&CHAR(34)&","&CHAR(34)&T2&CHAR(34)&")"
shoud result in:
,"3","Forest")
then under the last line of this column:
=U26&U25&U24&U23&U22&U21&U20&U19&U18&U17&U16&U15&U14&U13&U12&U11&U10&U9&U8&U7&U6&U5&U4&U3&U2
the, in a text editor put 25 <<Substitute(>> and the cell with the class to substitute, in this case C2, and then the resulting text from above that is:
,"49","Restinga with Tree"),"48","Other Perennial Crops"),"47","Citrus"),"46","Coffe"),"41","Other Crops"),"40","Rice"),"39","Soy"),"33","Waterstream"),"34","Peak"),"31","Aquiculture"),"30","Minning"),"29","Rock"),"25","Non Vegetated"),"24","Urban"),"23","Sand"),"21","Agriculture and Pasture"),"20","Cane"),"15","Pasture"),"13","Other non Forest"),"12","Coutryside"),"11","Wetland"),"9","Silviculture"),"5","Mangrove"),"4","Savana"),"3","Forest")

it has 25 parenthesis close, with the 25 substitute and openings we get:

=SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(SUBSTITUTE(C2 ,"49","Restinga with Tree"),"48","Other Perennial Crops"),"47","Citrus"),"46","Coffe"),"41","Other Crops"),"40","Rice"),"39","Soy"),"33","Waterstream"),"34","Peak"),"31","Aquiculture"),"30","Minning"),"29","Rock"),"25","Non Vegetated"),"24","Urban"),"23","Sand"),"21","Agriculture and Pasture"),"20","Cane"),"15","Pasture"),"13","Other non Forest"),"12","Coutryside"),"11","Wetland"),"9","Silviculture"),"5","Mangrove"),"4","Savana"),"3","Forest")

so a table:
3	3	3
29	29	29
15	15	15
15	15	15
15	15	15
21	21	21
15	15	15
15	15	21
3	3	3
becomes:
Forest	Forest	Forest
Rock	Rock	Rock
Pasture	Pasture	Pasture
Pasture	Pasture	Pasture
Pasture	Pasture	Pasture
Agriculture and Pasture	Agriculture and Pasture	Agriculture and Pasture
Pasture	Pasture	Pasture
Pasture	Pasture	Pasture
Forest	Forest	Forest

