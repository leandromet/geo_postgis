SELECT municipio.cod_estado,  
 tema.nom_tema,
 sum(rel_tema_imovel_poligono.num_area),   
 count(rel_tema_imovel_poligono.idt_rel_tema_imovel) 
 FROM    usr_geocar_aplicacao.imovel,  
 usr_geocar_aplicacao.rel_tema_imovel_poligono,  
 usr_geocar_aplicacao.tema,   
 usr_geocar_aplicacao.municipio
 WHERE    municipio.cod_estado='RO'  
 AND imovel.ind_status_imovel IN ('AT','PE') 
 AND    imovel.flg_ativo = TRUE AND   rel_tema_imovel_poligono.num_area < 50000000 
 AND   rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel 
 AND   tema.idt_tema = rel_tema_imovel_poligono.idt_tema 
 AND   municipio.idt_municipio = imovel.idt_municipio 
 group by municipio.cod_estado, nom_tema order by municipio.cod_estado, nom_tema;
