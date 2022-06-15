

#!/bin/sh
n=0
while read line 
	do 
	echo $n
	echo $line
	b=${line:0:2}
	echo areas_${b}

		ogr2ogr -f "SQLite" -update -append  quadro_area_at_temas_${b}.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    municipio.cod_estado,    municipio.idt_municipio,    rel_tema_imovel_poligono.idt_imovel,    rel_tema_imovel_poligono.idt_tema,    round(cast(rel_tema_imovel_poligono.num_area as numeric),4) as area_tema,    quadro_area.ind_status_imovel as status_ir,    quadro_area.ind_tipo_imovel as tipo_ir,    quadro_area.num_area_app_recompor as num_app_recomp,    quadro_area.num_area_app_vegetacao_nativa as num_app_rvn,    quadro_area.num_area_reserva_legal_app as num_rl_app,    quadro_area.num_area_reserva_legal_vegetacao_nativa as num_rl_rvn,    round(cast(quadro_area.num_area_vegetacao_nativa as numeric),4) as num_rvn,    round(cast(quadro_area.num_area_sobreposicao_ir as numeric),4) as num_ir_ir,    round(cast(quadro_area.num_area_uc as numeric),4) as num_ir_uc,    round(cast(quadro_area.num_area_ti as numeric),4) as num_ir_ti,    round(cast(quadro_area.num_area_preservacao_permanente as numeric),4) as num_app,    quadro_area.num_modulo_fiscal as num_mf,    quadro_area.num_area_imovel as num_areai,    round(cast(quadro_area.num_area_reserva_legal as numeric),4) as num_rl,    rel_tema_imovel_poligono.the_geom as geom FROM    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    relatorio.quadro_area WHERE  quadro_area.ind_status_imovel in ('AT','PE') and rel_tema_imovel_poligono.idt_tema = 26 and   quadro_area.idt_municipio = $line and   municipio.idt_municipio = quadro_area.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = quadro_area.idt_imovel" -nln areas_${b}_26


		ogr2ogr -f "SQLite" -update -append  quadro_area_at_temas_${b}.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    municipio.cod_estado,    municipio.idt_municipio,    rel_tema_imovel_poligono.idt_imovel,    rel_tema_imovel_poligono.idt_tema,    round(cast(rel_tema_imovel_poligono.num_area as numeric),4) as area_tema,    quadro_area.ind_status_imovel as status_ir,      rel_tema_imovel_poligono.the_geom as geom FROM    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    relatorio.quadro_area WHERE   quadro_area.ind_status_imovel in ('AT','PE') and rel_tema_imovel_poligono.idt_tema = 1 and   quadro_area.idt_municipio = $line and   municipio.idt_municipio = quadro_area.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = quadro_area.idt_imovel" -nln areas_${b}_1

		ogr2ogr -f "SQLite" -update -append  quadro_area_at_temas_${b}.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    municipio.cod_estado,    municipio.idt_municipio,    rel_tema_imovel_poligono.idt_imovel,    rel_tema_imovel_poligono.idt_tema,    round(cast(rel_tema_imovel_poligono.num_area as numeric),4) as area_tema,    quadro_area.ind_status_imovel as status_ir,      rel_tema_imovel_poligono.the_geom as geom FROM    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    relatorio.quadro_area WHERE   quadro_area.ind_status_imovel in ('AT','PE') and rel_tema_imovel_poligono.idt_tema = 2 and   quadro_area.idt_municipio = $line and   municipio.idt_municipio = quadro_area.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = quadro_area.idt_imovel" -nln areas_${b}_2

		ogr2ogr -f "SQLite" -update -append  quadro_area_at_temas_${b}.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    municipio.cod_estado,    municipio.idt_municipio,    rel_tema_imovel_poligono.idt_imovel,    rel_tema_imovel_poligono.idt_tema,    round(cast(rel_tema_imovel_poligono.num_area as numeric),4) as area_tema,    quadro_area.ind_status_imovel as status_ir,      rel_tema_imovel_poligono.the_geom as geom FROM    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    relatorio.quadro_area WHERE   quadro_area.ind_status_imovel in ('AT','PE') and rel_tema_imovel_poligono.idt_tema = 3 and   quadro_area.idt_municipio = $line and   municipio.idt_municipio = quadro_area.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = quadro_area.idt_imovel" -nln areas_${b}_3

		ogr2ogr -f "SQLite" -update -append  quadro_area_at_temas_${b}.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    municipio.cod_estado,    municipio.idt_municipio,    rel_tema_imovel_poligono.idt_imovel,    rel_tema_imovel_poligono.idt_tema,    round(cast(rel_tema_imovel_poligono.num_area as numeric),4) as area_tema,    quadro_area.ind_status_imovel as status_ir,      rel_tema_imovel_poligono.the_geom as geom FROM    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    relatorio.quadro_area WHERE   quadro_area.ind_status_imovel in ('AT','PE') and rel_tema_imovel_poligono.idt_tema = 30 and   quadro_area.idt_municipio = $line and   municipio.idt_municipio = quadro_area.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = quadro_area.idt_imovel" -nln areas_${b}_30


		ogr2ogr -f "SQLite" -update -append  quadro_area_at_temas_${b}.sqlite PG:"host=host.144 user=user dbname=banco"  -sql "SELECT    municipio.cod_estado,    municipio.idt_municipio,    rel_tema_imovel_poligono.idt_imovel,    rel_tema_imovel_poligono.idt_tema,    round(cast(rel_tema_imovel_poligono.num_area as numeric),4) as area_tema,    quadro_area.ind_status_imovel as status_ir,      rel_tema_imovel_poligono.the_geom as geom FROM    usr_geocar_aplicacao.municipio,    usr_geocar_aplicacao.rel_tema_imovel_poligono,    relatorio.quadro_area WHERE   quadro_area.ind_status_imovel in ('AT','PE') and rel_tema_imovel_poligono.idt_tema = 32 and   quadro_area.idt_municipio = $line and   municipio.idt_municipio = quadro_area.idt_municipio AND   rel_tema_imovel_poligono.idt_imovel = quadro_area.idt_imovel" -nln areas_${b}_32



	n=$((n+1))
	


done < /sfb/ARQUIVO/SFB/CAR/Demandas/quadro_area/cod_mun.txt
