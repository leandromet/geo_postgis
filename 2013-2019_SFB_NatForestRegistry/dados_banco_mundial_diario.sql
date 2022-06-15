SELECT   data, 
cod_estado,  
nom_municipio,  
inn.idt_municipio,   
mf,      
count(inn.idt_imovel) AS numero_total,
sum(inn.num_area_imovel) as area, 
resposta_imovel.idt_resposta_pergunta as adere_pra,  
sum(quadro_area.num_area_reserva_legal_proposta) as rl_prop,  
sum(quadro_area.num_area_reserva_legal_excedente_passivo) as ex_pass,  
sum(quadro_area.num_area_app_area_consolidada) as app_consolidado,   
sum(quadro_area.num_area_app_area_antropizada) as app_antrop,  
sum(quadro_area.num_area_app_recompor) as app_recomp,   
sum(quadro_area.num_area_app_vegetacao_nativa) as app_rvn, 
sum(quadro_area.num_area_reserva_legal_recompor_area_consolidada) as rl_consol,  
sum(quadro_area.num_area_reserva_legal_recompor_area_antropizada) as rl_antrop,  
sum(quadro_area.num_area_reserva_legal_vegetacao_nativa) as rl_rvn,  
sum(quadro_area.num_area_vegetacao_nativa) as rvn,
sum(quadro_area.num_area_consolidada) as consol,   
sum(quadro_area.num_area_reserva_legal_recompor) as rl_recomp,   
sum(quadro_area.num_area_preservacao_permanente) as app 

FROM    usr_geocar_aplicacao.resposta_imovel,  
relatorio.quadro_area ,(SELECT cod_estado,   
                        nom_municipio,  
                        m.idt_municipio,
                        idt_imovel,
                        num_area_imovel,
                        TO_CHAR(dat_criacao,'yyyy-mm' ) as data, 
                        CASE     WHEN num_modulo_fiscal < 4 THEN '0 a 4 MF'    
                        WHEN num_modulo_fiscal >= 4  AND num_modulo_fiscal < 15 THEN '4 e 15 MF'
                        WHEN num_modulo_fiscal >= 15 THEN 'superior a 15MF'             END AS mf 
                  FROM    usr_geocar_aplicacao.imovel i          
                        INNER JOIN              usr_geocar_aplicacao.municipio m 
                        ON i.idt_municipio = m.idt_municipio   
                        
                        WHERE   (flg_ativo = TRUE       
                                 AND ind_status_imovel in ('AT','PE') 
                                 and (   i.idt_municipio in (2919405, 2930006, 2932606, 2924504, 2923407, 
                                                             2926400, 2930907, 2904407, 2922250, 2909703, 
                                                             2933455, 2901403, 2909406, 2907400, 2913200,
                                                             2921609, 2923704, 2928109, 2928208, 2906105,
                                                             2930758, 2930303, 2902500, 2903904, 2928406,
                                                             2902708, 2933604, 2920452, 2904753, 2924405,
                                                             2911105, 2919553, 2903201, 2926202, 2908101,
                                                             2917359, 2909109, 2909307, 2928901, 2907103,
                                                             2930154, 2920205, 2917334, 2910776, 2929057,
                                                             5300108, 5204409, 5205307, 5206206, 5206404,
                                                             5207907, 5211909, 5213087, 5213103, 5213806,
                                                             5214606, 5214903, 5218003, 5218805, 2100303,
                                                             2100501, 2100808, 2101400, 2101608, 2101731,
                                                             2102101, 2102200, 2103000, 2103208, 2103307,
                                                             2103604, 2106409, 2106672, 2107209, 2107803,
                                                             2109502, 2110104, 2110237, 2110401, 2110609,
                                                             2112100, 2112308, 2112605, 2112704, 5100201,
                                                             5103106, 5106307, 5107701, 5003306, 5005806,
                                                             5006903, 5007109, 5008008, 3100609, 3104502,
                                                             3106507, 3108255, 3108602, 3109303, 3109402,
                                                             3112307, 3117504, 3120300, 3121605, 3127800,
                                                             3135209, 3135704, 3136306, 3137106, 3138104,
                                                             3138351, 3157609, 3158508, 3164209, 3170529,
                                                             3170800, 4101606, 4112009, 4119400, 3502200,
                                                             3503208, 3505500, 3507506, 1710508, 1713601,
                                                             1714203, 1717503, 1718501, 1718758, 1720903,
                                                             1700400, 1709005, 2200400, 2200509, 2201200,
                                                             2201903, 2202000, 2202174, 2202307, 2202505,
                                                             2202653, 2203107, 2203206, 2203909, 2204659,
                                                             2205102, 2205458, 2205508, 2205557, 2205706,
                                                             2205805, 2205854, 2205904, 2206100, 2206209,
                                                             2206696, 2206720, 2207504, 2207702, 2208502,
                                                             2209971, 2211001, 2211100)) )) inn
                                             WHERE  idt_resposta_pergunta <3 and 
                                                             resposta_imovel.idt_imovel = inn.idt_imovel AND  
                                                             quadro_area.idt_imovel = inn.idt_imovel 
                           GROUP BY data, cod_estado, inn.idt_municipio,nom_municipio, mf, adere_pra 
                           ORDER BY data, cod_estado, nom_municipio, inn.idt_municipio,  mf, adere_pra
