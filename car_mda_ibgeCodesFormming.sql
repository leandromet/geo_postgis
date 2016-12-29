create table mda_codigos as
SELECT 
  municipios_mda.nom_municipio, 
  municipios_mda.codmun, 
  municipios_mda.qtd_custeio, 
  municipios_mda.vlr_custeio, 
  municipios_mda.qtd_invest, 
  municipios_mda.vlr_invest, 
  municipios_mda.quantidade, 
  municipios_mda.valor, 
  municipios_mda.cod_estado, 
  estado.cod_estado_ibge,
  ((estado.cod_estado_ibge*100000)+municipios_mda.codmun) as codestmun
FROM 
  sfb_result.municipios_mda, 
  usr_geocar_aplicacao.estado
WHERE 
  estado.cod_estado = municipios_mda.cod_estado;
