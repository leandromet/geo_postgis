create table sfb_result.temas_areas as SELECT 
  municipio.cod_estado, 
  tema.nom_tema, 
  sum(temas_json.num_area)
FROM 
  sfb_result.imovel_tabular_20160309, 
  sfb_result.temas_json, 
  usr_geocar_aplicacao.municipio, 
  usr_geocar_aplicacao.tema
WHERE 
imovel_tabular_20160309.ind_status_imovel in ('AT','PE') AND
  temas_json.idt_imovel = imovel_tabular_20160309.idt_imovel AND
  municipio.idt_municipio = imovel_tabular_20160309.idt_municipio AND
  tema.idt_tema = temas_json.idt_tema
  group by municipio.cod_estado, 
  tema.nom_tema
  order by municipio.cod_estado, 
  tema.nom_tema;
