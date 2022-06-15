
SELECT 
  imovel.dat_criacao, 
  imovel.dat_atualizacao, 
  imovel.ind_tipo_imovel, 
  imovel.nom_imovel,
  imovel.cod_imovel,
  municipio.cod_estado, 
  imovel.ind_status_imovel, 
  imovel.des_condicao, 
  restricao.nm_restricao, 
  imovel.idt_imovel,
  historico_imovel_restricao.idt_historico_imovel_restricao, 
  historico_imovel_restricao.idt_restricao, 
  historico_imovel_restricao.idt_origem, 
  historico_imovel_restricao.des_descricao, 
  historico_imovel_restricao.num_area_conflito, 
  historico_imovel_restricao.num_percentual, 
  historico_imovel_restricao.dat_cadastro, 
  historico_imovel_restricao.idt_vigencia, 
  historico_imovel_restricao.dat_modificacao, 
  historico_imovel_restricao.ind_acao, 
  historico_imovel_restricao.num_centroide_x, 
  historico_imovel_restricao.num_centroide_y
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

  limit 10
