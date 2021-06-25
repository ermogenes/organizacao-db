-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema organizacao
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `organizacao` ;

-- -----------------------------------------------------
-- Schema organizacao
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `organizacao` DEFAULT CHARACTER SET utf8 ;
USE `organizacao` ;

-- -----------------------------------------------------
-- Table `organizacao`.`pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `organizacao`.`pessoa` ;

CREATE TABLE IF NOT EXISTS `organizacao`.`pessoa` (
  `id` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `cpf` DECIMAL(11,0) NOT NULL,
  `em_atividade` BIT NOT NULL,
  `data_atualizacao` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `cpf_UNIQUE` ON `organizacao`.`pessoa` (`cpf` ASC) VISIBLE;

CREATE INDEX `atualizacao_idx` ON `organizacao`.`pessoa` (`id` ASC, `data_atualizacao` ASC) INVISIBLE;


-- -----------------------------------------------------
-- Table `organizacao`.`departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `organizacao`.`departamento` ;

CREATE TABLE IF NOT EXISTS `organizacao`.`departamento` (
  `id` INT NOT NULL,
  `nome` VARCHAR(500) NOT NULL,
  `sigla` VARCHAR(20) NULL,
  `superior_id` INT NULL,
  `responsavel_id` INT NULL,
  `substituto_id` INT NULL,
  `data_atualizacao` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_departamento_departamento`
    FOREIGN KEY (`superior_id`)
    REFERENCES `organizacao`.`departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departamento_pessoa_responsavel`
    FOREIGN KEY (`responsavel_id`)
    REFERENCES `organizacao`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departamento_pessoa_substituto`
    FOREIGN KEY (`substituto_id`)
    REFERENCES `organizacao`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_departamento_departamento_idx` ON `organizacao`.`departamento` (`superior_id` ASC) VISIBLE;

CREATE INDEX `fk_departamento_pessoa_responsavel_idx` ON `organizacao`.`departamento` (`responsavel_id` ASC) VISIBLE;

CREATE INDEX `fk_departamento_pessoa_substituto_idx` ON `organizacao`.`departamento` (`substituto_id` ASC) VISIBLE;

CREATE INDEX `atualizacao_idx` ON `organizacao`.`departamento` (`id` ASC, `data_atualizacao` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `organizacao`.`papel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `organizacao`.`papel` ;

CREATE TABLE IF NOT EXISTS `organizacao`.`papel` (
  `id` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `descricao` TEXT NULL,
  `data_atualizacao` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nome_UNIQUE` ON `organizacao`.`papel` (`nome` ASC) VISIBLE;

CREATE INDEX `atualizacao_idx` ON `organizacao`.`papel` (`id` ASC, `data_atualizacao` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `organizacao`.`alocacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `organizacao`.`alocacao` ;

CREATE TABLE IF NOT EXISTS `organizacao`.`alocacao` (
  `pessoa_id` INT NOT NULL,
  `departamento_id` INT NOT NULL,
  `registro` VARCHAR(10) NOT NULL,
  `data_inicio` DATETIME NOT NULL,
  `data_fim` DATETIME NULL,
  `papel_id` INT NOT NULL,
  `_sequencia_inclusao` INT NOT NULL,
  `data_atualizacao` DATETIME NOT NULL,
  PRIMARY KEY (`pessoa_id`, `departamento_id`),
  CONSTRAINT `fk_alocacao_departamento`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `organizacao`.`departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alocacao_pessoa`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `organizacao`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alocacao_papel`
    FOREIGN KEY (`papel_id`)
    REFERENCES `organizacao`.`papel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_alocacao_pessoa_idx` ON `organizacao`.`alocacao` (`pessoa_id` ASC) VISIBLE;

CREATE INDEX `fk_alocacao_departamento_idx` ON `organizacao`.`alocacao` (`departamento_id` ASC) INVISIBLE;

CREATE INDEX `fk_alocacao_papel_idx` ON `organizacao`.`alocacao` (`papel_id` ASC) VISIBLE;

CREATE INDEX `atualizacao_idx` ON `organizacao`.`alocacao` (`_sequencia_inclusao` ASC, `data_atualizacao` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `organizacao`.`departamento_pj`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `organizacao`.`departamento_pj` ;

CREATE TABLE IF NOT EXISTS `organizacao`.`departamento_pj` (
  `departamento_id` INT NOT NULL,
  `cnpj` DECIMAL(14) NOT NULL,
  `razao_social` VARCHAR(200) NULL,
  `data_atualizacao` DATETIME NOT NULL,
  PRIMARY KEY (`departamento_id`),
  CONSTRAINT `fk_departamento_pj_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `organizacao`.`departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `cnpj_UNIQUE` ON `organizacao`.`departamento_pj` (`cnpj` ASC) VISIBLE;

CREATE INDEX `atualizacao_idx` ON `organizacao`.`departamento_pj` (`departamento_id` ASC, `data_atualizacao` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `organizacao`.`evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `organizacao`.`evento` ;

CREATE TABLE IF NOT EXISTS `organizacao`.`evento` (
  `id` INT NOT NULL,
  `descricao` VARCHAR(1000) NOT NULL,
  `data_ocorrencia` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `atualizacao_idx` ON `organizacao`.`evento` (`id` ASC, `data_ocorrencia` ASC) VISIBLE;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
