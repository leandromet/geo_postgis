SELECT  DISTINCT ON (i.idt_imovel)   i.idt_imovel,   ip.nom_completo,   i.nom_imovel,   substring(ip.cod_cpf_cnpj from 0 for 6) as cpf_inic,
    ST_Centroid(i.geo_area_imovel) as geom,   i.num_modulo_fiscal as num_mf,   round(cast(sum(i.num_area_imovel)as numeric),3) as area_ir,
       round(cast(sum(case when app.idt_tema=30 then app.num_area else 0 end)as numeric),3) as area_app, 
          round(cast(sum(case when app.idt_tema=32 then app.num_area else 0 end)as numeric),3) as area_rl, 
            round(cast(sum(case when app.idt_tema=2 then app.num_area else 0 end)as numeric),3) as area_rvn 
            FROM    usr_geocar_aplicacao.imovel i,    usr_geocar_aplicacao.imovel_pessoa ip,    usr_geocar_aplicacao.rel_tema_imovel_poligono app 
            WHERE   i.ind_status_imovel IN ('AT','PE') AND i.idt_imovel BETWEEN 0 AND 10000 AND   app.idt_tema IN (2,26,30,32) 
            AND   i.idt_imovel = ip.idt_imovel AND   app.idt_imovel = i.idt_imovel GROUP BY i.idt_imovel, ip.idt_imovel_pessoa
