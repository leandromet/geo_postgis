#!/bin/sh


##2150560

for parcial in $(seq 1001 1500);
	do 

	echo $parcial
       idt=$parcial*1000
	echo $idt

ogr2ogr -append -skipfailures -f "PostgreSQL" PG:"host=host.116 user=admincar dbname=banco4 active_schema=user_dados"  PG:"host=host.144 user=user dbname=banco" -sql "SELECT  DISTINCT ON (i.idt_imovel)   i.idt_imovel,   ip.nom_completo,   i.nom_imovel,   substring(ip.cod_cpf_cnpj from 0 for 6) as cpf_inic,    ST_Centroid(i.geo_area_imovel) as geom,   i.num_modulo_fiscal as num_mf,   round(cast(sum(case when app.idt_tema=26 then app.num_area else 0 end)as numeric),3) as area_ir,   round(cast(sum(case when app.idt_tema=30 then app.num_area else 0 end)as numeric),3) as area_app,    round(cast(sum(case when app.idt_tema=32 then app.num_area else 0 end)as numeric),3) as area_rl,   round(cast(sum(case when app.idt_tema=2 then app.num_area else 0 end)as numeric),3) as area_rvn FROM    usr_geocar_aplicacao.imovel i,    usr_geocar_aplicacao.imovel_pessoa ip,    usr_geocar_aplicacao.rel_tema_imovel_poligono app WHERE   i.ind_status_imovel IN ('AT','PE') AND i.idt_imovel BETWEEN $idt AND ($idt+999) AND   app.idt_tema IN (2,26,30,32) AND   i.idt_imovel = ip.idt_imovel AND   app.idt_imovel = i.idt_imovel GROUP BY i.idt_imovel, ip.idt_imovel_pessoa"  -nln dados_imoveis


done
