SELECT 
 count( imovel.idt_imovel),
    imovel.ind_tipo_imovel, 
  municipio.cod_estado, 
  imovel.ind_status_imovel, 
  imovel.des_condicao 
FROM 
  usr_geocar_aplicacao.municipio, 
  usr_geocar_aplicacao.imovel
WHERE 


  municipio.idt_municipio = imovel.idt_municipio 
group by

    imovel.ind_tipo_imovel, 
  municipio.cod_estado, 
  imovel.ind_status_imovel, 
  imovel.des_condicao
