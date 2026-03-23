-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pollution
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pollution
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pollution` DEFAULT CHARACTER SET utf8 ;
USE `pollution` ;

-- -----------------------------------------------------
-- Table `pollution`.`Constituency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pollution`.`Constituency` (
  `ConstituencyName` VARCHAR(20) NOT NULL,
  `MPName` VARCHAR(40) NULL,
  PRIMARY KEY (`ConstituencyName`),
  UNIQUE INDEX `ConstituencyName_UNIQUE` (`ConstituencyName` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `pollution`.`SiteLocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pollution`.`SiteLocation` (
  `Latitude` DECIMAL(12,10) NOT NULL,
  `Longitude` DECIMAL(12,11) NOT NULL,
  `ConstituencyName` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Latitude`, `Longitude`),
  INDEX `fk_Detector Location_Constituency1_idx` (`ConstituencyName` ASC) VISIBLE,
  UNIQUE INDEX `Latitude_UNIQUE` (`Latitude` ASC) VISIBLE,
  UNIQUE INDEX `Longitude_UNIQUE` (`Longitude` ASC) VISIBLE,
  CONSTRAINT `fk_Detector Location_Constituency1`
    FOREIGN KEY (`ConstituencyName`)
    REFERENCES `pollution`.`Constituency` (`ConstituencyName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `pollution`.`Site`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pollution`.`Site` (
  `SiteID` SMALLINT(8) NOT NULL,
  `SiteName` VARCHAR(60) NULL,
  `Latitude` DECIMAL(12,10) NOT NULL,
  `Longitude` DECIMAL(12,11) NOT NULL,
  PRIMARY KEY (`SiteID`),
  INDEX `fk_Detectors_Detector Location1_idx` (`Latitude` ASC, `Longitude` ASC) VISIBLE,
  UNIQUE INDEX `SiteID_UNIQUE` (`SiteID` ASC) VISIBLE,
  CONSTRAINT `fk_Detectors_Detector Location1`
    FOREIGN KEY (`Latitude` , `Longitude`)
    REFERENCES `pollution`.`SiteLocation` (`Latitude` , `Longitude`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `pollution`.`Measurement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pollution`.`Measurement` (
  `MeasurementID` INT NOT NULL,
  `DateTime` DATETIME NULL,
  `SiteID` SMALLINT(8) NULL,
  `NOx` FLOAT NULL,
  `NO2` FLOAT NULL,
  `NO` FLOAT NULL,
  `PM10` FLOAT NULL,
  `O3` FLOAT NULL,
  `Temperature` FLOAT NULL,
  `ObjectID` INT NULL,
  `ObjectID2` INT NULL,
  `NVPM10` FLOAT NULL,
  `VPM10` FLOAT NULL,
  `NVPM2.5` FLOAT NULL,
  `PM2.5` FLOAT NULL,
  `VPM2.5` FLOAT NULL,
  `CO` FLOAT NULL,
  `RH` FLOAT NULL,
  `Pressure` FLOAT NULL,
  `SO2` FLOAT NULL,
  PRIMARY KEY (`MeasurementID`),
  INDEX `fk_Measurements_Detectors1_idx` (`SiteID` ASC) VISIBLE,
  UNIQUE INDEX `MeasurementID_UNIQUE` (`MeasurementID` ASC) VISIBLE,
  CONSTRAINT `fk_Measurements_Detectors1`
    FOREIGN KEY (`SiteID`)
    REFERENCES `pollution`.`Site` (`SiteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
