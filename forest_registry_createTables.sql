---General structure for an ongoing model of national forest registry database

CREATE TABLE cnfp.cnfp.Atrib_Ano_CNFP (
                ano_Inc_CNFP SMALLINT NOT NULL,
                CONSTRAINT id_ano PRIMARY KEY (ano_Inc_CNFP)
);


CREATE TABLE cnfp.cnfp.Atrib_Ass_Tipo (
                tipoAss VARCHAR(20) NOT NULL,
                restricao VARCHAR(15) NOT NULL,
                CONSTRAINT tipoass PRIMARY KEY (tipoAss)
);
COMMENT ON TABLE cnfp.cnfp.Atrib_Ass_Tipo IS 'Categorias de UC';


CREATE SEQUENCE cnfp.cnfp.atrib_datas_id_data_seq;

CREATE TABLE cnfp.cnfp.Atrib_Datas (
                ID_data INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.atrib_datas_id_data_seq'),
                data_Criacao DATE NOT NULL,
                CONSTRAINT data_criacao PRIMARY KEY (ID_data, data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Atrib_Datas IS 'Datas de criação das áreas originais';


ALTER SEQUENCE cnfp.cnfp.atrib_datas_id_data_seq OWNED BY cnfp.cnfp.Atrib_Datas.ID_data;

CREATE SEQUENCE cnfp.cnfp.atrib_documento_id_documento_seq;

CREATE TABLE cnfp.cnfp.Atrib_Documento (
                ID_documento INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.atrib_documento_id_documento_seq'),
                documento VARCHAR(20) NOT NULL,
                tipo_documento VARCHAR(15) NOT NULL,
                fonte_documento VARCHAR(15) NOT NULL,
                Data_documento DATE NOT NULL,
                CONSTRAINT documento PRIMARY KEY (ID_documento, documento)
);


ALTER SEQUENCE cnfp.cnfp.atrib_documento_id_documento_seq OWNED BY cnfp.cnfp.Atrib_Documento.ID_documento;

CREATE TABLE cnfp.cnfp.Atrib_UC_Categoria (
                tipo_uc VARCHAR(20) NOT NULL,
                protecao VARCHAR(15) NOT NULL,
                SNUC VARCHAR(15) NOT NULL,
                CONSTRAINT tipo_uc PRIMARY KEY (tipo_uc)
);
COMMENT ON TABLE cnfp.cnfp.Atrib_UC_Categoria IS 'Categorias de UC';


CREATE SEQUENCE cnfp.cnfp.orig_estass_id_asse_seq;

CREATE TABLE cnfp.cnfp.Orig_EstAss (
                ID_asse INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_estass_id_asse_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                tipoAss VARCHAR(20) NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_asse VARCHAR(40),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_asse PRIMARY KEY (ID_asse, ano_Inc_CNFP, tipoAss, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_EstAss IS 'Dados Originais Assentamentos Estaduais';


ALTER SEQUENCE cnfp.cnfp.orig_estass_id_asse_seq OWNED BY cnfp.cnfp.Orig_EstAss.ID_asse;

CREATE SEQUENCE cnfp.cnfp.orig_estautarq_id_aute_seq;

CREATE TABLE cnfp.cnfp.Orig_EstAutarq (
                ID_aute INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_estautarq_id_aute_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_aute VARCHAR(40),
                tipo VARCHAR(20),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_aute PRIMARY KEY (ID_aute, ano_Inc_CNFP, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_EstAutarq IS 'Dados Originais Autarquias Estaduais';


ALTER SEQUENCE cnfp.cnfp.orig_estautarq_id_aute_seq OWNED BY cnfp.cnfp.Orig_EstAutarq.ID_aute;

CREATE SEQUENCE cnfp.cnfp.orig_estgleba_id_glee_seq;

CREATE TABLE cnfp.cnfp.Orig_EstGleba (
                ID_glee INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_estgleba_id_glee_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_glee VARCHAR(40),
                tipo VARCHAR(20),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_glee PRIMARY KEY (ID_glee, ano_Inc_CNFP, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_EstGleba IS 'Dados Originais Glebas Estaduais';


ALTER SEQUENCE cnfp.cnfp.orig_estgleba_id_glee_seq OWNED BY cnfp.cnfp.Orig_EstGleba.ID_glee;

CREATE SEQUENCE cnfp.cnfp.orig_estmun_id_mune_seq;

CREATE TABLE cnfp.cnfp.Orig_EstMun (
                ID_mune INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_estmun_id_mune_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_mune VARCHAR(40),
                tipo VARCHAR(20),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_mune PRIMARY KEY (ID_mune, ano_Inc_CNFP, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_EstMun IS 'Dados Originais Municipios fontes Estaduais';


ALTER SEQUENCE cnfp.cnfp.orig_estmun_id_mune_seq OWNED BY cnfp.cnfp.Orig_EstMun.ID_mune;

CREATE SEQUENCE cnfp.cnfp.orig_estprivado_id_prie_seq;

CREATE TABLE cnfp.cnfp.Orig_EstPrivado (
                ID_prie INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_estprivado_id_prie_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_prie VARCHAR(40),
                tipo VARCHAR(20),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_prie PRIMARY KEY (ID_prie, ano_Inc_CNFP, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_EstPrivado IS 'Dados Originais Privados Estaduais';


ALTER SEQUENCE cnfp.cnfp.orig_estprivado_id_prie_seq OWNED BY cnfp.cnfp.Orig_EstPrivado.ID_prie;

CREATE SEQUENCE cnfp.cnfp.orig_estuc_id_uce_seq;

CREATE TABLE cnfp.cnfp.Orig_EstUC (
                ID_uce INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_estuc_id_uce_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                tipo_uc VARCHAR(20) NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_uce VARCHAR(40),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_uce PRIMARY KEY (ID_uce, ano_Inc_CNFP, tipo_uc, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_EstUC IS 'Dados Originais Unidades de Conservação Estaduais';


ALTER SEQUENCE cnfp.cnfp.orig_estuc_id_uce_seq OWNED BY cnfp.cnfp.Orig_EstUC.ID_uce;

CREATE SEQUENCE cnfp.cnfp.orig_fedass_id_ass_seq;

CREATE TABLE cnfp.cnfp.Orig_FedAss (
                ID_ass INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_fedass_id_ass_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                tipoAss VARCHAR(20) NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_ass VARCHAR(40),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_ass PRIMARY KEY (ID_ass, ano_Inc_CNFP, tipoAss, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_FedAss IS 'Dados Originais Assentamentos Federais';


ALTER SEQUENCE cnfp.cnfp.orig_fedass_id_ass_seq OWNED BY cnfp.cnfp.Orig_FedAss.ID_ass;

CREATE SEQUENCE cnfp.cnfp.orig_fedautarq_id_aut_seq;

CREATE TABLE cnfp.cnfp.Orig_FedAutarq (
                ID_aut INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_fedautarq_id_aut_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_aut VARCHAR(40),
                tipo VARCHAR(20),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_aut PRIMARY KEY (ID_aut, ano_Inc_CNFP, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_FedAutarq IS 'Dados Originais Autarquias Federais';


ALTER SEQUENCE cnfp.cnfp.orig_fedautarq_id_aut_seq OWNED BY cnfp.cnfp.Orig_FedAutarq.ID_aut;

CREATE SEQUENCE cnfp.cnfp.orig_fedgleba_id_gle_seq;

CREATE TABLE cnfp.cnfp.Orig_FedGleba (
                ID_gle INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_fedgleba_id_gle_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_gle VARCHAR(40),
                tipo VARCHAR(20),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_gle PRIMARY KEY (ID_gle, ano_Inc_CNFP, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_FedGleba IS 'Dados Originais Glebas Federais';


ALTER SEQUENCE cnfp.cnfp.orig_fedgleba_id_gle_seq OWNED BY cnfp.cnfp.Orig_FedGleba.ID_gle;

CREATE SEQUENCE cnfp.cnfp.orig_fedmilit_id_mil_seq;

CREATE TABLE cnfp.cnfp.Orig_FedMilit (
                ID_mil INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_fedmilit_id_mil_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_mil VARCHAR(40),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_mil PRIMARY KEY (ID_mil, ano_Inc_CNFP, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_FedMilit IS 'Dados Originais Militares';


ALTER SEQUENCE cnfp.cnfp.orig_fedmilit_id_mil_seq OWNED BY cnfp.cnfp.Orig_FedMilit.ID_mil;

CREATE SEQUENCE cnfp.cnfp.orig_fedprivado_id_pri_seq;

CREATE TABLE cnfp.cnfp.Orig_FedPrivado (
                ID_pri INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_fedprivado_id_pri_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_pri VARCHAR(40),
                tipo VARCHAR(20),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_pri PRIMARY KEY (ID_pri, ano_Inc_CNFP, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_FedPrivado IS 'Dados Originais Privados Federais';


ALTER SEQUENCE cnfp.cnfp.orig_fedprivado_id_pri_seq OWNED BY cnfp.cnfp.Orig_FedPrivado.ID_pri;

CREATE SEQUENCE cnfp.cnfp.orig_fedquilomb_id_quil_seq;

CREATE TABLE cnfp.cnfp.Orig_FedQuilomb (
                ID_quil INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_fedquilomb_id_quil_seq'),
                ano_Inc_CNFP SMALLINT NOT NULL,
                ID_documento INTEGER NOT NULL,
                documento VARCHAR(20) NOT NULL,
                ID_data INTEGER NOT NULL,
                Data_Criacao DATE NOT NULL,
                nome_quil VARCHAR(40),
                tipo VARCHAR(20),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                CONSTRAINT id_quil PRIMARY KEY (ID_quil, ano_Inc_CNFP, ID_documento, documento, ID_data, Data_Criacao)
);
COMMENT ON TABLE cnfp.cnfp.Orig_FedQuilomb IS 'Dados Originais Quilombolas';


ALTER SEQUENCE cnfp.cnfp.orig_fedquilomb_id_quil_seq OWNED BY cnfp.cnfp.Orig_FedQuilomb.ID_quil;

CREATE SEQUENCE cnfp.cnfp.orig_fedti_id_ti_seq;

CREATE TABLE cnfp.cnfp.orig_fedti (
                id_ti INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_fedti_id_ti_seq'),
                ano_inc_cnfp SMALLINT NOT NULL,
                documento VARCHAR(20) NOT NULL,
                data_atual DATE NOT NULL,
                nome_ti VARCHAR(80),
                municipio VARCHAR(40),
                uf VARCHAR(2),
                situacao VARCHAR(20),
                fase VARCHAR(20),
                shape geometry NOT NULL,
                CONSTRAINT id_ti PRIMARY KEY (id_ti, ano_inc_cnfp, documento, data_atual)
);
COMMENT ON TABLE cnfp.cnfp.orig_fedti IS 'Dados Originais Terras Indigenas';


	ALTER SEQUENCE cnfp.cnfp.orig_fedti_id_ti_seq OWNED BY cnfp.cnfp.orig_fedti.id_ti;

CREATE SEQUENCE cnfp.cnfp.orig_feduc_id_uc_seq;

CREATE TABLE cnfp.cnfp.orig_feduc (
                id_uc INTEGER NOT NULL DEFAULT nextval('cnfp.cnfp.orig_feduc_id_uc_seq'),
                ano_inc_cnfp SMALLINT NOT NULL,
                tipo_uc VARCHAR(20) NOT NULL,
                documento VARCHAR(20) NOT NULL,
                data_atual DATE NOT NULL,
                nome_uce VARCHAR(40),
                area_calc NUMERIC(38,8),
                shape geometry NOT NULL,
                situacao_cnfp VARCHAR NOT NULL,
                anocriacao_icmbio SMALLINT NOT NULL,
                bioma VARCHAR(30) NOT NULL,
                CONSTRAINT id_uc PRIMARY KEY (id_uc, ano_inc_cnfp, tipo_uc, documento, data_atual)
);
COMMENT ON TABLE cnfp.cnfp.orig_feduc IS 'Dados Originais Unidades de Conservação Federais';


ALTER SEQUENCE cnfp.cnfp.orig_feduc_id_uc_seq OWNED BY cnfp.cnfp.orig_feduc.id_uc;

ALTER TABLE cnfp.cnfp.Orig_EstAss ADD CONSTRAINT ano_cnfp_orig_estass_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstAutarq ADD CONSTRAINT ano_cnfp_orig_estautarq_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstGleba ADD CONSTRAINT ano_cnfp_orig_estgleba_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstMun ADD CONSTRAINT ano_cnfp_orig_estmun_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstPrivado ADD CONSTRAINT ano_cnfp_orig_estprivado_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstUC ADD CONSTRAINT ano_cnfp_orig_estuc_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedAss ADD CONSTRAINT ano_cnfp_orig_fedass_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedAutarq ADD CONSTRAINT ano_cnfp_orig_fedautarq_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedGleba ADD CONSTRAINT ano_cnfp_orig_fedgleba_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedMilit ADD CONSTRAINT ano_cnfp_orig_fedmilit_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedPrivado ADD CONSTRAINT ano_cnfp_orig_fedprivado_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedQuilomb ADD CONSTRAINT atrib_ano_cnfp_orig_fedquilomb_fk
FOREIGN KEY (ano_Inc_CNFP)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.orig_fedti ADD CONSTRAINT ano_cnfp_orig_fedti_fk
FOREIGN KEY (ano_inc_cnfp)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.orig_feduc ADD CONSTRAINT ano_cnfp_orig_feduc_fk
FOREIGN KEY (ano_inc_cnfp)
REFERENCES cnfp.cnfp.Atrib_Ano_CNFP (ano_Inc_CNFP)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstAss ADD CONSTRAINT atrib_ass_tipo_orig_estass_fk
FOREIGN KEY (tipoAss)
REFERENCES cnfp.cnfp.Atrib_Ass_Tipo (tipoAss)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedAss ADD CONSTRAINT atrib_ass_tipo_orig_fedass_fk
FOREIGN KEY (tipoAss)
REFERENCES cnfp.cnfp.Atrib_Ass_Tipo (tipoAss)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstAss ADD CONSTRAINT data_criacao_orig_estass_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstAutarq ADD CONSTRAINT data_criacao_orig_estautarq_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstGleba ADD CONSTRAINT data_criacao_orig_estgleba_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstMun ADD CONSTRAINT data_criacao_orig_estmun_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstPrivado ADD CONSTRAINT data_criacao_orig_estprivado_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstUC ADD CONSTRAINT data_criacao_orig_estuc_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedAss ADD CONSTRAINT data_criacao_orig_fedass_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedAutarq ADD CONSTRAINT data_criacao_orig_fedautarq_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedGleba ADD CONSTRAINT data_criacao_orig_fedgleba_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedMilit ADD CONSTRAINT data_criacao_orig_fedmilit_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedPrivado ADD CONSTRAINT data_criacao_orig_fedprivado_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedQuilomb ADD CONSTRAINT data_criacao_orig_fedquilomb_fk
FOREIGN KEY (ID_data, Data_Criacao)
REFERENCES cnfp.cnfp.Atrib_Datas (ID_data, data_Criacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstAss ADD CONSTRAINT atrib_documento_orig_estass_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstAutarq ADD CONSTRAINT atrib_documento_orig_estautarq_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstGleba ADD CONSTRAINT atrib_documento_orig_estgleba_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstMun ADD CONSTRAINT atrib_documento_orig_estmun_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstPrivado ADD CONSTRAINT atrib_documento_orig_estprivado_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstUC ADD CONSTRAINT atrib_documento_orig_estuc_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedAss ADD CONSTRAINT atrib_documento_orig_fedass_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedAutarq ADD CONSTRAINT atrib_documento_orig_fedautarq_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedGleba ADD CONSTRAINT atrib_documento_orig_fedgleba_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedMilit ADD CONSTRAINT atrib_documento_orig_fedmilit_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedPrivado ADD CONSTRAINT atrib_documento_orig_fedprivado_fk
FOREIGN KEY (documento, ID_documento)
REFERENCES cnfp.cnfp.Atrib_Documento (documento, ID_documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_FedQuilomb ADD CONSTRAINT atrib_documento_orig_fedquilomb_fk
FOREIGN KEY (ID_documento, documento)
REFERENCES cnfp.cnfp.Atrib_Documento (ID_documento, documento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.Orig_EstUC ADD CONSTRAINT atrib_uc_categoria_orig_estuc_fk
FOREIGN KEY (tipo_uc)
REFERENCES cnfp.cnfp.Atrib_UC_Categoria (tipo_uc)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cnfp.cnfp.orig_feduc ADD CONSTRAINT atrib_uc_categoria_orig_feduc_fk
FOREIGN KEY (tipo_uc)
REFERENCES cnfp.cnfp.Atrib_UC_Categoria (tipo_uc)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;






COMMENT ON TABLE cnfp.cnfp.atrib_datas IS 'Datas de criaÃ§Ã£o das Ã¡reas originais';
COMMENT ON TABLE cnfp.cnfp.orig_estuc IS 'Dados Originais Unidades de ConservaÃ§Ã£o Estaduais';



ALTER SEQUENCE cnfp.cnfp.orig_fedquilomb_id_quil_seq OWNED BY cnfp.cnfp.Orig_FedQuilomb.ID_quil;

ALTER TABLE ONLY cnfp.cnfp.orig_feduc ALTER COLUMN situacao_cnfp TYPE VARCHAR, ALTER COLUMN situacao_cnfp SET NOT NULL;
