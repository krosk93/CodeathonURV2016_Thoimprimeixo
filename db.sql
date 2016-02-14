-- MySQL Script generated by MySQL Workbench
-- Sun Feb 14 09:43:24 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema apunt_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema apunt_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `apunt_db` DEFAULT CHARACTER SET utf8 ;
USE `apunt_db` ;

-- -----------------------------------------------------
-- Table `apunt_db`.`Usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apunt_db`.`Usuarios` ;

CREATE TABLE IF NOT EXISTS `apunt_db`.`Usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `apellidos` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `dni` VARCHAR(45) NULL,
  `validado` TINYINT(1) NULL,
  `suscrito` TINYINT(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apunt_db`.`Copisterias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apunt_db`.`Copisterias` ;

CREATE TABLE IF NOT EXISTS `apunt_db`.`Copisterias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `latitud` FLOAT NULL,
  `longitud` FLOAT NULL,
  `direccion` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apunt_db`.`Tarifas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apunt_db`.`Tarifas` ;

CREATE TABLE IF NOT EXISTS `apunt_db`.`Tarifas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idCopisteria` INT NULL,
  `precio_byn` DECIMAL NULL,
  `precio_color` DECIMAL NULL,
  `tiempo` TIME(0) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Tarifas_Copisterias_idx` (`idCopisteria` ASC),
  CONSTRAINT `fk_Tarifas_Copisterias`
    FOREIGN KEY (`idCopisteria`)
    REFERENCES `apunt_db`.`Copisterias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apunt_db`.`Trabajos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apunt_db`.`Trabajos` ;

CREATE TABLE IF NOT EXISTS `apunt_db`.`Trabajos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idTarifa` INT NULL,
  `idUsuario` INT NULL,
  `estado` TINYINT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Trabajos_Tarifas1_idx` (`idTarifa` ASC),
  INDEX `fk_Trabajos_Usuarios1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Trabajos_Tarifas1`
    FOREIGN KEY (`idTarifa`)
    REFERENCES `apunt_db`.`Tarifas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabajos_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `apunt_db`.`Usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apunt_db`.`Archivos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apunt_db`.`Archivos` ;

CREATE TABLE IF NOT EXISTS `apunt_db`.`Archivos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idTrabajo` INT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Archivos_Trabajos1_idx` (`idTrabajo` ASC),
  CONSTRAINT `fk_Archivos_Trabajos1`
    FOREIGN KEY (`idTrabajo`)
    REFERENCES `apunt_db`.`Trabajos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apunt_db`.`Admin_copisterias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apunt_db`.`Admin_copisterias` ;

CREATE TABLE IF NOT EXISTS `apunt_db`.`Admin_copisterias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idCopisteria` INT NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Admin_copisterias_Copisterias1_idx` (`idCopisteria` ASC),
  CONSTRAINT `fk_Admin_copisterias_Copisterias1`
    FOREIGN KEY (`idCopisteria`)
    REFERENCES `apunt_db`.`Copisterias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apunt_db`.`Valoracion_copisterias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apunt_db`.`Valoracion_copisterias` ;

CREATE TABLE IF NOT EXISTS `apunt_db`.`Valoracion_copisterias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idCopisteria` INT NULL,
  `idUsuario` INT NULL,
  `valoracion` DECIMAL NULL,
  `texto` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Valoracion_copisterias_Copisterias1_idx` (`idCopisteria` ASC),
  INDEX `fk_Valoracion_copisterias_Usuarios1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Valoracion_copisterias_Copisterias1`
    FOREIGN KEY (`idCopisteria`)
    REFERENCES `apunt_db`.`Copisterias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Valoracion_copisterias_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `apunt_db`.`Usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apunt_db`.`Valoracion_usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `apunt_db`.`Valoracion_usuarios` ;

CREATE TABLE IF NOT EXISTS `apunt_db`.`Valoracion_usuarios` (
  `id` INT NOT NULL,
  `idUsuario` INT NULL,
  `idCopisteria` INT NULL,
  `valoracion` DECIMAL NULL,
  `texto` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Valoracion_usuarios_Usuarios1_idx` (`idUsuario` ASC),
  INDEX `fk_Valoracion_usuarios_Copisterias1_idx` (`idCopisteria` ASC),
  CONSTRAINT `fk_Valoracion_usuarios_Usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `apunt_db`.`Usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Valoracion_usuarios_Copisterias1`
    FOREIGN KEY (`idCopisteria`)
    REFERENCES `apunt_db`.`Copisterias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
