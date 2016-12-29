--Spreadsheet codes...
--=if(C2=0;0;if(C2<=2;2;if(C2<=4;4;if(C2<=5;5;if(C2<=10;10;if(C2<=15;15;if(C2<=20;20;if(C2<=50;50;if(C2<=80;80;if(C2<=90;90;if(C2<=99;99;100)))))))))))
--=if(D2=0;0;if(D2<=5;5;if(D2<=10;10;if(D2<=20;20;if(D2<=30;30;if(D2<=40;40;if(D2<=50;50;if(D2<=70;70;if(D2<=80;80;if(D2<=90;90;if(D2<=99;99;100)))))))))))


--Sobreposicoes

create table sfb_result.filtro_mt as
SELECT 
  qua.idt_imovel, 
  qua.ind_tipo_origem, 
  qua.ind_status_imovel, 
  qua.ind_tipo_imovel, 
  qua.num_area_imovel, 
  qua.num_area_reserva_legal_excedente_passivo, 
  qua.num_area_sobreposicao_ir, 
  qua.num_area_app_recompor, 
  qua.num_area_uc, 
  qua.num_area_ti, 
  qua.num_area_assentamento,
  round((qua.num_area_reserva_legal_excedente_passivo/qua.num_area_imovel)::numeric,4) as prop_rl_exc_pass,
  round((qua.num_area_sobreposicao_ir/qua.num_area_imovel)::numeric,4) as prop_sobreposicao,
  round((qua.num_area_app_recompor/qua.num_area_imovel)::numeric,4) as prop_rl_app_recompor,
  round((qua.num_area_uc/qua.num_area_imovel)::numeric,4) as prop_uc,
  round((qua.num_area_ti/qua.num_area_imovel)::numeric,4) as prop_ti,
  round((qua.num_area_assentamento/qua.num_area_imovel)::numeric,4) as prop_assentamento
  
FROM 
  sfb_dados.quadro_mt qua;

--sobreposicoes_1pp

create table sfb_result.filtro_mt_1pp_r2 as
SELECT 
  qua.idt_imovel, 
  qua.ind_tipo_origem, 
  qua.ind_status_imovel, 
  qua.ind_tipo_imovel, 
  qua.num_area_imovel, 
  qua.num_area_reserva_legal_excedente_passivo, 
  qua.num_area_sobreposicao_ir, 
  qua.num_area_app_recompor, 
  qua.num_area_uc, 
  qua.num_area_ti, 
  qua.num_area_assentamento,
  num_area_embargada,
  round((qua.num_area_reserva_legal_excedente_passivo/qua.num_area_imovel)::numeric,2)*100 as prop_rl_exc_pass,
  round((qua.num_area_sobreposicao_ir/qua.num_area_imovel)::numeric,2)*100 as prop_sobreposicao,
  round((qua.num_area_uc/qua.num_area_imovel)::numeric,2)*100 as prop_uc,
  round((qua.num_area_ti/qua.num_area_imovel)::numeric,2)*100 as prop_ti,
  round((qua.num_area_assentamento/qua.num_area_imovel)::numeric,2)*100 as prop_assentamento
  round((qua.num_area_embargada/qua.num_area_imovel)::numeric,2)*100 as prop_embargo
  
FROM 
  sfb_dados.quadro_mt qua;

ALTER TABLE sfb_result.filtro_mt_1pp_r2
  ADD CONSTRAINT idt_imovel_pk PRIMARY KEY(idt_imovel);
CREATE INDEX idt_imovel_idx ON sfb_result.filtro_mt_1pp_r2 USING BTREE (idt_imovel);


--areas

create table sfb_result.areas_doc_geom
SELECT 
  imovel.idt_imovel, 
  imovel.num_area_imovel, 
  sum(documento_imovel.num_area)
FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.documento_imovel,
  usr_geocar_aplicacao.municipio
WHERE 
   municipio.cod_estado = 'MT' and
   imovel.idt_municipio = municipio.idt_municipio and
  imovel.ind_status_imovel in ('AT','PE') and
  imovel.idt_imovel = documento_imovel.idt_imovel
group by
imovel.idt_imovel;



--remover colunas

DO
$do$
DECLARE
    _column TEXT;
BEGIN
FOR _column  IN
    SELECT quote_ident(column_name)
    FROM   information_schema.columns
    WHERE  table_name = 'geom_mt'
    AND    column_name LIKE 'num_area%'
    AND    table_schema NOT LIKE 'pg_%'
LOOP
  --  RAISE NOTICE '%',
   EXECUTE
  'ALTER TABLE sfb_dados.geom_mt DROP COLUMN ' || _column;
END LOOP;
END
$do$




--documento

create table sfb_result.areas_doc_geom as
SELECT 
  imovel.idt_imovel, 
  imovel.num_area_imovel, 
  sum(documento_imovel.num_area)
FROM 
  usr_geocar_aplicacao.imovel, 
  usr_geocar_aplicacao.documento_imovel,
  usr_geocar_aplicacao.municipio
WHERE 
   municipio.cod_estado = 'MT' and
   imovel.idt_municipio = municipio.idt_municipio and
  imovel.ind_status_imovel in ('AT','PE') and
  imovel.idt_imovel = documento_imovel.idt_imovel
group by
imovel.idt_imovel;



--chave primaria
ALTER TABLE sfb_dados.quadro_mt
  ADD CONSTRAINT idt_imovel_pk PRIMARY KEY(idt_imovel)
SELECT Populate_Geometry_Columns('sfb_dados.quadro_mt'::regclass);



CREATE INDEX quadro_mt_gix ON sfb_dados.quadro_mt USING GIST (geo_area_imovel);

SELECT Populate_Geometry_Columns();




--Criar tabela do estado
create table sfb_dados.quadro_mt as
SELECT 
 imovel.idt_imovel, 
  imovel.ind_tipo_origem, 
  imovel.ind_status_imovel, 
  imovel.ind_tipo_imovel, 
  imovel.idt_municipio, 
  imovel.num_area_imovel, 
  imovel.num_modulo_fiscal, 
  imovel.geo_area_imovel, 
  imovel.flg_ativo, 
  imovel.flg_migracao, 
  imovel.des_condicao, 
  imovel.retificavel, 
  quadro_area.num_area_liquida_imovel, 
  quadro_area.num_area_reserva_legal_proposta, 
  quadro_area.num_area_reserva_legal_averbada, 
  quadro_area.num_area_reserva_legal_aprovada_nao_averbada, 
  quadro_area.num_area_reserva_legal_minima_lei, 
  quadro_area.num_area_reserva_legal_excedente_passivo, 
  quadro_area.num_area_app_area_consolidada, 
  quadro_area.num_area_app_area_antropizada, 
  quadro_area.num_area_app_recompor, 
  quadro_area.num_area_app_vegetacao_nativa, 
  quadro_area.num_area_reserva_legal_recompor_area_consolidada, 
  quadro_area.num_area_reserva_legal_recompor_area_antropizada, 
  quadro_area.num_area_reserva_legal_app, 
  quadro_area.num_area_reserva_legal_vegetacao_nativa, 
  quadro_area.num_area_uso_restrito_area_consolidada, 
  quadro_area.num_area_uso_restrito_area_antropizada, 
  quadro_area.num_area_uso_restrito_vegetacao_nativa, 
  quadro_area.num_area_vegetacao_nativa, 
  quadro_area.num_area_consolidada, 
  quadro_area.num_area_antropizada, 
  quadro_area.num_area_pousio, 
  quadro_area.num_area_sobreposicao_ir, 
  quadro_area.num_area_uc, 
  quadro_area.num_area_ti, 
  quadro_area.num_area_assentamento, 
  quadro_area.num_area_servidao_administrativa, 
  quadro_area.num_area_rl_compensada_terceiro_ir, 
  quadro_area.num_area_rl_compensada_ir_terceiro, 
  quadro_area.num_area_reserva_legal_recompor, 
  quadro_area.num_area_uso_restrito_recompor, 
  quadro_area.num_area_preservacao_permanente, 
  quadro_area.num_area_uso_restrito, 
  quadro_area.num_area_hidrografia, 
  quadro_area.num_area_reserva_legal, 
  quadro_area.num_area_reserva_legal_declarada, 
  quadro_area.num_area_app_banhado, 
  quadro_area.num_area_app_lago_lagoa_natural, 
  quadro_area.num_area_app_nascente, 
  quadro_area.num_area_app_reservatorio, 
  quadro_area.num_area_app_rio_ate_10, 
  quadro_area.num_area_app_rio_10_a_50,
  num_area_app_escadinha_rio_50_a_200 , -- Área de Preservação Permanente a Recompor de Rios de 50 até 200 metros.
  num_area_app_escadinha_rio_200_a_600 , -- Área de Preservação Permanente a Recompor de Rios de 200 até 600 metros.
  num_area_app_escadinha_rio_acima_600 , -- Área de Preservação Permanente a Recompor de Rios com mais de 600 metros.
  num_area_app_escadinha_vereda , -- Área de Preservação Permanente a Recompor de Veredas.
  num_area_app_manguezal , -- Área de Preservação Permanente de Manguezais.
  num_area_app_restinga , -- Área de Preservação Permanente de Restingas.
  num_area_declarada , -- Total de área declarada.
  num_area_embargada , -- Area de Sobreposição do Imóvel com Área Embargada.
  num_area_uso_restrito_declividade , -- Total de Área de Uso Restrito para declividade de 25 a 45 graus
  num_area_uso_restrito_pantaneira , -- Total de Área de Uso Restrito para regiões pantaneiras
  num_area_ur_recompor_declividade , -- Total de Área de Uso Restrito a recompor para declividade de 25 a 45 graus
  num_area_ur_recompor_pantaneira , -- Total de Área de Uso Restrito a recompor para regiões pantaneiras
  num_area_sa_entorno_reservatorio , -- Total de Área de Servidão Administrativa de Entorno de Reservatório para Abastecimento ou Geração de Energia
  num_area_sa_reservatorio , -- Total de Área de UServidão Administrativa de Reservatório para Abastecimento ou Geração de Energia
  num_area_sa_infraestrutura_publica , -- Total de Área de Servidão Administrativa de Infraestrutura Pública
  num_area_sa_utilidade_publica,
  municipio.num_hectares_modulo_fiscal, 
  municipio.num_area as area_municipio, 
  municipio.cod_estado
FROM 
  usr_geocar_aplicacao.imovel, 
  relatorio.quadro_area, 
  usr_geocar_aplicacao.municipio
WHERE 
  municipio.cod_estado = 'MT' AND
  quadro_area.idt_imovel = imovel.idt_imovel AND
  municipio.idt_municipio = imovel.idt_municipio;
