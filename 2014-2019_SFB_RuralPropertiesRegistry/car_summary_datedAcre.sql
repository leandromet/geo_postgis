SELECT
    usr_geocar_aplicacao.municipio.nom_municipio,
    usr_geocar_aplicacao.imovel.cod_imovel,
    usr_geocar_aplicacao.imovel.num_modulo_fiscal,
    usr_geocar_aplicacao.imovel.dat_protocolo
FROM
    usr_geocar_aplicacao.imovel
INNER JOIN
    usr_geocar_aplicacao.municipio
ON
    (
        usr_geocar_aplicacao.imovel.idt_municipio = usr_geocar_aplicacao.municipio.idt_municipio)
WHERE
    usr_geocar_aplicacao.municipio.cod_estado = 'AC'
AND usr_geocar_aplicacao.imovel.dat_protocolo BETWEEN '2014-05-12 23:59:59' AND
    '2015-01-01 00:00:00'
AND usr_geocar_aplicacao.imovel.num_modulo_fiscal <= 4

ORDER BY
    usr_geocar_aplicacao.municipio.nom_municipio ASC,
    usr_geocar_aplicacao.imovel.dat_protocolo ASC ;
