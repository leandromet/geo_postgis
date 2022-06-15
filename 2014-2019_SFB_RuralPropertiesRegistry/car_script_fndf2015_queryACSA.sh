

#!/bin/sh

while read line 
	do 

	echo $line

		ogr2ogr -f "SQLite" -update -append  acsa_area6e7.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    imovel.idt_imovel,    imovel.cod_imovel,    imovel.cod_protocolo,    rel_tema_imovel_poligono.idt_tema,    tema.nom_tema,   imovel.dat_protocolo,    imovel.ind_status_imovel,    imovel.ind_tipo_imovel,    imovel.cod_cpf_cadastrante,    imovel.nom_completo_cadastrante,    imovel.nom_imovel,    imovel.num_area_imovel as area_imovel, rel_tema_imovel_poligono.num_area as area_tema,    imovel.num_modulo_fiscal,    imovel.dat_criacao,    imovel.dat_atualizacao,    municipio.idt_municipio,    municipio.nom_municipio,    municipio.cod_estado,    rel_tema_imovel_poligono.the_geom FROM    usr_geocar_aplicacao.imovel,    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    usr_geocar_aplicacao.tema WHERE    imovel.cod_imovel='$line' AND   municipio.idt_municipio = imovel.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND   tema.idt_tema = rel_tema_imovel_poligono.idt_tema AND GeometryType(the_geom)='POLYGON';" -nln acsa2_area_liquida -nlt POLYGON

ogr2ogr -f "SQLite" -update -append  acsa_area6e7.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    imovel.idt_imovel,    imovel.cod_imovel,    imovel.cod_protocolo,    rel_tema_imovel_poligono.idt_tema,    tema.nom_tema,    imovel.dat_protocolo,    imovel.ind_status_imovel,    imovel.ind_tipo_imovel,    imovel.cod_cpf_cadastrante,    imovel.nom_completo_cadastrante,    imovel.nom_imovel,     imovel.num_area_imovel as area_imovel, rel_tema_imovel_poligono.num_area as area_tema,    imovel.num_modulo_fiscal,    imovel.dat_criacao,    imovel.dat_atualizacao,    municipio.idt_municipio,    municipio.nom_municipio,    municipio.cod_estado,    rel_tema_imovel_poligono.the_geom FROM    usr_geocar_aplicacao.imovel,    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    usr_geocar_aplicacao.tema WHERE    imovel.cod_imovel='$line' AND   municipio.idt_municipio = imovel.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND   tema.idt_tema = rel_tema_imovel_poligono.idt_tema AND GeometryType(the_geom)='MULTIPOLYGON';" -nln acsa2_temas -nlt MULTIPOLYGON


		ogr2ogr -f "SQLite" -update -append  acsa_area6e7.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    imovel.idt_imovel,    imovel.cod_imovel,    imovel.cod_protocolo,    rel_tema_imovel_poligono.idt_tema,    tema.nom_tema,    imovel.dat_protocolo,    imovel.ind_status_imovel,    imovel.ind_tipo_imovel,    imovel.cod_cpf_cadastrante,    imovel.nom_completo_cadastrante,    imovel.nom_imovel,     imovel.num_area_imovel as area_imovel, rel_tema_imovel_poligono.num_area as area_tema,    imovel.num_modulo_fiscal,    imovel.dat_criacao,    imovel.dat_atualizacao,    municipio.idt_municipio,    municipio.nom_municipio,    municipio.cod_estado,    rel_tema_imovel_poligono.the_geom FROM    usr_geocar_aplicacao.imovel,    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    usr_geocar_aplicacao.tema WHERE    imovel.cod_protocolo='$line' AND   municipio.idt_municipio = imovel.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND   tema.idt_tema = rel_tema_imovel_poligono.idt_tema AND GeometryType(the_geom)='POLYGON';" -nln acsa2_prot_area_liquida -nlt POLYGON

ogr2ogr -f "SQLite" -update -append  acsa_area6e7.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    imovel.idt_imovel,    imovel.cod_imovel,    imovel.cod_protocolo,    rel_tema_imovel_poligono.idt_tema,    tema.nom_tema,    imovel.dat_protocolo,    imovel.ind_status_imovel,    imovel.ind_tipo_imovel,    imovel.cod_cpf_cadastrante,    imovel.nom_completo_cadastrante,    imovel.nom_imovel,     imovel.num_area_imovel as area_imovel, rel_tema_imovel_poligono.num_area as area_tema,    imovel.num_modulo_fiscal,    imovel.dat_criacao,    imovel.dat_atualizacao,    municipio.idt_municipio,    municipio.nom_municipio,    municipio.cod_estado,    rel_tema_imovel_poligono.the_geom FROM    usr_geocar_aplicacao.imovel,    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    usr_geocar_aplicacao.tema WHERE    imovel.cod_protocolo='$line' AND   municipio.idt_municipio = imovel.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND   tema.idt_tema = rel_tema_imovel_poligono.idt_tema AND GeometryType(the_geom)='MULTIPOLYGON';" -nln acsa2_prot_temas -nlt MULTIPOLYGON







done < /sfb/ARQUIVO/SFB/CAR/Demandas/fndf_012015/acsa/Pasta1OACSALLote6.csv

while read line 
	do 

	echo $line

		ogr2ogr -f "SQLite" -update -append  acsa_area6e7.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    imovel.idt_imovel,    imovel.cod_imovel,    imovel.cod_protocolo,    rel_tema_imovel_poligono.idt_tema,    tema.nom_tema,   imovel.dat_protocolo,    imovel.ind_status_imovel,    imovel.ind_tipo_imovel,    imovel.cod_cpf_cadastrante,    imovel.nom_completo_cadastrante,    imovel.nom_imovel,    imovel.num_area_imovel as area_imovel, rel_tema_imovel_poligono.num_area as area_tema,    imovel.num_modulo_fiscal,    imovel.dat_criacao,    imovel.dat_atualizacao,    municipio.idt_municipio,    municipio.nom_municipio,    municipio.cod_estado,    rel_tema_imovel_poligono.the_geom FROM    usr_geocar_aplicacao.imovel,    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    usr_geocar_aplicacao.tema WHERE    imovel.cod_imovel='$line' AND   municipio.idt_municipio = imovel.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND   tema.idt_tema = rel_tema_imovel_poligono.idt_tema AND GeometryType(the_geom)='POLYGON';" -nln acsa3_area_liquida -nlt POLYGON

ogr2ogr -f "SQLite" -update -append  acsa_area6e7.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    imovel.idt_imovel,    imovel.cod_imovel,    imovel.cod_protocolo,    rel_tema_imovel_poligono.idt_tema,    tema.nom_tema,    imovel.dat_protocolo,    imovel.ind_status_imovel,    imovel.ind_tipo_imovel,    imovel.cod_cpf_cadastrante,    imovel.nom_completo_cadastrante,    imovel.nom_imovel,     imovel.num_area_imovel as area_imovel, rel_tema_imovel_poligono.num_area as area_tema,    imovel.num_modulo_fiscal,    imovel.dat_criacao,    imovel.dat_atualizacao,    municipio.idt_municipio,    municipio.nom_municipio,    municipio.cod_estado,    rel_tema_imovel_poligono.the_geom FROM    usr_geocar_aplicacao.imovel,    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    usr_geocar_aplicacao.tema WHERE    imovel.cod_imovel='$line' AND   municipio.idt_municipio = imovel.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND   tema.idt_tema = rel_tema_imovel_poligono.idt_tema AND GeometryType(the_geom)='MULTIPOLYGON';" -nln acsa3_temas -nlt MULTIPOLYGON


		ogr2ogr -f "SQLite" -update -append  acsa_area6e7.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    imovel.idt_imovel,    imovel.cod_imovel,    imovel.cod_protocolo,    rel_tema_imovel_poligono.idt_tema,    tema.nom_tema,    imovel.dat_protocolo,    imovel.ind_status_imovel,    imovel.ind_tipo_imovel,    imovel.cod_cpf_cadastrante,    imovel.nom_completo_cadastrante,    imovel.nom_imovel,     imovel.num_area_imovel as area_imovel, rel_tema_imovel_poligono.num_area as area_tema,    imovel.num_modulo_fiscal,    imovel.dat_criacao,    imovel.dat_atualizacao,    municipio.idt_municipio,    municipio.nom_municipio,    municipio.cod_estado,    rel_tema_imovel_poligono.the_geom FROM    usr_geocar_aplicacao.imovel,    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    usr_geocar_aplicacao.tema WHERE    imovel.cod_protocolo='$line' AND   municipio.idt_municipio = imovel.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND   tema.idt_tema = rel_tema_imovel_poligono.idt_tema AND GeometryType(the_geom)='POLYGON';" -nln acsa3_prot_area_liquida -nlt POLYGON

ogr2ogr -f "SQLite" -update -append  acsa_area6e7.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    imovel.idt_imovel,    imovel.cod_imovel,    imovel.cod_protocolo,    rel_tema_imovel_poligono.idt_tema,    tema.nom_tema,    imovel.dat_protocolo,    imovel.ind_status_imovel,    imovel.ind_tipo_imovel,    imovel.cod_cpf_cadastrante,    imovel.nom_completo_cadastrante,    imovel.nom_imovel,     imovel.num_area_imovel as area_imovel, rel_tema_imovel_poligono.num_area as area_tema,    imovel.num_modulo_fiscal,    imovel.dat_criacao,    imovel.dat_atualizacao,    municipio.idt_municipio,    municipio.nom_municipio,    municipio.cod_estado,    rel_tema_imovel_poligono.the_geom FROM    usr_geocar_aplicacao.imovel,    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    usr_geocar_aplicacao.tema WHERE    imovel.cod_protocolo='$line' AND   municipio.idt_municipio = imovel.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND   tema.idt_tema = rel_tema_imovel_poligono.idt_tema AND GeometryType(the_geom)='MULTIPOLYGON';" -nln acsa3_prot_temas -nlt MULTIPOLYGON







done < /sfb/ARQUIVO/SFB/CAR/Demandas/fndf_012015/acsa/Pasta1OACSALLote7.csv
