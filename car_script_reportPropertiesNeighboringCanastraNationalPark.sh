#!/bin/sh


		ogr2ogr -f "CSV"   parna_canastra_saojoaquim_pessoas.csv PG:"host=host.144 user=user dbname=db"  -sql "SELECT    imovel.idt_imovel,    imovel_pessoa.ind_tipo_pessoa,    imovel_pessoa.nom_completo,    idt_documento_imovel,   documento_imovel.ind_tipo_documento,    documento.nom_documento FROM    usr_geocar_aplicacao.imovel,    usr_geocar_aplicacao.imovel_pessoa,    usr_geocar_aplicacao.documento,    usr_geocar_aplicacao.documento_imovel WHERE    idt_municipio in (3112802,3121209,3156908,3162203,3164308,3170602,4202503,4206108,4209607,4211702,4218905) and ind_status_imovel in ('AT','PE') and   imovel_pessoa.idt_imovel = imovel.idt_imovel AND   documento.idt_documento = documento_imovel.ind_tipo_documento AND   documento_imovel.idt_imovel = imovel.idt_imovel" 
