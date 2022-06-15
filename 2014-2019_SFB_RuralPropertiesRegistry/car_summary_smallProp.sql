SELECT 
  municipio.nom_municipio, 
  municipio.cod_estado, 
  municipio.num_hectares_modulo_fiscal, 
  imovel.ind_tipo_imovel,  
  count(imovel.idt_imovel),
  sum(num_area_imovel)

FROM 
  usr_geocar_aplicacao.municipio, 
  usr_geocar_aplicacao.imovel
WHERE 
  municipio.idt_municipio = imovel.idt_municipio AND
    imovel.flg_ativo = TRUE AND
    (imovel.ind_status_imovel = 'AT' OR imovel.ind_status_imovel = 'PE')
    AND imovel.num_modulo_fiscal<4;
