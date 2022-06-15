SELECT 
  municipio.idt_municipio, 
  municipios_mda_uf.idt_municipio2, 
  municipios_mda_uf.cod_estado2, 
  municipio.cod_estado, 
  municipio.nom_municipio, 
  municipios_mda_uf.nom_municipio as muni_mda
FROM 
  usr_geocar_aplicacao.municipio, 
  sfb_result.municipios_mda_uf
WHERE 
municipios_mda_uf.cod_estado2=municipio.cod_estado AND
  REPLACE(usr_geocar_aplicacao.unaccent_string(UPPER(municipio.nom_municipio)), ' ','') LIKE REPLACE(usr_geocar_aplicacao.unaccent_string(municipios_mda_uf.nom_municipio), ' ','')
  order by cod_estado, muni_mda;
