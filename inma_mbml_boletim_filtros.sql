select base1, tab1.genus, countj,  base2, tab2.genus, countr, countj-countr as j_r from 
(
select upper(genus) as genus, count(*) as countj, 'jabot' as base1  from 
	inma_processamento.es_colec_jabot where "family" = 'BROMELIACEAE' group by upper(genus)
)tab1
full join
(
select upper(genus) as genus,count(*) as countr, 'reflora' as base2  from 
	inma_processamento.es_colec_reflora where "family" = 'Bromeliaceae' group by upper(genus)
)tab2	
on 	tab1.genus = tab2.genus

order by countj desc, countr desc
--tab1.genus, tab2.genus
