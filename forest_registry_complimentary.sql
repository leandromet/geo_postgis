--- Other relevant codes related to the national registry database

--criando categorias do SNUC

 INSERT INTO cnfp.atrib_uc_categoria(tipo_uc, protecao, snuc) (SELECT DISTINCT classifica, 'Integral', 1 FROM cnfp.adic_uc);

--atualiza campo classifica dos dados 2012

UPDATE cnfp.adic_uc2012 SET classifica = cnfp.atrib_uc_categoria.tipo_uc FROM cnfp.atrib_uc_categoria WHERE cnfp.adic_uc2012.sigla_cat=atrib_uc_categoria.sigla_cat;

--funções:
SELECT * FROM cnfp.f_adic_ti_mod();

 insert into cnfp.atrib_ano_cnfp(ano_inc_cnfp) VALUES($1);
 insert into cnfp.atrib_datas(id_data, data_criacao) VALUES(1,'2015-03-31');
 insert into cnfp.atrib_documento(id_documento, documento, tipo_documento, fonte_documento, data_documento) VALUES(1,'Decreto','Decreto','FUNAI','2015-03-31');



--Cria tabelas temporárias

shp2pgsql -d -W LATIN1 -s 4674 -g shape vw_geo_ti_sirgas2000.shp  cnfp.adic_ti | psql -h pgsqldv02.florestal.gov.br -U sde -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape UC_fed_fevereiro_2015_export.shp  cnfp.adic_uc | psql -h host -U user -d geosfb
