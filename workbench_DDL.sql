-- MySQL Script generated by MySQL Workbench
-- dom 27 nov 2022 02:01:25
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Hoteland
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Hoteland` ;

-- -----------------------------------------------------
-- Schema Hoteland
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Hoteland` ;
USE `Hoteland` ;

-- -----------------------------------------------------
-- Table `Hoteland`.`Hostal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hoteland`.`Hostal` (
  `idHostal` INT NOT NULL AUTO_INCREMENT,
  `habitaciones` INT NOT NULL,
  `entidad` VARCHAR(45) NOT NULL,
  `municipio` VARCHAR(45) NOT NULL,
  `colonia` VARCHAR(45) NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `cp` CHAR(5) NOT NULL,
  PRIMARY KEY (`idHostal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hoteland`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hoteland`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidoPaterno` VARCHAR(45) NOT NULL,
  `apellidoMaterno` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `hash` CHAR(64) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `idHostal` INT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Dirigir_idx` (`idHostal` ASC) VISIBLE,
  CONSTRAINT `fk_dirigir`
    FOREIGN KEY (`idHostal`)
    REFERENCES `Hoteland`.`Hostal` (`idHostal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hoteland`.`Telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hoteland`.`Telefono` (
  `telefono` VARCHAR(15) NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`telefono`),
  INDEX `fk_usuarioTelefono_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_dueno`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Hoteland`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'ol';


-- -----------------------------------------------------
-- Table `Hoteland`.`Habitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hoteland`.`Habitacion` (
  `idHabitacion` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `camas` INT NOT NULL,
  `idHostal` INT NOT NULL,
  PRIMARY KEY (`idHabitacion`),
  INDEX `fk_Habitacion_idx` (`idHostal` ASC) VISIBLE,
  CONSTRAINT `fk_pertenecer`
    FOREIGN KEY (`idHostal`)
    REFERENCES `Hoteland`.`Hostal` (`idHostal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hoteland`.`reservacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hoteland`.`reservacion` (
  `idreservacion` INT NOT NULL AUTO_INCREMENT,
  `fechaInicio` DATETIME NOT NULL,
  `fechaFin` DATETIME NOT NULL,
  `idUsuario` INT NOT NULL,
  `idHabitacion` INT NOT NULL,
  PRIMARY KEY (`idreservacion`),
  INDEX `fk_habitacion_idx` (`idHabitacion` ASC) VISIBLE,
  INDEX `fk_cliente_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_cliente`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Hoteland`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_habitacion`
    FOREIGN KEY (`idHabitacion`)
    REFERENCES `Hoteland`.`Habitacion` (`idHabitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hoteland`.`Actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hoteland`.`Actividad` (
  `idActividad` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(256) NOT NULL,
  `imagenPath` VARCHAR(256) NOT NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  `idHostal` INT NOT NULL,
  PRIMARY KEY (`idActividad`),
  INDEX `fk_ofrecer_idx` (`idHostal` ASC) VISIBLE,
  CONSTRAINT `fk_ofrecer`
    FOREIGN KEY (`idHostal`)
    REFERENCES `Hoteland`.`Hostal` (`idHostal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hoteland`.`Inscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hoteland`.`Inscripcion` (
  `idInscripcion` INT NOT NULL AUTO_INCREMENT,
  `idUsuario` INT NOT NULL,
  `idActividad` INT NOT NULL,
  PRIMARY KEY (`idInscripcion`),
  INDEX `fk_participar_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_participar_idx1` (`idActividad` ASC) VISIBLE,
  CONSTRAINT `fk_inscribir`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Hoteland`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_participar`
    FOREIGN KEY (`idActividad`)
    REFERENCES `Hoteland`.`Actividad` (`idActividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
