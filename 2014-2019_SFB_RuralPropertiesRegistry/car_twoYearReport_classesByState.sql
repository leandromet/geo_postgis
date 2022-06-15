SELECT 
  municipio.cod_estado, 
  sum(quadro_area.num_area_liquida_imovel), 
  sum(quadro_area.num_area_app_vegetacao_nativa), 
  sum(quadro_area.num_area_reserva_legal_app), 
  sum(quadro_area.num_area_reserva_legal_vegetacao_nativa), 
  sum(quadro_area.num_area_vegetacao_nativa), 
  sum(quadro_area.num_area_consolidada), 
  sum(quadro_area.num_area_antropizada), 
  sum(quadro_area.num_area_pousio), 
  sum(quadro_area.num_area_imovel), 
  sum(quadro_area.num_area_reserva_legal), 
  sum(quadro_area.num_area_preservacao_permanente)
  
FROM 
  relatorio.quadro_area, 
  usr_geocar_aplicacao.municipio
WHERE 
--quadro_area.flg_sicar = true and
  quadro_area.num_area_liquida_imovel<10000000 and 
  quadro_area.num_area_app_vegetacao_nativa<10000000 and 
  quadro_area.num_area_reserva_legal_app<10000000 and 
  quadro_area.num_area_reserva_legal_vegetacao_nativa<10000000 and 
  quadro_area.num_area_vegetacao_nativa<10000000 and 
  quadro_area.num_area_consolidada<10000000 and 
  quadro_area.num_area_antropizada<10000000 and 
  quadro_area.num_area_pousio<10000000 and 
  quadro_area.num_area_imovel<10000000 and 
  quadro_area.num_area_reserva_legal<10000000 and 
  quadro_area.num_area_preservacao_permanente<10000000 and
  municipio.idt_municipio = quadro_area.idt_municipio
  group by municipio.cod_estado
  order by municipio.cod_estado;
