-- ADERIR AO PRA

CREATE table imovel_resumo_aderir_pra AS


SELECT 
  count(resposta_imovel.idt_resposta_pergunta) AS adere_pra, 
  municipio.cod_estado
FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.resposta_imovel, 
  usr_geocar_aplicacao.municipio
WHERE 
  resposta_imovel.idt_imovel = imovel.idt_imovel AND
  municipio.idt_municipio = imovel.idt_municipio AND
  imovel.flg_ativo = TRUE AND 
  resposta_imovel.idt_resposta_pergunta = 1
GROUP BY
   municipio.cod_estado;






--QUANTIDADE DE IMOVEIS E AREA


CREATE table imovel_resumo_areas AS
SELECT count(imovel.idt_imovel),
       sum(imovel.num_area_imovel) AS area_imovel,
       m.cod_estado
FROM usr_geocar_aplicacao.imovel,
     usr_geocar_aplicacao.municipio m
WHERE m.idt_municipio = imovel.idt_municipio
  AND imovel.flg_ativo = TRUE
GROUP BY m.cod_estado
ORDER BY m.cod_estado;





--APP TOTAL

CREATE table imovel_resumo_app AS
SELECT sum(rel_tema_imovel_poligono.num_area) AS app,
       municipio.cod_estado,
       tema.nom_tema
FROM usr_geocar_aplicacao.imovel,
     usr_geocar_aplicacao.municipio,
     usr_geocar_aplicacao.tema,
     usr_geocar_aplicacao.rel_tema_imovel_poligono
WHERE municipio.idt_municipio = imovel.idt_municipio
  AND tema.idt_tema = rel_tema_imovel_poligono.idt_tema
  AND tema.idt_tema = 30
  AND rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel
  AND imovel.flg_ativo = TRUE
GROUP BY municipio.cod_estado,
         tema.nom_tema
ORDER BY municipio.cod_estado;





--APP Lei12651

CREATE table imovel_resumo_app12651 AS
SELECT sum(rel_tema_imovel_poligono.num_area) AS app12651,
       municipio.cod_estado,
       tema.nom_tema
FROM usr_geocar_aplicacao.imovel,
     usr_geocar_aplicacao.municipio,
     usr_geocar_aplicacao.tema,
     usr_geocar_aplicacao.rel_tema_imovel_poligono
WHERE municipio.idt_municipio = imovel.idt_municipio
  AND tema.idt_tema = rel_tema_imovel_poligono.idt_tema
  AND tema.idt_tema = 31
  AND rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel
  AND imovel.flg_ativo = TRUE
GROUP BY municipio.cod_estado,
         tema.nom_tema
ORDER BY municipio.cod_estado;





--APP a recuperar

CREATE table imovel_resumo_apprec AS
SELECT sum(rel_tema_imovel_poligono.num_area) AS apprec,
       municipio.cod_estado,
       tema.nom_tema
FROM usr_geocar_aplicacao.imovel,
     usr_geocar_aplicacao.municipio,
     usr_geocar_aplicacao.tema,
     usr_geocar_aplicacao.rel_tema_imovel_poligono
WHERE municipio.idt_municipio = imovel.idt_municipio
  AND tema.idt_tema = rel_tema_imovel_poligono.idt_tema
  AND tema.idt_tema = 34
  AND rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel
  AND imovel.flg_ativo = TRUE
GROUP BY municipio.cod_estado,
         tema.nom_tema
ORDER BY municipio.cod_estado;



--Reserva Legal

CREATE table imovel_resumo_resleg AS
SELECT sum(rel_tema_imovel_poligono.num_area) AS resleg,
       municipio.cod_estado,
       tema.nom_tema
FROM usr_geocar_aplicacao.imovel,
     usr_geocar_aplicacao.municipio,
     usr_geocar_aplicacao.tema,
     usr_geocar_aplicacao.rel_tema_imovel_poligono
WHERE municipio.idt_municipio = imovel.idt_municipio
  AND tema.idt_tema = rel_tema_imovel_poligono.idt_tema
  AND tema.idt_tema = 31
  AND rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel
  AND imovel.flg_ativo = TRUE
GROUP BY municipio.cod_estado,
         tema.nom_tema
ORDER BY municipio.cod_estado;




--Reserva Legal a recuperar

CREATE table imovel_resumo_reslegrec AS
SELECT sum(rel_tema_imovel_poligono.num_area) AS reslegrec,
       municipio.cod_estado,
       tema.nom_tema
FROM usr_geocar_aplicacao.imovel,
     usr_geocar_aplicacao.municipio,
     usr_geocar_aplicacao.tema,
     usr_geocar_aplicacao.rel_tema_imovel_poligono
WHERE municipio.idt_municipio = imovel.idt_municipio
  AND tema.idt_tema = rel_tema_imovel_poligono.idt_tema
  AND tema.idt_tema = 31
  AND rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel
  AND imovel.flg_ativo = TRUE
GROUP BY municipio.cod_estado,
         tema.nom_tema
ORDER BY municipio.cod_estado;



--Remanescente de Vegetação Nativa

CREATE table imovel_resumo_reman_veg AS

SELECT sum(rel_tema_imovel_poligono.num_area) AS rem_veg,
       municipio.cod_estado,
       tema.nom_tema
FROM usr_geocar_aplicacao.imovel,
     usr_geocar_aplicacao.municipio,
     usr_geocar_aplicacao.tema,
     usr_geocar_aplicacao.rel_tema_imovel_poligono
WHERE municipio.idt_municipio = imovel.idt_municipio
  AND tema.idt_tema = rel_tema_imovel_poligono.idt_tema
  AND tema.idt_tema = 2
  AND rel_tema_imovel_poligono.idt_imovel = imovel.idt_imovel
  AND imovel.flg_ativo = TRUE
GROUP BY municipio.cod_estado,
         tema.nom_tema
ORDER BY municipio.cod_estado;


--NASCENTE

CREATE table imovel_resumo_nascente AS

SELECT count(rel_tema_imovel_ponto.idt_rel_tema_imovel) AS count_nascente,
       municipio.cod_estado,
       tema.nom_tema
FROM usr_geocar_aplicacao.imovel,
     usr_geocar_aplicacao.municipio,
     usr_geocar_aplicacao.tema,
     usr_geocar_aplicacao.rel_tema_imovel_ponto
WHERE municipio.idt_municipio = imovel.idt_municipio
  AND tema.idt_tema = rel_tema_imovel_ponto.idt_tema
  AND tema.idt_tema = 15
  AND rel_tema_imovel_ponto.idt_imovel = imovel.idt_imovel

  AND imovel.flg_ativo = TRUE
GROUP BY municipio.cod_estado,
         tema.nom_tema
ORDER BY municipio.cod_estado;




﻿---Area ha <=100ha

create table imovel_resumo_menor100ha as

SELECT 
  municipio.cod_estado,
  municipio.nom_municipio, 
  count(imovel.idt_imovel), 
  sum(imovel.num_area_imovel)

FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.municipio

WHERE 
  imovel.idt_municipio = municipio.idt_municipio AND
  imovel.flg_ativo = TRUE AND 
  imovel.num_area_imovel <= 100

GROUP BY
  municipio.cod_estado, 
  municipio.nom_municipio
ORDER BY
  municipio.cod_estado ASC, 
  municipio.nom_municipio ASC;

--Area ha 100 a 500

create table imovel_resumo_100a500ha as

SELECT 
  municipio.cod_estado,
  municipio.nom_municipio, 
  count(imovel.idt_imovel), 
  sum(imovel.num_area_imovel)

FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.municipio

WHERE 
  imovel.idt_municipio = municipio.idt_municipio AND
  imovel.flg_ativo = TRUE AND 
  imovel.num_area_imovel > 100 AND
  imovel.num_area_imovel <= 500

GROUP BY
  municipio.cod_estado, 
  municipio.nom_municipio
ORDER BY
  municipio.cod_estado ASC, 
  municipio.nom_municipio ASC;



--Area ha >500 <=1000
create table imovel_resumo_500a1000ha as

SELECT 
  municipio.cod_estado,
  municipio.nom_municipio, 
  count(imovel.idt_imovel), 
  sum(imovel.num_area_imovel)

FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.municipio

WHERE 
  imovel.idt_municipio = municipio.idt_municipio AND
  imovel.flg_ativo = TRUE AND 
  imovel.num_area_imovel > 500 AND
  imovel.num_area_imovel <= 1000 

GROUP BY
  municipio.cod_estado, 
  municipio.nom_municipio
ORDER BY
  municipio.cod_estado ASC, 
  municipio.nom_municipio ASC;


---Area ha >1000ha

create table imovel_resumo_maior1000ha as

SELECT 
  municipio.cod_estado,
  municipio.nom_municipio, 
  count(imovel.idt_imovel), 
  sum(imovel.num_area_imovel)

FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.municipio

WHERE 
  imovel.idt_municipio = municipio.idt_municipio AND
  imovel.flg_ativo = TRUE AND 
  imovel.num_area_imovel > 1000

GROUP BY
  municipio.cod_estado, 
  municipio.nom_municipio
ORDER BY
  municipio.cod_estado ASC, 
  municipio.nom_municipio ASC;



﻿---Menor que 4
create table imoveis_resumo_ate4MF as
SELECT 
  municipio.cod_estado,
  municipio.nom_municipio, 
  count(imovel.idt_imovel), 
  sum(imovel.num_area_imovel)

FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.municipio

WHERE 
  imovel.idt_municipio = municipio.idt_municipio AND
  imovel.flg_ativo = TRUE AND 
  imovel.num_modulo_fiscal <= 4

GROUP BY
  municipio.cod_estado, 
  municipio.nom_municipio
ORDER BY
  municipio.cod_estado ASC, 
  municipio.nom_municipio ASC;


---4 a 15
create table imoveis_resumo_4a15MF as

SELECT 
  municipio.cod_estado,
  municipio.nom_municipio, 
  count(imovel.idt_imovel), 
  sum(imovel.num_area_imovel)

FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.municipio

WHERE 
  imovel.idt_municipio = municipio.idt_municipio AND
  imovel.flg_ativo = TRUE AND 
  imovel.num_modulo_fiscal > 4 AND
  imovel.num_modulo_fiscal <= 15

GROUP BY
  municipio.cod_estado, 
  municipio.nom_municipio
ORDER BY
  municipio.cod_estado ASC, 
  municipio.nom_municipio ASC;

---Maior que 15
create table imoveis_resumo_maior15MF as

SELECT 
  municipio.cod_estado,
  municipio.nom_municipio, 
  count(imovel.idt_imovel), 
  sum(imovel.num_area_imovel)

FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.municipio

WHERE 
  imovel.idt_municipio = municipio.idt_municipio AND
  imovel.flg_ativo = TRUE AND 
  imovel.num_modulo_fiscal > 15 

GROUP BY
  municipio.cod_estado, 
  municipio.nom_municipio
ORDER BY
  municipio.cod_estado ASC, 
  municipio.nom_municipio ASC;

