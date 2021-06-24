CREATE DATABASE organizacao ;
GO

USE [organizacao] ;

DROP TABLE IF EXISTS [pessoa] ;

CREATE TABLE pessoa (
  [id] INT NOT NULL IDENTITY,
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
  [id] INT NOT NULL IDENTITY,
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
  [id] INT NOT NULL IDENTITY,
  [descricao] VARCHAR(1000) NOT NULL,
  [data_ocorrencia] DATETIME NULL,
  PRIMARY KEY ([id]))
;

CREATE INDEX atualizacao_idx ON evento ([id] ASC, [data_ocorrencia] ASC) ;

BEGIN TRANSACTION;
USE [organizacao];
SET IDENTITY_INSERT pessoa ON;
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (1, 'Pietro Renan da Conceição', 23108939513, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (2, 'Francisca Juliana Sophia Santos', 72248550901, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (3, 'Alícia Lorena Jaqueline Monteiro', 39771694405, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (4, 'Márcia Elisa da Cunha', 65976866409, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (5, 'Hugo Carlos Bruno Oliveira', 28261715264, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (6, 'Stella Heloise Assis', 12836654090, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (7, 'Leandro Renan Lima', 16716846727, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (8, 'Emanuelly Aurora Bárbara Monteiro', 47053729052, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (9, 'Marcelo Leandro Bernardes', 67036492279, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (10, 'César Breno Sales', 72587102308, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (11, 'Bruna Analu Fátima Gonçalves', 75752606098, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (12, 'Alana Gabrielly Letícia da Rocha', 73651759407, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (13, 'César Vinicius da Costa', 6888808351, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (14, 'Melissa Regina Natália Sales', 17416676401, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (15, 'Fátima Laís Liz Silveira', 23561902103, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (16, 'Leandro Benedito Silva', 7021400071, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (17, 'Ricardo Enrico Igor da Cunha', 29910331268, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (18, 'Bernardo Oliver Mendes', 20057374880, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (19, 'Samuel Calebe Thiago dos Santos', 79319298459, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (20, 'Cristiane Aparecida Martins', 1059425700, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (21, 'Roberto Vinicius Araújo', 421274247, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (22, 'Emily Alice Novaes', 69807494800, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (23, 'Iago Yuri Juan Cavalcanti', 71354372255, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (24, 'Daiane Isadora Duarte', 45454753378, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (25, 'Débora Manuela Evelyn Assis', 72985273048, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (26, 'Bento Rafael Theo Jesus', 66363959667, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (27, 'Eloá Maitê Pinto', 53697899759, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (28, 'Nicolas Francisco Almada', 92227394854, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (29, 'Felipe Márcio Rocha', 16513822807, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (30, 'Clara Stefany Alícia da Costa', 59582641339, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (31, 'Heloisa Manuela Sophia Freitas', 74290155308, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (32, 'Martin Renan Danilo Silveira', 73512741185, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (33, 'Igor Enrico Paulo Campos', 93770730224, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (34, 'Márcio Julio Noah Lopes', 89562655695, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (35, 'Paulo Bryan Francisco Nogueira', 90621234818, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (36, 'Diogo Manoel Souza', 87895605666, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (37, 'Alexandre Nelson Murilo Monteiro', 64136906668, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (38, 'Laura Elisa Débora Ribeiro', 91074207904, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (39, 'Leandro Theo Nascimento', 88413780853, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (40, 'Breno Alexandre Gomes', 77113013597, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (41, 'João Vicente da Mata', 38263113377, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (42, 'Ana Sarah Dias', 09842679136, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (43, 'Manuela Luciana Alves', 35718002819, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (44, 'Caleb Lorenzo Vicente da Mata', 25129367243, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (45, 'Iago Marcos Rocha', 21848401736, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (46, 'Marcos Marcos Vinicius Francisco da Costa', 44639946910, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (47, 'Gabriel Kaique Barbosa', 40694455440, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (48, 'Letícia Amanda Sophia Fernandes', 15699900004, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (49, 'Kaique Levi Costa', 90179499297, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (50, 'Benedito Gael Diogo Ramos', 42255753570, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (51, 'Débora Rayssa Luzia Santos', 70582271878, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (52, 'Melissa Nicole Araújo', 18563632442, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (53, 'Raquel Lorena da Conceição', 13438287161, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (54, 'Esther Rafaela Rocha', 96093374653, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (55, 'Laís Fátima Maya Jesus', 80702281484, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (56, 'Yago Carlos Melo', 08849822111, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (57, 'João Igor Leandro Caldeira', 48625357636, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (58, 'Sophia Nina Figueiredo', 29238617104, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (59, 'Lúcia Silvana das Neves', 45518106572, 1, '2021-01-01 00:00:00.000');
INSERT INTO pessoa ([id], [nome], [cpf], [em_atividade], [data_atualizacao]) VALUES (60, 'Kauê Ricardo Santos', 42969702088, 1, '2021-01-01 00:00:00.000');
SET IDENTITY_INSERT pessoa OFF;

COMMIT;

BEGIN TRANSACTION;
USE [organizacao];
SET IDENTITY_INSERT departamento ON;
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (1, 'Contabilidade Dois Irmãos', 'LLCONT', NULL, 1, 35, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (2, 'Belo Choque Eletrônica', 'ESELETRO', NULL, 34, NULL, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (3, 'Pirâmide Consultoria Financeira', 'OFCFIN', NULL, 10, NULL, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (4, 'G&C Gráfica', 'GCGRAF', NULL, 47, 51, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (5, 'Financeiro', 'FIN', 1, 1, 12, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (6, 'TI', 'TI', 1, 25, 3, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (7, 'RH', 'RH', 1, 4, 6, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (8, 'Atendimento', 'AT', 2, 8, 30, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (9, 'Comercial', 'CCL', 2, 9, 32, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (10, 'Compras', 'CPR', 2, 34, NULL, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (11, 'RH', 'RH', 3, 10, 38, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (12, 'Comercial', 'COM', 3, 12, NULL, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (13, 'Análise Técnica', 'AT', 3, 13, 14, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (14, 'Análise Fundamentalista', 'AF', 3, 46, 44, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (15, 'Comercial', 'CCL', 4, 47, NULL, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (16, 'Compras', 'COM', 4, 50, 19, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (17, 'Gráfica', 'GRF', 4, 51, 20, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (18, 'Operação', 'OP', 17, 56, 57, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (19, 'Manutenção', 'MANUT', 17, 3, 59, '2021-01-01 00:00:00.000');
INSERT INTO departamento ([id], [nome], [sigla], [superior_id], [responsavel_id], [substituto_id], [data_atualizacao]) VALUES (20, 'Reposição', 'REP', 19, 60, NULL, '2021-01-01 00:00:00.000');
SET IDENTITY_INSERT departamento OFF;

COMMIT;

BEGIN TRANSACTION;
USE [organizacao];
INSERT INTO papel ([id], [nome], [descricao], [data_atualizacao]) VALUES (1, 'Auxiliar', 'd volutpat lacus laoreet non curabitur gravida. Netus et malesuada fames ac turpis egestas sed. Curabitur vitae nunc sed velit dignissim sodales ut eu sem. Diam quam nulla porttitor massa id neque aliquam. Viverra justo nec ultrices dui sapien eget mi proin. Neque viverra justo nec ultrices dui sapien eget mi. Volutpat lacus laoreet non curabitur gravida arcu. Imperdiet dui accumsan sit amet nulla facilisi. Dictumst quisque sagittis purus sit amet volutpat consequat mauris. Pharetra et ultrices neque ornare aenean euismod elementum nisi quis. Pellentesque sit amet porttitor eget dolor morbi non arcu risus. Proin nibh nisl condimentum id venenatis a condimentum. Tellus in hac habitasse platea. Proin libero nunc consequat interdum varius sit amet mattis vulputate. Posuere lorem ipsum dolor sit amet consectetur adipiscing. Ornare massa eget egestas purus viverra accumsan in. Sit amet consectetur adipiscing elit pellentesque habitant. Enim sed faucibus turpis in eu. Vivamus arcu felis bibendum ut.', '2021-01-01 00:00:00.000');
INSERT INTO papel ([id], [nome], [descricao], [data_atualizacao]) VALUES (2, 'Analista', 'Aliquam ultrices sagittis orci a scelerisque. Massa massa ultricies mi quis hendrerit. Et malesuada fames ac turpis. Accumsan in nisl nisi scelerisque eu ultrices. Dolor sed viverra ipsum nunc aliquet bibendum enim facilisis. Sagittis aliquam malesuada bibendum arcu vitae elementum curabitur vitae. Risus viverra adipiscing at in tellus integer feugiat scelerisque. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum. Tristique senectus et netus et malesuada fames ac turpis egestas. Sit amet dictum sit amet justo donec enim diam vulputate. Ut pharetra sit amet aliquam id diam maecenas ultricies. Adipiscing bibendum est ultricies integer quis auctor. Est lorem ipsum dolor sit amet consectetur adipiscing elit pellentesque. Quam id leo in vitae turpis massa sed.', '2021-01-01 00:00:00.000');
INSERT INTO papel ([id], [nome], [descricao], [data_atualizacao]) VALUES (3, 'Coordenador', 'Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant. Tempus urna et pharetra pharetra massa massa ultricies mi quis. Mauris in aliquam sem fringilla ut morbi tincidunt augue interdum. Sed enim ut sem viverra aliquet. Elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique. Pellentesque dignissim enim sit amet venenatis urna cursus. Tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla. Sem integer vitae justo eget. Sit amet venenatis urna cursus eget nunc scelerisque viverra mauris. Libero justo laoreet sit amet cursus sit amet dictum sit. Amet commodo nulla facilisi nullam vehicula ipsum. Fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus. Eget lorem dolor sed viverra ipsum nunc aliquet bibendum.', '2021-01-01 00:00:00.000');
INSERT INTO papel ([id], [nome], [descricao], [data_atualizacao]) VALUES (4, 'Gerente', 'Mauris pellentesque pulvinar pellentesque habitant morbi tristique senectus. Luctus venenatis lectus magna fringilla urna. Massa placerat duis ultricies lacus. Sed blandit libero volutpat sed cras. Sed arcu non odio euismod. Malesuada pellentesque elit eget gravida cum sociis. Commodo ullamcorper a lacus vestibulum sed arcu non odio euismod. Sit amet est placerat in egestas erat imperdiet sed. Adipiscing enim eu turpis egestas pretium aenean pharetra. Tincidunt id aliquet risus feugiat in ante metus. A scelerisque purus semper eget duis at tellus at urna. Aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi.', '2021-01-01 00:00:00.000');
INSERT INTO papel ([id], [nome], [descricao], [data_atualizacao]) VALUES (5, 'Diretor', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tristique senectus et netus et malesuada fames ac turpis. Nec ullamcorper sit amet risus. In eu mi bibendum neque egestas congue quisque. Parturient montes nascetur ridiculus mus mauris vitae ultricies leo integer. Quam viverra orci sagittis eu volutpat odio. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Tristique senectus et netus et malesuada. Ante in nibh mauris cursus. Molestie ac feugiat sed lectus vestibulum. Duis ut diam quam nulla porttitor massa id neque. Cursus mattis molestie a iaculis. Vel facilisis volutpat est velit egestas dui. Porttitor leo a diam sollicitudin tempor id eu. Odio facilisis mauris sit amet. Rutrum tellus pellentesque eu tincidunt tortor aliquam nulla. Arcu risus quis varius quam quisque id diam vel quam. Eget aliquet nibh praesent tristique magna.', '2021-01-01 00:00:00.000');

COMMIT;

BEGIN TRANSACTION;
USE [organizacao];
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (1, 5, '4ie2g9q0', '2000-02-23 00:00:00.000', NULL, 4, 1, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (2, 5, 'vrlevbae', '2001-07-25 00:00:00.000', NULL, 4, 2, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (3, 6, 'fw0jccv5', '2002-07-25 00:00:00.000', NULL, 1, 3, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (3, 19, 'g5c0lhju', '2002-10-09 00:00:00.000', NULL, 4, 4, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (4, 7, 'bh23le5i', '2003-07-03 00:00:00.000', NULL, 4, 5, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (5, 7, '238f342o', '2003-11-21 00:00:00.000', NULL, 1, 6, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (6, 7, '5izd8mkf', '2004-03-03 00:00:00.000', '2013-06-04 00:00:00.000', 2, 7, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (7, 7, 'b5vwl99w', '2004-08-19 00:00:00.000', NULL, 5, 8, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (8, 8, 'oa9zmc4w', '2004-10-18 00:00:00.000', NULL, 2, 9, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (9, 9, 'gxh6l9s1', '2005-06-16 00:00:00.000', NULL, 2, 10, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (10, 11, 'hr8fuvno', '2005-10-06 00:00:00.000', NULL, 2, 11, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (12, 5, 'stryxxa0', '2005-11-15 00:00:00.000', NULL, 4, 12, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (12, 12, 'ykmgmer2', '2006-10-26 00:00:00.000', NULL, 3, 13, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (13, 13, 'ipcspweo', '2006-11-15 00:00:00.000', NULL, 5, 14, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (14, 13, 'gnznhdsr', '2006-12-29 00:00:00.000', NULL, 1, 15, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (15, 13, '12ysh1r1', '2008-11-27 00:00:00.000', '2018-04-05 00:00:00.000', 4, 16, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (16, 14, 'spxlsabh', '2009-01-26 00:00:00.000', NULL, 3, 17, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (17, 5, '2ohxoibo', '2009-07-20 00:00:00.000', NULL, 1, 18, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (17, 14, 'q60e0zl6', '2009-10-15 00:00:00.000', NULL, 1, 19, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (17, 15, 'jsqnp04f', '2010-10-12 00:00:00.000', '2018-09-10 00:00:00.000', 2, 20, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (18, 8, 'snlhzfv8', '2011-04-21 00:00:00.000', '2018-09-10 00:00:00.000', 2, 21, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (19, 16, 'n33hbzrc', '2014-05-19 00:00:00.000', '2018-09-10 00:00:00.000', 3, 22, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (20, 17, 'uc3ymlew', '2015-01-29 00:00:00.000', NULL, 1, 23, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (21, 18, '80322ebh', '2015-04-30 00:00:00.000', NULL, 1, 24, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (22, 19, 'ahrq9dp8', '2017-05-05 00:00:00.000', NULL, 5, 25, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (23, 20, 'f3wliz79', '2000-06-26 00:00:00.000', NULL, 3, 26, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (24, 5, 'uo4ie7qe', '2000-09-20 00:00:00.000', NULL, 1, 27, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (25, 6, '4p0tvsx9', '2000-10-23 00:00:00.000', NULL, 4, 28, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (26, 6, 'nm7izpnx', '2002-07-19 00:00:00.000', NULL, 2, 29, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (27, 6, '3ciuntps', '2003-11-21 00:00:00.000', NULL, 3, 30, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (28, 7, 'gf59y1sd', '2005-09-13 00:00:00.000', NULL, 3, 31, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (29, 8, '2bc1lqk8', '2006-03-08 00:00:00.000', NULL, 5, 32, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (30, 8, 'oc9jmtb1', '2007-03-19 00:00:00.000', NULL, 4, 33, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (31, 8, 'wvbz80ed', '2009-06-08 00:00:00.000', NULL, 5, 34, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (32, 9, 'r9cxll2n', '2011-01-03 00:00:00.000', NULL, 2, 35, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (33, 9, '7hcwj25i', '2011-03-23 00:00:00.000', NULL, 4, 36, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (33, 17, '40gonaui', '2012-03-01 00:00:00.000', NULL, 1, 37, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (34, 10, 'f3ckvy87', '2012-08-28 00:00:00.000', NULL, 1, 38, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (35, 10, 'oyyihrgb', '2013-11-05 00:00:00.000', NULL, 3, 39, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (36, 11, 'ioes37by', '2014-01-28 00:00:00.000', NULL, 3, 40, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (37, 11, '9rqzydu1', '2014-05-26 00:00:00.000', NULL, 5, 41, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (38, 11, '733e7va1', '2014-08-22 00:00:00.000', NULL, 4, 42, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (39, 11, '95bp52xp', '2015-04-16 00:00:00.000', NULL, 1, 43, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (40, 12, 'hp4b1svy', '2015-09-29 00:00:00.000', NULL, 4, 44, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (41, 12, '0nqu7rpq', '2016-03-03 00:00:00.000', NULL, 3, 45, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (42, 12, 'vubvniss', '2016-07-26 00:00:00.000', '2019-06-12 00:00:00.000', 4, 46, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (42, 13, '4bd67sf0', '2017-01-25 00:00:00.000', NULL, 2, 47, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (42, 16, '5xqh0dib', '2018-05-07 00:00:00.000', NULL, 1, 48, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (44, 14, 'vr9axy3n', '2018-06-13 00:00:00.000', NULL, 3, 49, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (45, 14, 'tio6s4fi', '2020-04-22 00:00:00.000', NULL, 1, 50, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (46, 14, 'qb7wsen4', '2000-09-07 00:00:00.000', NULL, 3, 51, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (47, 15, 'vei0zioj', '2001-03-05 00:00:00.000', NULL, 5, 52, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (48, 15, 'n12wwmzf', '2001-08-23 00:00:00.000', '2019-11-06 00:00:00.000', 5, 53, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (49, 15, '6syvl0yb', '2002-05-03 00:00:00.000', NULL, 3, 54, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (50, 16, 'o34ftrqf', '2003-04-23 00:00:00.000', NULL, 1, 55, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (51, 17, 'o76zrz8g', '2004-11-11 00:00:00.000', NULL, 1, 56, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (52, 17, '2mr9dlxg', '2007-09-05 00:00:00.000', NULL, 1, 57, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (53, 17, 'gfkf8sn2', '2008-01-10 00:00:00.000', NULL, 4, 58, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (54, 17, '5ro8gz2t', '2008-07-01 00:00:00.000', NULL, 4, 59, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (55, 17, '5xlzhepa', '2008-08-12 00:00:00.000', '2019-11-11 00:00:00.000', 3, 60, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (56, 18, '7rv23r8e', '2010-12-15 00:00:00.000', NULL, 1, 61, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (57, 18, 's6h08buh', '2011-04-25 00:00:00.000', NULL, 5, 62, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (58, 19, 'rpbs8d1b', '2011-05-25 00:00:00.000', NULL, 2, 63, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (59, 19, 'bfutkipb', '2012-11-06 00:00:00.000', NULL, 5, 64, '2021-01-01 00:00:00.000');
INSERT INTO alocacao ([pessoa_id], [departamento_id], [registro], [data_inicio], [data_fim], [papel_id], [_sequencia_inclusao], [data_atualizacao]) VALUES (60, 20, 'orvg2kfa', '2013-02-14 00:00:00.000', NULL, 4, 65, '2021-01-01 00:00:00.000');

COMMIT;

BEGIN TRANSACTION;
USE [organizacao];
INSERT INTO departamento_pj ([departamento_id], [cnpj], [razao_social], [data_atualizacao]) VALUES (1, 30090308000136, 'Lorenzo e Luiz Contábil ME', '2021-01-01 00:00:00.000');
INSERT INTO departamento_pj ([departamento_id], [cnpj], [razao_social], [data_atualizacao]) VALUES (2, 23212181000115, 'Elias e Simone Eletrônica Ltda', '2021-01-01 00:00:00.000');
INSERT INTO departamento_pj ([departamento_id], [cnpj], [razao_social], [data_atualizacao]) VALUES (3, 93758817000104, 'Otávio e Felipe Consultoria Financeira Ltda', '2021-01-01 00:00:00.000');
INSERT INTO departamento_pj ([departamento_id], [cnpj], [razao_social], [data_atualizacao]) VALUES (4, 80998152000164, 'Gustavo e Caroline Gráfica Ltda', '2021-01-01 00:00:00.000');

COMMIT;
