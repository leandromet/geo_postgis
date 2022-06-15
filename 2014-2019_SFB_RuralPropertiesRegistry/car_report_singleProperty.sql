SELECT 
  imovel.idt_imovel, 
  imovel.cod_imovel, 
  imovel.cod_protocolo, 
  rel_tema_imovel_poligono.idt_tema, 
  tema.nom_tema, 
  imovel.dat_protocolo, 
  imovel.ind_status_imovel, 
  imovel.ind_tipo_imovel, 
  imovel.cod_cpf_cadastrante, 
  imovel.nom_completo_cadastrante, 
  imovel.nom_imovel, 
  imovel.num_area_imovel, 
  imovel.num_modulo_fiscal, 
  imovel.dat_criacao, 
  imovel.dat_atualizacao, 
  municipio.idt_municipio, 
  municipio.nom_municipio, 
  municipio.cod_estado, 
  rel_tema_imovel_poligono.the_geom
FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.municipio, 
  usr_geocar_aplicacao.rel_tema_imovel_poligono, 
  usr_geocar_aplicacao.tema
WHERE 
  imovel.cod_imovel='codigo_imovel' AND
  municipio.idt_municipio = imovel.idt_municipio AND
  rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel AND
  tema.idt_tema = rel_tema_imovel_poligono.idt_tema;
