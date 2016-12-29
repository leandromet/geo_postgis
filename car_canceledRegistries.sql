SELECT 
  municipio.cod_estado, 
  i.ind_status_imovel,
  sum(i.num_area_imovel) as area_imovel, 
  count(i.idt_imovel_anterior!=0),
  sum(old.num_area_imovel) as area_antiga
FROM 
  usr_geocar_aplicacao.imovel i
	JOIN usr_geocar_aplicacao.imovel old ON old.idt_imovel = i.idt_imovel_anterior AND old.num_area_imovel<100000
  , 
  usr_geocar_aplicacao.municipio
WHERE 
  --imovel.idt_imovel_anterior = imovel.idt_imovel AND
  municipio.idt_municipio = i.idt_municipio AND
  
  (i.ind_status_imovel = 'AT' OR 
  i.ind_status_imovel = 'CA') --AND 
  --(i.dat_criacao >= to_date('01/01/2015','dd/mm/yyyy') OR 
  --i.dat_atualizacao >= to_date('01/01/2015','dd/mm/yyyy'))
GROUP BY
cod_estado, i.ind_status_imovel
ORDER BY
cod_estado, i.ind_status_imovel
  ;
