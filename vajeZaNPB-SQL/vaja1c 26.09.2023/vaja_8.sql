-- MySQL Script generated by MySQL Workbench
-- Tue Sep 26 08:13:09 2023
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
-- Table `mydb`.`Stranka`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Stranka` (
  `id_Stranka` INT NOT NULL,
  `imel` VARCHAR(45) NOT NULL,
  `priimek` VARCHAR(45) NOT NULL,
  `naslov` VARCHAR(45) NOT NULL,
  `GSM` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_Stranka`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Delavec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Delavec` (
  `id_Delavec` VARCHAR(10) NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `priimek` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Delavec`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Popravilo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Popravilo` (
  `id_Popravilo` INT NOT NULL,
  `tip` VARCHAR(45) NOT NULL,
  `proizvajalec` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `serijska_stevilka` VARCHAR(45) NOT NULL,
  `opis_problema` VARCHAR(100) NOT NULL,
  `datum_prejema` DATE NOT NULL,
  `Delavec_id_Delavec` VARCHAR(10) NOT NULL,
  `stevilo_ur` VARCHAR(45) NOT NULL,
  `Stranka_id_Stranka` INT NOT NULL,
  PRIMARY KEY (`id_Popravilo`),
  INDEX `fk_Popravilo_Delavec1_idx` (`Delavec_id_Delavec` ASC) VISIBLE,
  INDEX `fk_Popravilo_Stranka1_idx` (`Stranka_id_Stranka` ASC) VISIBLE,
  CONSTRAINT `fk_Popravilo_Delavec1`
    FOREIGN KEY (`Delavec_id_Delavec`)
    REFERENCES `mydb`.`Delavec` (`id_Delavec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Popravilo_Stranka1`
    FOREIGN KEY (`Stranka_id_Stranka`)
    REFERENCES `mydb`.`Stranka` (`id_Stranka`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zaposleni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Zaposleni` (
  `davcna_st` VARCHAR(15) NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `priimek` VARCHAR(45) NOT NULL,
  `izobrazba` VARCHAR(45) NOT NULL,
  `naslov` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `Delavec_id_Delavec` VARCHAR(10) NULL,
  PRIMARY KEY (`davcna_st`),
  INDEX `fk_Zaposleni_Delavec_idx` (`Delavec_id_Delavec` ASC) VISIBLE,
  CONSTRAINT `fk_Zaposleni_Delavec`
    FOREIGN KEY (`Delavec_id_Delavec`)
    REFERENCES `mydb`.`Delavec` (`id_Delavec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rezervni_deli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rezervni_deli` (
  `id_Rezervni_deli` INT NOT NULL,
  `opis` VARCHAR(45) NOT NULL,
  `cena` FLOAT NOT NULL,
  PRIMARY KEY (`id_Rezervni_deli`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rezervni_deli_has_Popravilo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rezervni_deli_has_Popravilo` (
  `Rezervni_deli_id_Rezervni_deli` INT NOT NULL,
  `Popravilo_id_Popravilo` INT NOT NULL,
  `kolicina` INT NOT NULL,
  PRIMARY KEY (`Rezervni_deli_id_Rezervni_deli`, `Popravilo_id_Popravilo`, `kolicina`),
  INDEX `fk_Rezervni_deli_has_Popravilo_Popravilo1_idx` (`Popravilo_id_Popravilo` ASC) VISIBLE,
  INDEX `fk_Rezervni_deli_has_Popravilo_Rezervni_deli1_idx` (`Rezervni_deli_id_Rezervni_deli` ASC) VISIBLE,
  CONSTRAINT `fk_Rezervni_deli_has_Popravilo_Rezervni_deli1`
    FOREIGN KEY (`Rezervni_deli_id_Rezervni_deli`)
    REFERENCES `mydb`.`Rezervni_deli` (`id_Rezervni_deli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rezervni_deli_has_Popravilo_Popravilo1`
    FOREIGN KEY (`Popravilo_id_Popravilo`)
    REFERENCES `mydb`.`Popravilo` (`id_Popravilo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
