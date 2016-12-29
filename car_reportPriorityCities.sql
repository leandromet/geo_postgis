SELECT 
  m.idt_municipio, 
  m.nom_municipio, 
  m.cod_estado, m.num_hectares_modulo_fiscal as ha_MF, m.num_area
FROM 
  usr_geocar_aplicacao.municipio m WHERE UPPER(nom_municipio) in
('LÁBREA','BOCA DO ACRE','AMARANTE DO MARANHÃO','GRAJAÚ','VILA RICA','SÃO FÉLIX DO ARAGUAIA',
'PORTO DOS GAÚCHOS','PEIXOTO DE AZEVEDO','PARANAÍTA','NOVA UBIRATÃ','NOVA MARINGÁ',
'NOVA BANDEIRANTES','JUÍNA','GAÚCHA DO NORTE','COTRIGUAÇU','CONFRESA','COLNIZA','ARIPUANÃ',
'JUARA','TAPURAH','SANTA CARMEM','CLÁUDIA','ALTO BOA VISTA','SÃO FÉLIX DO XINGU','SANTA MARIA DAS BARREIRAS',
'RONDON DO PARÁ','NOVO REPARTIMENTO','NOVO PROGRESSO','CUMARU DO NORTE','ALTAMIRA','PACAJÁ','MARABÁ','ITUPIRANGA',
'MOJU','SENADOR JOSÉ PORFÍRIO','ANAPU','PORTO VELHO','PIMENTA BUENO','NOVA MAMORÉ','MUCAJAÍ','QUERÊNCIA','MARCELÂNDIA',
'BRASNORTE','ALTA FLORESTA','FELIZ NATAL','ULIANÓPOLIS',
'SANTANA DO ARAGUAIA','PARAGOMINAS','DOM ELISEU','BRASIL NOVO','TAILÂNDIA') OR UPPER(nom_municipio) LIKE '%MACHADINHO%OESTE%'
order by cod_estado, nom_municipio;




SELECT 
  m.idt_municipio, 
  m.nom_municipio, 
  m.cod_estado,m.num_hectares_modulo_fiscal as ha_MF, m.num_area as area_munic,
  count(i.idt_imovel) as imoveis_car, 
  sum(i.num_area_imovel) as area_car
FROM 
  usr_geocar_aplicacao.municipio m, 
  usr_geocar_aplicacao.imovel i
WHERE 
  (m.idt_municipio = i.idt_municipio AND
  i.flg_ativo=TRUE AND i.ind_status_imovel = 'AT')
 AND (UPPER(nom_municipio) in
('LÁBREA','BOCA DO ACRE','AMARANTE DO MARANHÃO','GRAJAÚ','VILA RICA','SÃO FÉLIX DO ARAGUAIA',
'PORTO DOS GAÚCHOS','PEIXOTO DE AZEVEDO','PARANAÍTA','NOVA UBIRATÃ','NOVA MARINGÁ',
'NOVA BANDEIRANTES','JUÍNA','GAÚCHA DO NORTE','COTRIGUAÇU','CONFRESA','COLNIZA','ARIPUANÃ',
'JUARA','TAPURAH','SANTA CARMEM','CLÁUDIA','ALTO BOA VISTA','SÃO FÉLIX DO XINGU','SANTA MARIA DAS BARREIRAS',
'RONDON DO PARÁ','NOVO REPARTIMENTO','NOVO PROGRESSO','CUMARU DO NORTE','ALTAMIRA','PACAJÁ','MARABÁ','ITUPIRANGA',
'MOJU','SENADOR JOSÉ PORFÍRIO','ANAPU','PORTO VELHO','PIMENTA BUENO','NOVA MAMORÉ','MUCAJAÍ','QUERÊNCIA','MARCELÂNDIA',
'BRASNORTE','ALTA FLORESTA','FELIZ NATAL','ULIANÓPOLIS',
'SANTANA DO ARAGUAIA','PARAGOMINAS','DOM ELISEU','BRASIL NOVO','TAILÂNDIA') OR UPPER(nom_municipio) LIKE '%MACHADINHO%OESTE%')
GROUP BY   m.cod_estado,  m.idt_municipio, m.nom_municipio
order by cod_estado, nom_municipio;


SELECT 
  m.idt_municipio, 
  m.nom_municipio, 
  m.cod_estado, m.num_area, count(i.cod_imovel) as imoveis_car, 
  sum(i.num_area_imovel) as area_car
FROM 
  usr_geocar_aplicacao.municipio m , usr_geocar_aplicacao.imovel i WHERE m.idt_municipio = i.idt_municipio AND
  (UPPER(nom_municipio) in
('LÁBREA','BOCA DO ACRE','AMARANTE DO MARANHÃO','GRAJAÚ','VILA RICA','SÃO FÉLIX DO ARAGUAIA',
'PORTO DOS GAÚCHOS','PEIXOTO DE AZEVEDO','PARANAÍTA','NOVA UBIRATÃ','NOVA MARINGÁ',
'NOVA BANDEIRANTES','JUÍNA','GAÚCHA DO NORTE','COTRIGUAÇU','CONFRESA','COLNIZA','ARIPUANÃ',
'JUARA','TAPURAH','SANTA CARMEM','CLÁUDIA','ALTO BOA VISTA','SÃO FÉLIX DO XINGU','SANTA MARIA DAS BARREIRAS',
'RONDON DO PARÁ','NOVO REPARTIMENTO','NOVO PROGRESSO','CUMARU DO NORTE','ALTAMIRA','PACAJÁ','MARABÁ','ITUPIRANGA',
'MOJU','SENADOR JOSÉ PORFÍRIO','ANAPU','PORTO VELHO','PIMENTA BUENO','NOVA MAMORÉ','MUCAJAÍ','QUERÊNCIA','MARCELÂNDIA',
'BRASNORTE','ALTA FLORESTA','FELIZ NATAL','ULIANÓPOLIS',
'SANTANA DO ARAGUAIA','PARAGOMINAS','DOM ELISEU','BRASIL NOVO','TAILÂNDIA') OR UPPER(nom_municipio) LIKE '%MACHADINHO%OESTE%')
GROUP BY   m.idt_municipio
order by cod_estado, nom_municipio;
