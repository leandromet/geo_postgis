SELECT
    usr_geocar_aplicacao.tema.nom_tema,
    usr_geocar_aplicacao.municipio.cod_estado,
    SUM(usr_geocar_aplicacao.imovel.num_area_imovel),
    SUM(usr_geocar_aplicacao.rel_tema_imovel_poligono.num_area)
FROM
    usr_geocar_aplicacao.rel_tema_imovel_poligono
INNER JOIN
    usr_geocar_aplicacao.tema
ON
    (
        usr_geocar_aplicacao.rel_tema_imovel_poligono.idt_tema = usr_geocar_aplicacao.tema.idt_tema
    )
INNER JOIN
    usr_geocar_aplicacao.imovel
ON
    (
        usr_geocar_aplicacao.rel_tema_imovel_poligono.idt_imovel =
        usr_geocar_aplicacao.imovel.idt_imovel)
INNER JOIN
    usr_geocar_aplicacao.municipio
ON
    (
        usr_geocar_aplicacao.imovel.idt_municipio = usr_geocar_aplicacao.municipio.idt_municipio)
WHERE
    usr_geocar_aplicacao.imovel.flg_ativo = TRUE
GROUP BY
    usr_geocar_aplicacao.tema.nom_tema,
    usr_geocar_aplicacao.municipio.cod_estado ;
