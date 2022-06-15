 SELECT 
  municipio.idt_municipio, 
  municipio.nom_municipio, 
  municipio.cod_estado
FROM 
  usr_geocar_aplicacao.municipio
  where cod_estado = 'SC' and
  municipio.nom_municipio in ('Vargem', 'Curitibanos', 'São José do Cerrito', 'Brunópolis' , 'Frei Rogério');
