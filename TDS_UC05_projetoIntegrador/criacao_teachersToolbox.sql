-- MySQL Script generated by MySQL Workbench
-- Sun Jun 26 23:08:47 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema teachersToolbox
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema teachersToolbox
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `teachersToolbox` DEFAULT CHARACTER SET utf8mb4 ;
USE `teachersToolbox` ;

-- -----------------------------------------------------
-- Table `teachersToolbox`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`USUARIO` (
  `usuarioID` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARBINARY(100) NOT NULL,
  PRIMARY KEY (`usuarioID`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`MATERIAL_TIPO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`MATERIAL_TIPO` (
  `materialTipoID` INT NOT NULL AUTO_INCREMENT,
  `tipoDescricao` VARCHAR(30) NULL,
  PRIMARY KEY (`materialTipoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`MATERIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`MATERIAL` (
  `materialID` INT NOT NULL AUTO_INCREMENT,
  `materialTitulo` VARCHAR(100) NULL,
  `materialDescricao` VARCHAR(400) NULL,
  `dataPostagem` DATETIME NULL,
  `competenciaID` INT NULL,
  `habilidadeID` INT NULL,
  `materialTipoID` INT NOT NULL,
  PRIMARY KEY (`materialID`, `materialTipoID`),
  INDEX `materialTipoID` (`materialTipoID` ASC) VISIBLE,
  CONSTRAINT `materialTipoID`
    FOREIGN KEY (`materialTipoID`)
    REFERENCES `teachersToolbox`.`MATERIAL_TIPO` (`materialTipoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`CADASTRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`CADASTRO` (
  `idCADASTRO` INT NOT NULL AUTO_INCREMENT,
  `usuarioNome` VARCHAR(45) NOT NULL,
  `usuarioUltimoNome` VARCHAR(45) NOT NULL,
  `dataNascimento` DATE NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `usuarioID` INT NOT NULL,
  PRIMARY KEY (`idCADASTRO`, `usuarioID`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`email` ASC),
  INDEX `usuarioID` (`usuarioID` ASC),
  CONSTRAINT `usuarioID`
    FOREIGN KEY (`usuarioID`)
    REFERENCES `teachersToolbox`.`USUARIO` (`usuarioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`PERMISSAO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`PERMISSAO` (
  `permissaoID` INT NOT NULL AUTO_INCREMENT,
  `permissaoNome` VARCHAR(45) NULL,
  PRIMARY KEY (`permissaoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`ENDERECO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`ENDERECO` (
  `enderecoID` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(100) NULL,
  `numero` INT NULL,
  `complemento` VARCHAR(25) NULL,
  `bairro` VARCHAR(50) NULL,
  `CEP` CHAR(8) NULL,
  `cidade` VARCHAR(50) NULL,
  `estado` CHAR(2) NULL,
  PRIMARY KEY (`enderecoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`HABILIDADE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`HABILIDADE` (
  `habilidadeID` INT NOT NULL AUTO_INCREMENT,
  `habilidadeCodigo` CHAR(8) NULL,
  `habilidadeDescricao` VARCHAR(400) NULL,
  PRIMARY KEY (`habilidadeID`),
  UNIQUE INDEX `habilidadeCodigo_UNIQUE` (`habilidadeCodigo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`COMPETENCIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`COMPETENCIA` (
  `competenciaID` INT NOT NULL AUTO_INCREMENT,
  `competenciaDescricao` VARCHAR(400) NULL,
  PRIMARY KEY (`competenciaID`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `teachersToolbox`.`TIPO_ASSINATURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`TIPO_ASSINATURA` (
  `tipoAssinaturaID` INT NOT NULL AUTO_INCREMENT,
  `tipoDescricao` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`tipoAssinaturaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`ASSINATURA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`ASSINATURA` (
  `assinaturaID` INT NOT NULL AUTO_INCREMENT,
  `usuarioID` INT NOT NULL,
  `tipoAssinaturaID` INT NOT NULL,
  PRIMARY KEY (`assinaturaID`, `usuarioID`, `tipoAssinaturaID`),
  INDEX `usuarioID` (`usuarioID` ASC) VISIBLE,
  INDEX `tipoAssinaturaID` (`tipoAssinaturaID` ASC) VISIBLE,
  CONSTRAINT `usuarioID1`
    FOREIGN KEY (`usuarioID`)
    REFERENCES `teachersToolbox`.`USUARIO` (`usuarioID`),
  CONSTRAINT `tipoAssinaturaID`
    FOREIGN KEY (`tipoAssinaturaID`)
    REFERENCES `teachersToolbox`.`TIPO_ASSINATURA` (`tipoAssinaturaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`TELEFONE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`TELEFONE` (
  `telefoneID` INT NOT NULL AUTO_INCREMENT,
  `numero` CHAR(13) NULL,
  `tipo_contato` VARCHAR(20) NULL,
  PRIMARY KEY (`telefoneID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`MAT_tem_HAB`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`MAT_tem_HAB` (
  `materialID` INT NOT NULL,
  `habilidadeID` INT NOT NULL,
  PRIMARY KEY (`materialID`, `habilidadeID`),
  INDEX `habilidadeID` (`habilidadeID` ASC) VISIBLE,
  INDEX `materialID` (`materialID` ASC) VISIBLE,
  CONSTRAINT `materialID`
    FOREIGN KEY (`materialID`)
    REFERENCES `teachersToolbox`.`MATERIAL` (`materialID`),
  CONSTRAINT `habilidadeID`
    FOREIGN KEY (`habilidadeID`)
    REFERENCES `teachersToolbox`.`HABILIDADE` (`habilidadeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`MAT_tem_COMPT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`MAT_tem_COMPT` (
  `materialID` INT NOT NULL,
  `competenciaID` INT NOT NULL,
  PRIMARY KEY (`materialID`, `competenciaID`),
  INDEX `competenciaID` (`competenciaID` ASC) VISIBLE,
  INDEX `materialID` (`materialID` ASC) VISIBLE,
  CONSTRAINT `materialID1`
    FOREIGN KEY (`materialID`)
    REFERENCES `teachersToolbox`.`MATERIAL` (`materialID`),
  CONSTRAINT `competenciaID`
    FOREIGN KEY (`competenciaID`)
    REFERENCES `teachersToolbox`.`COMPETENCIA` (`competenciaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`ROLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`ROLE` (
  `roleID` INT NOT NULL AUTO_INCREMENT,
  `roleNome` VARCHAR(30) NULL,
  `roleDescricao` VARCHAR(300) NULL,
  PRIMARY KEY (`roleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`ROLE_tem_PERMISSAO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`ROLE_tem_PERMISSAO` (
  `roleID` INT NOT NULL AUTO_INCREMENT,
  `permissaoID` INT NOT NULL,
  PRIMARY KEY (`roleID`, `permissaoID`),
  INDEX `permissaoID` (`permissaoID` ASC) VISIBLE,
  INDEX `roleID` (`roleID` ASC) VISIBLE,
  CONSTRAINT `roleID`
    FOREIGN KEY (`roleID`)
    REFERENCES `teachersToolbox`.`ROLE` (`roleID`),
  CONSTRAINT `permissaoID`
    FOREIGN KEY (`permissaoID`)
    REFERENCES `teachersToolbox`.`PERMISSAO` (`permissaoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`USUARIO_acessa_MATERIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`USUARIO_acessa_MATERIAL` (
  `materialTipoID` INT NOT NULL,
  `usuarioID` INT NOT NULL,
  PRIMARY KEY (`materialTipoID`, `usuarioID`),
  INDEX `usuarioID` (`usuarioID` ASC) VISIBLE,
  INDEX `materialTipoID` (`materialTipoID` ASC) VISIBLE,
  CONSTRAINT `materialTipoID1`
    FOREIGN KEY (`materialTipoID`)
    REFERENCES `teachersToolbox`.`MATERIAL_TIPO` (`materialTipoID`),
  CONSTRAINT `usuarioID2`
    FOREIGN KEY (`usuarioID`)
    REFERENCES `teachersToolbox`.`USUARIO` (`usuarioID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `teachersToolbox`.`USUARIO_tem_ENDERECO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`USUARIO_tem_ENDERECO` (
  `enderecoID` INT NOT NULL,
  `usuarioID` INT NOT NULL,
  PRIMARY KEY (`enderecoID`, `usuarioID`),
  INDEX `usuarioID` (`usuarioID` ASC) VISIBLE,
  INDEX `enderecoID` (`enderecoID` ASC) VISIBLE,
  CONSTRAINT `enderecoID`
    FOREIGN KEY (`enderecoID`)
    REFERENCES `teachersToolbox`.`ENDERECO` (`enderecoID`),
  CONSTRAINT `usuarioID3`
    FOREIGN KEY (`usuarioID`)
    REFERENCES `teachersToolbox`.`USUARIO` (`usuarioID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`USUARIO_has_ROLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`USUARIO_has_ROLE` (
  `usuarioID` INT NOT NULL,
  `roleID` INT NOT NULL,
  PRIMARY KEY (`usuarioID`, `roleID`),
  INDEX `roleID` (`roleID` ASC) VISIBLE,
  INDEX `usuarioID` (`usuarioID` ASC) VISIBLE,
  CONSTRAINT `usuarioID4`
    FOREIGN KEY (`usuarioID`)
    REFERENCES `teachersToolbox`.`USUARIO` (`usuarioID`),
  CONSTRAINT `roleID1`
    FOREIGN KEY (`roleID`)
    REFERENCES `teachersToolbox`.`ROLE` (`roleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `teachersToolbox`.`USUARIO_has_TELEFONE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teachersToolbox`.`USUARIO_has_TELEFONE` (
  `usuarioID` INT NOT NULL,
  `telefoneID` INT NOT NULL,
  PRIMARY KEY (`usuarioID`, `telefoneID`),
  INDEX `telefoneID` (`telefoneID` ASC) VISIBLE,
  INDEX `usuarioID` (`usuarioID` ASC) VISIBLE,
  CONSTRAINT `usuarioID5`
    FOREIGN KEY (`usuarioID`)
    REFERENCES `teachersToolbox`.`USUARIO` (`usuarioID`),
  CONSTRAINT `telefoneID`
    FOREIGN KEY (`telefoneID`)
    REFERENCES `teachersToolbox`.`TELEFONE` (`telefoneID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;