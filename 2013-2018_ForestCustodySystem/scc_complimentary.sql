--- Information reagarding the structure and objects of the SCC spatial database


--acesso:

psql -h 172.16.32.23 geosfb scc

--funções:

SELECT * FROM scc.scc_val_upa(1);
SELECT * FROM scc.scc_val_arvore(1);
SELECT * FROM scc.scc_val_estradas(1);
SELECT * FROM scc.scc_val_parcelas(1);
SELECT * FROM scc.scc_val_patio_principal(1);
SELECT * FROM scc.scc_val_nascentes(1);
SELECT * FROM scc.scc_val_trilhas_arraste(1);
SELECT * FROM scc.scc_val_app(1);
SELECT * FROM scc.scc_val_espelho_dagua(1);
SELECT * FROM scc.scc_val_unidade_trabalho(1);
SELECT * FROM scc.scc_val_hidrografia(1);



--scc.scc_val_upa(0) => recebe "0" (ZERO) por padrão, devolve V se validado ou F se não validado, retorna total de indivíduos fora da umf, se não houver grava no banco, se existirem parte dos indivíduos em registros, devolve total de repetidos
--scc.scc_val_arvores(0) => recebe "0" (ZERO) por padrão, retorna total de indivíduos fora da umf, se não houver grava no banco, se existirem parte dos indivíduos em registros, devolve total de repetidos
--scc.scc_val_estradas(0) => recebe "0" (ZERO) por padrão, retorna total de indivíduos fora da umf, se não houver grava no banco, se existirem parte dos indivíduos em registros, devolve total de repetidos
--scc.scc_val_patios_estocagem(0) => recebe "0" (ZERO) por padrão, retorna total de indivíduos fora da umf, se não houver grava no banco, se existirem parte dos indivíduos em registros, devolve total de repetidos
--scc.scc_val_parcelas(0) => recebe "0" (ZERO) por padrão, retorna total de indivíduos fora da umf, se não houver grava no banco, se existirem parte dos indivíduos em registros, devolve total de repetidos

-- lista tabelas
SELECT table_name
  FROM information_schema.tables
 WHERE table_schema='sde'
   AND table_type='BASE TABLE';



--Cria tabelas temporárias



#!/bin/sh
export PGPASSWORD=""
/usr/bin/shp2pgsql -d -W LATIN1 -s 4674 -g shape $1 scc.temp_upa | /usr/bin/psql -h host -U dbscc -d geoscc
unset PGPASSWORD
exit 0


shp2pgsql -d -W LATIN1 -s 4674 -g shape umf.shp scc.umf | psql -h 172.16.32.23 -U scc -d geosfb


shp2pgsql -d -W LATIN1 -s 4674 -g shape limite_upa5.shp scc.temp_upa | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape arvore_upa5.shp scc.temp_arvores | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape parcelas_permanetes_upa5.shp scc.temp_parcelas | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape estradas_upa5.shp scc.temp_estradas | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape patios_planejados_upa5.shp scc.temp_patios | psql -h 172.16.32.23 -U scc -d geosfb

shp2pgsql -d -W LATIN1 -s 4674 -g shape app_upa5.shp scc.temp_app | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape espelho_dagua_upa5.shp scc.temp_espelho_dagua | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape hidrografia_upa5.shp scc.temp_hidrografia | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape nascente_upa5.shp scc.temp_nascentes | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape patio_principal.shp scc.temp_patio_principal | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape trilhas_arraste_upa5.shp scc.temp_trilhas_arraste | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape unidades_trabalho_upa5.shp scc.temp_unidade_trabalho | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape umf.shp scc.umf | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape Limite_UPA11.shp scc.temp_upa | psql -h pgsqldv01.florestal.gov.br -U dbscc -d geoscc

shp2pgsql -d -W LATIN1 -s 4674 -g shape arvore_upa5.shp scc.temp_arvores | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape parcelas_permanetes_upa5.shp scc.temp_parcelas | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape estradas_upa5.shp scc.temp_estradas | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape patios_planejados_upa5.shp scc.temp_patios | psql -h 172.16.32.23 -U scc -d geosfb

shp2pgsql -d -W LATIN1 -s 4674 -g shape app_upa5.shp scc.temp_app | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape espelho_dagua_upa5.shp scc.temp_espelho_dagua | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape hidrografia_upa5.shp scc.temp_hidrografia | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape nascente_upa5.shp scc.temp_nascentes | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape patio_principal.shp scc.temp_patio_principal | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape trilhas_arraste_upa5.shp scc.temp_trilhas_arraste | psql -h 172.16.32.23 -U scc -d geosfb
shp2pgsql -d -W LATIN1 -s 4674 -g shape unidades_trabalho_upa5.shp scc.temp_unidade_trabalho | psql -h 172.16.32.23 -U scc -d geosfb





 app_upa5.shp
 arvore_upa5.shp
 espelho_dagua_upa5.shp
 estradas_upa5.shp
 hidrografia_upa5.shp
 limite_upa5.shp
 nascente_upa5.shp
 parcelas_permanetes_upa5.shp
 patios_planejados_upa5.shp
 patio_principal.shp
 trilhas_arraste_upa5.shp
 unidades_trabalho_upa5.shp
