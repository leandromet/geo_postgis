 ("reg_gbif" is not null)+( "reg_jabot" is not null)+( "reg_sibbr" is not null)+( "reg_splink" is not null)



 if("reg_gbif" is null, 0, "reg_gbif")
 + 
 if("reg_jabot" is null, 0, "reg_jabot")
 +
if( "reg_sibbr" is null, 0, "reg_sibbr")
 + 
 if("reg_splink" is null, 0, "reg_splink")

 (if("reg_gbif" is null, 0, "reg_gbif")
 + 
 if("reg_jabot" is null, 0, "reg_jabot")
 +
if( "reg_sibbr" is null, 0, "reg_sibbr")
 + 
 if("reg_splink" is null, 0, "reg_splink"))>=2

 "reg_gbif" + "reg_jabot" + "reg_sibbr" + "reg_splink" 

"SIGLA" ||'-'|| upper("TEMPERATUR")||'-'|| upper("RELEVO") ||'-'|| "CHUVA"

"SIGLA"||'-'|| upper("RELEVO") ||'-'|| upper("TEMPERATUR") ||'-'|| "CHUVA"

'Mun:'||"MUN" ||'\nIBGE:' ||  "mu_nm_muni" 
 "legenda_1" ||  "legenda_2" 

 "CHUVA" || '-' ||  upper("RELEVO") || '-' ||  upper("TEMPERATUR" )

"nm_municip" in ('SANTA TERESA',
'SANTA MARIA DE JETIBÁ',
'SANTA LEOPOLDINA',
'ITAGUAÇU',
'ITARANA' )

 year( "date" )

 "ID_WCMC2" || ' - '||"NOME_UC1"

"terrai_nom" || '\n' ||  "etnia_nome" 
"legenda_1" || '-'||  "legenda_2" 
 "nm_micro" || '\n' || (round("area_ha"/100)) || ' Km2'
(round("area_ha"/100)) || ' Km2'

 "zona" || ' - ' ||  "tp_umidade" || ' - ' ||  "distr_umid" 

 "NOM_UNIDAD" not like ('%Massa%')




$area/10000
 round($area /10000,4)
 replace("Phylum" ,'Angiospermae' , 'Angiospermas' )
replace( "class" ,'\n','')
left( "p_xlink_href" ,189)|| "wkt_geom" 
replace(left( "p_xlink_href" ,185),'png','GeoTIFF')|| "wkt_geom" 
'&width='||round(4*472.6*(x_max( $geometry)-x_min( $geometry)),0)||'&height='||round(4*472.6*(y_max( $geometry)-y_min( $geometry)),0)||'&BBOX='|| x_min(  $geometry )||','|| y_min( $geometry)||','|| x_max($geometry)||','|| y_max( $geometry)
'&width='||round(472.6*(x_max( $geometry)-x_min( $geometry)),0)||'&height='||round(472.6*(y_max( $geometry)-y_min( $geometry)),0)||'&BBOX='|| x_min(  $geometry )||','|| y_min( $geometry)||','|| x_max($geometry)||','|| y_max( $geometry)
area(transform(  $geometry , 'EPSG:4674', 'EPSG:102033'))
