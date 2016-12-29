SELECT 
  imovel.idt_imovel, 
  imovel.cod_imovel, 
  imovel_pessoa.idt_imovel_pessoa, 
  imovel_pessoa.cod_cpf_cnpj, 
  imovel.num_area_imovel
FROM 
  usr_geocar_aplicacao.imovel_pessoa, 
  usr_geocar_aplicacao.imovel
WHERE 
  imovel.cod_imovel in ('codigo','codigo','codigo')
  and imovel_pessoa.idt_imovel = imovel.idt_imovel;
