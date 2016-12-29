SELECT 
  imovel.cod_imovel, 
  imovel_pessoa.ind_tipo_pessoa, 
  imovel_pessoa.dat_nascimento, 
  pergunta.cod_pergunta, 
  resposta_pergunta.cod_resposta, 
  imovel.num_area_imovel, 
  imovel.num_modulo_fiscal, 
  imovel.idt_municipio

FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.imovel_pessoa, 
  usr_geocar_aplicacao.pergunta, 
  usr_geocar_aplicacao.resposta_imovel, 
  usr_geocar_aplicacao.resposta_pergunta
WHERE 
  imovel.ind_status_imovel in ('AT', 'PE') AND
  imovel_pessoa.idt_imovel = imovel.idt_imovel AND
  pergunta.idt_pergunta = resposta_pergunta.idt_pergunta AND
  resposta_imovel.idt_imovel = imovel_pessoa.idt_imovel AND
  resposta_pergunta.idt_resposta_pergunta = resposta_imovel.idt_resposta_pergunta

  limit 20;
