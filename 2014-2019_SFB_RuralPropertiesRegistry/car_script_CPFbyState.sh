#!/bin/sh



for estado in AC AL AP AM BA CE DF ES GO MA MT MS MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO;
do
	echo $estado
ogr2ogr -f "CSV" CPF_ate4MF_nomes_$estado.csv PG:"host=host.144 user=user dbname=banco" -sql "SELECT DISTINCT imovel_pessoa.cod_cpf_cnpj, imovel_pessoa.nom_completo, imovel_pessoa.ind_tipo_pessoa, municipio.nom_municipio,  municipio.cod_estado    FROM    usr_geocar_aplicacao.imovel_pessoa,    usr_geocar_aplicacao.imovel,   usr_geocar_aplicacao.municipio WHERE municipio.cod_estado = '$estado' AND   imovel.idt_imovel = imovel_pessoa.idt_imovel   AND usr_geocar_aplicacao.municipio.idt_municipio = usr_geocar_aplicacao.imovel.idt_municipio     AND   imovel.num_modulo_fiscal<=4      AND   imovel.flg_ativo = TRUE  ORDER BY cod_estado, nom_municipio,ind_tipo_pessoa, cod_cpf_cnpj"

done
