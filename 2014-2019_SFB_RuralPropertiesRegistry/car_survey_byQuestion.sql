
SELECT 
  municipio.cod_estado, 
  municipio.nom_municipio,
  resposta_imovel.idt_resposta_pergunta, 
  resposta_pergunta.des_resposta, 
  pergunta.des_pergunta, 
  count(imovel.idt_imovel) AS contagem
  
FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.resposta_imovel, 
  usr_geocar_aplicacao.pergunta, 
  usr_geocar_aplicacao.resposta_pergunta, 
  usr_geocar_aplicacao.municipio
WHERE 
  municipio.cod_estado='RO' and
  resposta_imovel.idt_resposta_pergunta IN (1,2,3,4,5,6,7) AND flg_ativo = TRUE
	AND ( ind_status_imovel = 'AT' OR ind_status_imovel = 'PE' ) AND
  resposta_imovel.idt_imovel = imovel.idt_imovel AND 
  resposta_pergunta.idt_resposta_pergunta=resposta_imovel.idt_resposta_pergunta AND
  resposta_pergunta.idt_pergunta = pergunta.idt_pergunta AND
  resposta_pergunta.idt_resposta_pergunta = resposta_imovel.idt_resposta_pergunta AND
  municipio.idt_municipio = imovel.idt_municipio
Group By municipio.nom_municipio,resposta_imovel.idt_resposta_pergunta, resposta_pergunta.des_resposta, 
  pergunta.des_pergunta
order by municipio.nom_municipio,resposta_imovel.idt_resposta_pergunta;
