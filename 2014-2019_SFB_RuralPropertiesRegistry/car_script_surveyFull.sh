#!/bin/sh

while read line 
	do 

	echo $line

ogr2ogr -f "SQLite" -update -append  $line'_respostas_imovel_idade_20161228.sqlite' PG:"host=host.144 user=user dbname=db"  -sql "SELECT   imovel.cod_imovel,   imovel_pessoa.ind_tipo_pessoa,   to_char(imovel_pessoa.dat_nascimento,'YYYY') as ano_nasc,   resposta_pergunta.idt_resposta_pergunta,   imovel.num_area_imovel, imovel.idt_municipio FROM usr_geocar_aplicacao.municipio,  usr_geocar_aplicacao.imovel,   usr_geocar_aplicacao.imovel_pessoa,   usr_geocar_aplicacao.pergunta,   usr_geocar_aplicacao.resposta_imovel,   usr_geocar_aplicacao.resposta_pergunta WHERE   municipio.cod_estado = '$line' AND municipio.idt_municipio = imovel.idt_municipio AND imovel.ind_status_imovel in ('AT', 'PE') AND  imovel_pessoa.idt_imovel = imovel.idt_imovel AND  pergunta.idt_pergunta = resposta_pergunta.idt_pergunta AND  resposta_imovel.idt_imovel = imovel_pessoa.idt_imovel AND  resposta_pergunta.idt_resposta_pergunta = resposta_imovel.idt_resposta_pergunta;" 


done < /home/gecad/CAR/Demandas/dados_idade/uf.txt
