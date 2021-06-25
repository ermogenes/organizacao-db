CREATE DATABASE organizacao ;
GO

USE [organizacao] ;

DROP TABLE IF EXISTS [pessoa] ;

CREATE TABLE pessoa (
  [id] INT NOT NULL,
  [nome] VARCHAR(200) NOT NULL,
  [cpf] DECIMAL(11,0) NOT NULL,
  [em_atividade] BIT NOT NULL,
  [data_atualizacao] DATETIME NOT NULL,
  PRIMARY KEY ([id]))
;

CREATE UNIQUE INDEX cpf_UNIQUE ON pessoa ([cpf] ASC) ;

CREATE INDEX atualizacao_idx ON pessoa ([id] ASC, [data_atualizacao] ASC) ;

DROP TABLE IF EXISTS [departamento] ;

CREATE TABLE departamento (
  [id] INT NOT NULL,
  [nome] VARCHAR(500) NOT NULL,
  [sigla] VARCHAR(20) NULL,
  [superior_id] INT NULL,
  [responsavel_id] INT NULL,
  [substituto_id] INT NULL,
  [data_atualizacao] DATETIME NULL,
  PRIMARY KEY ([id]),
  CONSTRAINT [fk_departamento_departamento]
    FOREIGN KEY ([superior_id])
    REFERENCES departamento ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT [fk_departamento_pessoa_responsavel]
    FOREIGN KEY ([responsavel_id])
    REFERENCES pessoa ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT [fk_departamento_pessoa_substituto]
    FOREIGN KEY ([substituto_id])
    REFERENCES pessoa ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_departamento_departamento_idx ON departamento ([superior_id] ASC) ;

CREATE INDEX fk_departamento_pessoa_responsavel_idx ON departamento ([responsavel_id] ASC) ;

CREATE INDEX fk_departamento_pessoa_substituto_idx ON departamento ([substituto_id] ASC) ;

CREATE INDEX atualizacao_idx ON departamento ([id] ASC, [data_atualizacao] ASC) ;

DROP TABLE IF EXISTS [papel] ;

CREATE TABLE papel (
  [id] INT NOT NULL,
  [nome] VARCHAR(50) NOT NULL,
  [descricao] VARCHAR(max) NULL,
  [data_atualizacao] DATETIME NULL,
  PRIMARY KEY ([id]))
;

CREATE UNIQUE INDEX nome_UNIQUE ON papel ([nome] ASC) ;

CREATE INDEX atualizacao_idx ON papel ([id] ASC, [data_atualizacao] ASC) ;

DROP TABLE IF EXISTS [alocacao] ;

CREATE TABLE alocacao (
  [pessoa_id] INT NOT NULL,
  [departamento_id] INT NOT NULL,
  [registro] VARCHAR(10) NOT NULL,
  [data_inicio] DATETIME NOT NULL,
  [data_fim] DATETIME NULL,
  [papel_id] INT NOT NULL,
  [_sequencia_inclusao] INT NOT NULL,
  [data_atualizacao] DATETIME NOT NULL,
  PRIMARY KEY ([pessoa_id], [departamento_id]),
  CONSTRAINT [fk_alocacao_departamento]
    FOREIGN KEY ([departamento_id])
    REFERENCES departamento ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT [fk_alocacao_pessoa]
    FOREIGN KEY ([pessoa_id])
    REFERENCES pessoa ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT [fk_alocacao_papel]
    FOREIGN KEY ([papel_id])
    REFERENCES papel ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_alocacao_pessoa_idx ON alocacao ([pessoa_id] ASC) ;

CREATE INDEX fk_alocacao_departamento_idx ON alocacao ([departamento_id] ASC) ;

CREATE INDEX fk_alocacao_papel_idx ON alocacao ([papel_id] ASC) ;

CREATE INDEX atualizacao_idx ON alocacao ([_sequencia_inclusao] ASC, [data_atualizacao] ASC) ;

DROP TABLE IF EXISTS [departamento_pj] ;

CREATE TABLE departamento_pj (
  [departamento_id] INT NOT NULL,
  [cnpj] DECIMAL(14) NOT NULL,
  [razao_social] VARCHAR(200) NULL,
  [data_atualizacao] DATETIME NOT NULL,
  PRIMARY KEY ([departamento_id]),
  CONSTRAINT [fk_departamento_pj_departamento1]
    FOREIGN KEY ([departamento_id])
    REFERENCES departamento ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE UNIQUE INDEX cnpj_UNIQUE ON departamento_pj ([cnpj] ASC) ;

CREATE INDEX atualizacao_idx ON departamento_pj ([departamento_id] ASC, [data_atualizacao] ASC) ;

DROP TABLE IF EXISTS [evento] ;

CREATE TABLE evento (
  [id] INT NOT NULL,
  [descricao] VARCHAR(1000) NOT NULL,
  [data_ocorrencia] DATETIME NULL,
  PRIMARY KEY ([id]))
;

CREATE INDEX atualizacao_idx ON evento ([id] ASC, [data_ocorrencia] ASC) ;
