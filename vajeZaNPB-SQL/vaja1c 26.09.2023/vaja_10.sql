-- MySQL Script generated by MySQL Workbench
-- Tue Sep 26 09:01:22 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Izpit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Izpit` (
  `id_Izpit` INT NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `vrsta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Izpit`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Komisija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Komisija` (
  `id_Komisija` INT NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Komisija`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ucitelj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ucitelj` (
  `id_Ucitelj` INT NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `priimek` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Ucitelj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vloga_Ucitelja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vloga_Ucitelja` (
  `Komisija_id_Komisija` INT NOT NULL,
  `Ucitelj_id_Ucitelj` INT NOT NULL,
  `vloga` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Komisija_id_Komisija`, `Ucitelj_id_Ucitelj`),
  INDEX `fk_Komisija_has_Ucitelj_Ucitelj1_idx` (`Ucitelj_id_Ucitelj` ASC) VISIBLE,
  INDEX `fk_Komisija_has_Ucitelj_Komisija_idx` (`Komisija_id_Komisija` ASC) VISIBLE,
  CONSTRAINT `fk_Komisija_has_Ucitelj_Komisija`
    FOREIGN KEY (`Komisija_id_Komisija`)
    REFERENCES `mydb`.`Komisija` (`id_Komisija`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Komisija_has_Ucitelj_Ucitelj1`
    FOREIGN KEY (`Ucitelj_id_Ucitelj`)
    REFERENCES `mydb`.`Ucitelj` (`id_Ucitelj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Kandidati`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Kandidati` (
  `EMSO` VARCHAR(13) NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `priimek` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EMSO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Termin_izpita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Termin_izpita` (
  `Kandidati_EMSO` VARCHAR(13) NOT NULL,
  `Izpit_id_Izpit` INT NOT NULL,
  `datum` DATE NOT NULL,
  `ura` TIME NOT NULL,
  `dosezene_tocke` INT NULL,
  `Komisija_id_Komisija` INT NOT NULL,
  PRIMARY KEY (`Kandidati_EMSO`, `Izpit_id_Izpit`, `datum`),
  INDEX `fk_Kandidati_has_Izpit_Kandidati1_idx` (`Kandidati_EMSO` ASC) VISIBLE,
  INDEX `fk_Termin_izpita_Izpit1_idx` (`Izpit_id_Izpit` ASC) VISIBLE,
  INDEX `fk_Termin_izpita_Komisija1_idx` (`Komisija_id_Komisija` ASC) VISIBLE,
  CONSTRAINT `fk_Kandidati_has_Izpit_Kandidati1`
    FOREIGN KEY (`Kandidati_EMSO`)
    REFERENCES `mydb`.`Kandidati` (`EMSO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Termin_izpita_Izpit1`
    FOREIGN KEY (`Izpit_id_Izpit`)
    REFERENCES `mydb`.`Izpit` (`id_Izpit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Termin_izpita_Komisija1`
    FOREIGN KEY (`Komisija_id_Komisija`)
    REFERENCES `mydb`.`Komisija` (`id_Komisija`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;