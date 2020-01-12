-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema DW_URG
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `DW_URG` ;

-- -----------------------------------------------------
-- Schema DW_URG
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DW_URG` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `DW_URG` ;

-- -----------------------------------------------------
-- Table `DW_URG`.`DIM_ESPECIALIDADE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_URG`.`DIM_ESPECIALIDADE` (
  `id_Especialidade` INT NOT NULL AUTO_INCREMENT,
  `especialidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Especialidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_URG`.`DIM_LOCAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_URG`.`DIM_LOCAL` (
  `id_Local` INT NOT NULL AUTO_INCREMENT,
  `localidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Local`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_URG`.`DIM_CAUSA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_URG`.`DIM_CAUSA` (
  `id_Causa` INT NOT NULL AUTO_INCREMENT,
  `causa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Causa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_URG`.`DIM_GENERO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_URG`.`DIM_GENERO` (
  `id_Genero` INT NOT NULL AUTO_INCREMENT,
  `genero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Genero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_URG`.`DIM_PROVENIENCIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_URG`.`DIM_PROVENIENCIA` (
  `id_Proveniencia` INT NOT NULL AUTO_INCREMENT,
  `proveniencia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Proveniencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_URG`.`DIM_DATA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_URG`.`DIM_DATA` (
  `id_Data` INT NOT NULL AUTO_INCREMENT,
  `data_adm` DATETIME NOT NULL,
  PRIMARY KEY (`id_Data`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW_URG`.`FACTS_URG`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW_URG`.`FACTS_URG` (
  `id_Facts` INT NOT NULL AUTO_INCREMENT,
  `idade` INT NOT NULL,
  `tempo_urg` INT NOT NULL,
  `id_Especialidade` INT NOT NULL,
  `id_Local` INT NOT NULL,
  `id_Causa` INT NOT NULL,
  `id_Genero` INT NOT NULL,
  `id_Proveniencia` INT NOT NULL,
  `id_Data` INT NOT NULL,
  PRIMARY KEY (`id_Facts`),
  INDEX `fk_idDIM_ESPECIALIDADE_idx` (`id_Especialidade` ASC) VISIBLE,
  INDEX `fk_idDIM_LOCAL_idx` (`id_Local` ASC) VISIBLE,
  INDEX `fk_idDIM_CAUSA_idx` (`id_Causa` ASC) VISIBLE,
  INDEX `fk_idDIM_GENERO_idx` (`id_Genero` ASC) VISIBLE,
  INDEX `fk_idDIM_PROVENIENCIA_idx` (`id_Proveniencia` ASC) VISIBLE,
  INDEX `fk_idDIM_DATA_idx` (`id_Data` ASC) VISIBLE,
  CONSTRAINT `fk_idDIM_ESPECIALIDADE`
    FOREIGN KEY (`id_Especialidade`)
    REFERENCES `DW_URG`.`DIM_ESPECIALIDADE` (`id_Especialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idDIM_LOCAL`
    FOREIGN KEY (`id_Local`)
    REFERENCES `DW_URG`.`DIM_LOCAL` (`id_Local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idDIM_CAUSA`
    FOREIGN KEY (`id_Causa`)
    REFERENCES `DW_URG`.`DIM_CAUSA` (`id_Causa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idDIM_GENERO`
    FOREIGN KEY (`id_Genero`)
    REFERENCES `DW_URG`.`DIM_GENERO` (`id_Genero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idDIM_PROVENIENCIA`
    FOREIGN KEY (`id_Proveniencia`)
    REFERENCES `DW_URG`.`DIM_PROVENIENCIA` (`id_Proveniencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idDIM_DATA`
    FOREIGN KEY (`id_Data`)
    REFERENCES `DW_URG`.`DIM_DATA` (`id_Data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
