select genus_jabot , countj,genus_reflora , countr, genus_sibbr, countsb , genus_splink, countsp from 
(
select upper(genus) as genus_jabot, count(*) as countj from 
	inma_processamento.es_colec_jabot where "family" = 'BROMELIACEAE' group by upper(genus)
)tab1
full join
(
select upper(genus) as genus_reflora,count(*) as countr, 'reflora' as base2  from 
	inma_processamento.es_colec_reflora where "family" = 'Bromeliaceae' group by upper(genus)
)tab2	
on 	tab1.genus_jabot = tab2.genus_reflora
full join
(
select upper(genus) as genus_sibbr, count(*) as countsb  from 
	inma_processamento.es_colec_sibbr where upper("family") = 'BROMELIACEAE' group by upper(genus)
	)tab3	
on 	tab1.genus_jabot = tab3.genus_sibbr
full join
(
select upper(genus) as genus_splink, count(*) as countsp  from 
	inma_processamento.es_colec_splink where upper("family") = 'BROMELIACEAE' group by upper(genus)
	)tab4	
on 	tab1.genus_jabot = tab4.genus_splink


order by countj desc, countr desc, countsb desc, countsp desc
--tab1.genus, tab2.genus




--select * from (

select genus, count(*), 'jabot' as base  from inma_processamento.es_colec_jabot where "family" = 'BROMELIACEAE' group by genus

union all

select genus,count(*), 'reflora' as base  from inma_processamento.es_colec_reflora where "family" = 'Bromeliaceae' group by genus
--) tabela

--select distinct("family") from inma_processamento.es_colec_jabot order by "family" 
--select distinct("family") from inma_processamento.es_colec_reflora order by "family" 
