SELECT 
  municipio.nom_municipio, 
  imovel.idt_municipio, 
  imovel.ind_tipo_imovel, 
  imovel.cod_imovel, 
  substring(tema.nom_tema from 0 for 30) as nom_tema, 
  round(rel_tema_imovel_poligono.num_area::numeric, 2) as area_imovel, 
  rel_tema_imovel_poligono.the_geom

FROM 
  usr_geocar_aplicacao.rel_tema_imovel_poligono, 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.municipio, 
  usr_geocar_aplicacao.tema
WHERE 
  cod_estado = 'SC' and
  municipio.nom_municipio in ('Vargem', 'Curitibanos', 'São José do Cerrito', 'Brunópolis' , 'Frei Rogério') AND
  imovel.ind_status_imovel in ('AT', 'PE') AND
  tema.idt_tema IN (26,27,30,31,32) AND
  rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND
  municipio.idt_municipio = imovel.idt_municipio AND
  tema.idt_tema = rel_tema_imovel_poligono.idt_tema
ORDER BY nom_municipio,imovel.ind_tipo_imovel, cod_imovel, nom_tema
limit 25
  ;
