
SELECT 
 count( imovel.idt_imovel),
    imovel.ind_tipo_imovel, 
  municipio.cod_estado, 
  imovel.ind_status_imovel, 
  imovel.des_condicao, 
  restricao.nm_restricao, 
  historico_imovel_restricao.des_descricao
FROM 
  usr_geocar_aplicacao.historico_imovel_restricao, 
  usr_geocar_aplicacao.restricao, 
  usr_geocar_aplicacao.municipio, 
  usr_geocar_aplicacao.imovel
WHERE 
  historico_imovel_restricao.idt_restricao is not null and
  restricao.id_restricao = historico_imovel_restricao.idt_restricao AND
  municipio.idt_municipio = imovel.idt_municipio AND
  imovel.cod_imovel = historico_imovel_restricao.cod_imovel

group by

    imovel.ind_tipo_imovel, 
  municipio.cod_estado, 
  imovel.ind_status_imovel, 
  imovel.des_condicao, 
  restricao.nm_restricao, 
  historico_imovel_restricao.des_descricao
