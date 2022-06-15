SELECT 
  sf_municipio_priori.cod_estado, 
  sf_municipio_priori.nom_municipio, 
  resposta_pergunta.idt_pergunta, 
  resposta_pergunta.des_resposta, 
  count(resposta_imovel.idt_resposta_imovel)
FROM 
  usr_geocar_aplicacao.imovel, 
  sfb_result.sf_municipio_priori, 
  usr_geocar_aplicacao.resposta_pergunta, 
  usr_geocar_aplicacao.resposta_imovel
WHERE 
  resposta_pergunta.idt_resposta_pergunta in (1,2) and
  imovel.idt_municipio = sf_municipio_priori.idt_municipio AND
  resposta_imovel.idt_imovel = imovel.idt_imovel AND
  resposta_imovel.idt_resposta_pergunta = resposta_pergunta.idt_resposta_pergunta and imovel.ind_status_imovel in ('AT','PE')

  group by sf_municipio_priori.cod_estado, 
  sf_municipio_priori.nom_municipio,
    resposta_pergunta.idt_pergunta, 
  resposta_pergunta.des_resposta
  order by sf_municipio_priori.cod_estado, 
  sf_municipio_priori.nom_municipio,
    resposta_pergunta.idt_pergunta, 
  resposta_pergunta.des_resposta;


SELECT 
  sf_municipio_priori.cod_estado, 
  sf_municipio_priori.nom_municipio, 
  count(rel_imovel_nascente.idt_rel_imovel_nascente)
FROM 
  usr_geocar_aplicacao.imovel, 
  sfb_result.sf_municipio_priori, 
  usr_geocar_aplicacao.rel_imovel_nascente
WHERE 
  imovel.idt_municipio = sf_municipio_priori.idt_municipio AND
  rel_imovel_nascente.idt_imovel = imovel.idt_imovel and imovel.ind_status_imovel in ('AT','PE')
  group by sf_municipio_priori.cod_estado, 
  sf_municipio_priori.nom_municipio
  order by sf_municipio_priori.cod_estado, 
  sf_municipio_priori.nom_municipio;
 
