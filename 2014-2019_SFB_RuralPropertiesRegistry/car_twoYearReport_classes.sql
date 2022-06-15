SELECT 
  municipio.cod_estado, 
  tema.idt_tema, 
  tema.nom_tema, 
  sum(rel_tema_imovel_poligono.num_area)
FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.rel_tema_imovel_poligono, 
  usr_geocar_aplicacao.municipio, 
  usr_geocar_aplicacao.tema
WHERE 
  rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND
  municipio.idt_municipio = imovel.idt_municipio AND
  tema.idt_tema = rel_tema_imovel_poligono.idt_tema AND
  imovel.ind_status_imovel IN ('AT','PE') AND 
  rel_tema_imovel_poligono.idt_tema IN (1,2,3,6,16,26,27,30,31,32,59,82)
group by 
  municipio.cod_estado, 
  tema.idt_tema
ORDER BY
  municipio.cod_estado ASC, 
  tema.idt_tema ASC;
