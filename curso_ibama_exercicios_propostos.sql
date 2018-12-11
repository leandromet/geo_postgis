--Proposta exercício

--Area desmatada em imovel rural - Filtrar imóveis maiores que 15 módulos fiscais, tipo IRU, no MT, com desmatamento em 2017 ou 2018 gerado pelos alertas do ibama e posteriormente identificar aqueles mais importantes em relação à area do imóvel.

total de imóveis no MT (PCT, IRU, AST)
select count (*) from car.car_imoveis_ativos_mt_a 
Apenas IRU (todos os tamanhos)
select count (*) from car.car_imoveis_ativos_mt_a 
where ind_tipo_imovel = 'IRU'
IRU com mais de 15 módulos fiscais (grandes)
select count (*) from car.car_imoveis_ativos_mt_a
where ind_tipo_imovel = 'IRU' and num_modulo_fiscal > 15
total de alertas do ibama (histórico)
select count (*) from  ibama.alerta
total de alertas por ano
select ano, count(*)from  ibama.alerta
group by ano order by ano

--total de alertas nos imóveis rurais IRU com mais de 15 MF após 2016

select count (*) from car.car_imoveis_ativos_mt_a 
inner join ibama.alerta on 
st_intersects(car_imoveis_ativos_mt_a.geom, alerta.geom)
where ano > 2016 and estado = 'MT' and
ind_tipo_imovel = 'IRU' and
num_modulo_fiscal > 15 and ST_IsValid(car_imoveis_ativos_mt_a.geom) and ST_IsValid(alerta.geom)

--gerar sobreposicao com area calculada


--tabela com desmatamentos, depois foi calculada a área da intersecção e seu percentual em relação à area original do imóvel
create table temp.curso_iru15mt_desmat as select 
idt_imovel,
cod_imovel,
cod_cpf_cnpj,
nom_municipio,
num_area_imovel,
num_modulo_fiscal,
mes,
ano,
tipo as tipo_alerta,
st_intersection(car_imoveis_ativos_mt_a.geom, alerta.geom) as geom 
from car.car_imoveis_ativos_mt_a 
inner join ibama.alerta on 
st_intersects(car_imoveis_ativos_mt_a.geom, alerta.geom)
where ano > 2016 and estado = 'MT' and
ind_tipo_imovel = 'IRU' and
num_modulo_fiscal > 15 and ST_IsValid(car_imoveis_ativos_mt_a.geom) and ST_IsValid(alerta.geom)

--tabela com os imóveis que foram utilizados para fazer as figuras.
create table temp.curso_iru15mt_imovel as select 
idt_imovel,
cod_imovel,
cod_cpf_cnpj,
nom_municipio,
num_area_imovel,
num_modulo_fiscal,
mes,
ano,
tipo as tipo_alerta,
car_imoveis_ativos_mt_a.geom
from car.car_imoveis_ativos_mt_a 
inner join ibama.alerta on 
st_intersects(car_imoveis_ativos_mt_a.geom, alerta.geom)
where ano > 2016 and estado = 'MT' and
ind_tipo_imovel = 'IRU' and
num_modulo_fiscal > 15 and ST_IsValid(car_imoveis_ativos_mt_a.geom) and ST_IsValid(alerta.geom)











--Dados do CAR, embargos e alertas trabalhando juntos à partir de geometrias externas

--contagem de embargos nos imoveis

select idt_imovel, count(objectid) as embargos
from temp.curso2018_acre_imoveis, ibama.adm_embargo_a
where st_intersects (curso2018_acre_imoveis.geom, adm_embargo_a.geom)
group by idt_imovel
order by embargos desc;

--consulta com tipo usando dados do acre

select car_imoveis_ativos_ac_a.cod_imovel ,  ind_tipo_imovel, count(objectid) as embargos
from temp.curso2018_acre_imoveis, ibama.adm_embargo_a, car.car_imoveis_ativos_ac_a
where st_intersects (curso2018_acre_imoveis.geom, adm_embargo_a.geom) and
 curso2018_acre_imoveis.cod_imovel = car_imoveis_ativos_ac_a.cod_imovel
group by car_imoveis_ativos_ac_a.cod_imovel, ind_status_imovel, ind_tipo_imovel
order by embargos desc;

--Aqueles com mais de 9 embargos e que pelo menos um deles está em reserva legal declarada

select emb.*, idt_rel_te

from
(select car_imoveis_ativos_ac_a.cod_imovel ,  ind_tipo_imovel, count(objectid) as embargos
from temp.curso2018_acre_imoveis, ibama.adm_embargo_a, car.car_imoveis_ativos_ac_a
where st_intersects (curso2018_acre_imoveis.geom, adm_embargo_a.geom) and curso2018_acre_imoveis.cod_imovel = car_imoveis_ativos_ac_a.cod_imovel
group by car_imoveis_ativos_ac_a.cod_imovel, ind_status_imovel, ind_tipo_imovel
order by embargos desc) as emb,

 temp.curso2018_acre_reserva_legal, temp.curso2018_acre_imoveis,  ibama.adm_embargo_a
where embargos > 9 and
 curso2018_acre_imoveis.cod_imovel = emb.cod_imovel and
 curso2018_acre_reserva_legal.idt_imovel=curso2018_acre_imoveis.idt_imovel  and
 st_intersects(curso2018_acre_reserva_legal.geom, adm_embargo_a.geom) 

;

--geometria inválida na reserva legal



select emb.*, idt_rel_te

from
(select car_imoveis_ativos_ac_a.cod_imovel ,  ind_tipo_imovel, count(objectid) as embargos
from temp.curso2018_acre_imoveis, ibama.adm_embargo_a, car.car_imoveis_ativos_ac_a
where st_intersects (curso2018_acre_imoveis.geom, adm_embargo_a.geom) and
 curso2018_acre_imoveis.cod_imovel = car_imoveis_ativos_ac_a.cod_imovel
group by car_imoveis_ativos_ac_a.cod_imovel, ind_status_imovel, ind_tipo_imovel
order by embargos desc) as emb,

 temp.curso2018_acre_reserva_legal, temp.curso2018_acre_imoveis,  ibama.adm_embargo_a
where embargos > 9 and curso2018_acre_imoveis.cod_imovel = emb.cod_imovel and
 curso2018_acre_reserva_legal.idt_imovel=curso2018_acre_imoveis.idt_imovel  and st_intersects(ST_makevalid(curso2018_acre_reserva_legal.geom), adm_embargo_a.geom) 

;

--quais estão dentro

select emb.cod_imovel, embargos, count(idt_rel_te) as dentro_rl

from
(select car_imoveis_ativos_ac_a.cod_imovel ,  ind_tipo_imovel, count(objectid) as embargos
from temp.curso2018_acre_imoveis, ibama.adm_embargo_a, car.car_imoveis_ativos_ac_a
where st_intersects (curso2018_acre_imoveis.geom, adm_embargo_a.geom) and
 curso2018_acre_imoveis.cod_imovel = car_imoveis_ativos_ac_a.cod_imovel
group by car_imoveis_ativos_ac_a.cod_imovel, ind_status_imovel, ind_tipo_imovel
order by embargos desc) as emb,

 temp.curso2018_acre_reserva_legal, temp.curso2018_acre_imoveis,  ibama.adm_embargo_a
where embargos in (11,12,14) and
curso2018_acre_imoveis.cod_imovel = emb.cod_imovel and
curso2018_acre_reserva_legal.idt_imovel=curso2018_acre_imoveis.idt_imovel and
st_intersects(ST_makevalid(curso2018_acre_reserva_legal.geom), adm_embargo_a.geom) 
group by emb.cod_imovel, embargos
;




---mais de 10 embargos na RL apenas IRU ... repetidos

create table temp.curso_rl_embargo_iru_10 as
select emb.cod_imovel, embargos, idt_rel_te, curso2018_acre_reserva_legal.geom
from
(select car_imoveis_ativos_ac_a.cod_imovel ,  ind_tipo_imovel, count(objectid) as embargos
from temp.curso2018_acre_imoveis, ibama.adm_embargo_a, car.car_imoveis_ativos_ac_a
where st_intersects (curso2018_acre_imoveis.geom, adm_embargo_a.geom) and
 curso2018_acre_imoveis.cod_imovel = car_imoveis_ativos_ac_a.cod_imovel
group by car_imoveis_ativos_ac_a.cod_imovel, ind_status_imovel, ind_tipo_imovel
order by embargos desc) as emb,

 temp.curso2018_acre_reserva_legal, temp.curso2018_acre_imoveis,  ibama.adm_embargo_a
where embargos>10 and
 ind_tipo_imovel = 'IRU' and
curso2018_acre_imoveis.cod_imovel = emb.cod_imovel and
curso2018_acre_reserva_legal.idt_imovel=curso2018_acre_imoveis.idt_imovel and
st_intersects(ST_makevalid(curso2018_acre_reserva_legal.geom), adm_embargo_a.geom) 

;


--mais de 5 embargos na RL, IRU distinto

create table temp.curso_rl_embargo_iru_5_distinct as
select distinct emb.cod_imovel, embargos, idt_rel_te, curso2018_acre_reserva_legal.geom
from
(select car_imoveis_ativos_ac_a.cod_imovel ,  ind_tipo_imovel, count(objectid) as embargos
from temp.curso2018_acre_imoveis, ibama.adm_embargo_a, car.car_imoveis_ativos_ac_a
where st_intersects (curso2018_acre_imoveis.geom, adm_embargo_a.geom) and
 curso2018_acre_imoveis.cod_imovel = car_imoveis_ativos_ac_a.cod_imovel
group by car_imoveis_ativos_ac_a.cod_imovel, ind_status_imovel, ind_tipo_imovel
order by embargos desc) as emb, temp.curso2018_acre_reserva_legal, temp.curso2018_acre_imoveis,  ibama.adm_embargo_a
where embargos>5 and ind_tipo_imovel = 'IRU' and
curso2018_acre_imoveis.cod_imovel = emb.cod_imovel and
curso2018_acre_reserva_legal.idt_imovel=curso2018_acre_imoveis.idt_imovel and
st_intersects(ST_makevalid(curso2018_acre_reserva_legal.geom), adm_embargo_a.geom) 

;


--Alertas de desmatamento nas RL com mais de 5 embargos 

create table temp.curso_rl_embargo_alerta5 as
select alerta.objectid, rl.cod_imovel, ano, st_intersection(rl.geom, alerta.geom) from

(select emb.cod_imovel, embargos, idt_rel_te, curso2018_acre_reserva_legal.geom
from
(select car_imoveis_ativos_ac_a.cod_imovel ,  ind_tipo_imovel, count(objectid) as embargos
from temp.curso2018_acre_imoveis, ibama.adm_embargo_a, car.car_imoveis_ativos_ac_a
where st_intersects (curso2018_acre_imoveis.geom, adm_embargo_a.geom) and
 curso2018_acre_imoveis.cod_imovel = car_imoveis_ativos_ac_a.cod_imovel
group by car_imoveis_ativos_ac_a.cod_imovel, ind_status_imovel, ind_tipo_imovel
order by embargos desc) as emb, temp.curso2018_acre_reserva_legal, temp.curso2018_acre_imoveis,  ibama.adm_embargo_a
where embargos>10 and ind_tipo_imovel = 'IRU' and
curso2018_acre_imoveis.cod_imovel = emb.cod_imovel and
curso2018_acre_reserva_legal.idt_imovel=curso2018_acre_imoveis.idt_imovel and
st_intersects(ST_makevalid(curso2018_acre_reserva_legal.geom), adm_embargo_a.geom) ) as rl, ibama.alerta
where st_intersects(rl.geom, alerta.geom)

;

--Geometrias de Alertas de desmatamento nas RL com mais de 4 embargos 



create table temp.curso_rl_emb_alerta4 as
select alerta.objectid, rl.cod_imovel, ano, alerta.geom 

from
(select emb.cod_imovel, embargos, idt_rel_te, curso2018_acre_reserva_legal.geom

from
(select car_imoveis_ativos_ac_a.cod_imovel ,  ind_tipo_imovel, count(objectid) as embargos
from temp.curso2018_acre_imoveis, ibama.adm_embargo_a, car.car_imoveis_ativos_ac_a
where st_intersects (curso2018_acre_imoveis.geom, adm_embargo_a.geom) and
 curso2018_acre_imoveis.cod_imovel = car_imoveis_ativos_ac_a.cod_imovel
group by car_imoveis_ativos_ac_a.cod_imovel, ind_status_imovel, ind_tipo_imovel
order by embargos desc)
as emb,

 temp.curso2018_acre_reserva_legal, temp.curso2018_acre_imoveis,  ibama.adm_embargo_a
where embargos>4 and
 ind_tipo_imovel = 'IRU' and
curso2018_acre_imoveis.cod_imovel = emb.cod_imovel and
curso2018_acre_reserva_legal.idt_imovel=curso2018_acre_imoveis.idt_imovel and
st_intersects(ST_makevalid(curso2018_acre_reserva_legal.geom), adm_embargo_a.geom) 
) as rl,

ibama.alerta
where st_intersects(rl.geom, alerta.geom)

;


