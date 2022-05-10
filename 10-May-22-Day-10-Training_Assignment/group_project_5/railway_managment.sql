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
-- -----------------------------------------------------
-- Schema railway_mangment_station
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `user_name` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `contanct` INT NULL,
  `age` INT NULL,
  `gender` CHAR NULL,
  PRIMARY KEY (`user_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Login` (
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `users_user_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_name`),
  INDEX `fk_Login_users_idx` (`users_user_name` ASC) VISIBLE,
  CONSTRAINT `fk_Login_users`
    FOREIGN KEY (`users_user_name`)
    REFERENCES `mydb`.`users` (`user_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Train`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Train` (
  `train_no` BIGINT(10) NOT NULL,
  `train_name` VARCHAR(45) NULL,
  `source` VARCHAR(45) NULL,
  `cost` INT NULL,
  `destination` VARCHAR(45) NULL,
  `distance` INT NULL,
  PRIMARY KEY (`train_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Train_ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Train_ticket` (
  `PNR` INT NOT NULL,
  `date_avail` DATE NULL,
  `date_flight` DATE NULL,
  `time_depart` TIME NULL,
  `time_land` TIME NULL,
  `destination` VARCHAR(45) NULL,
  `source` VARCHAR(45) NULL,
  `Quota` VARCHAR(45) NULL,
  PRIMARY KEY (`PNR`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transaction` (
  `user_name` VARCHAR(45) NOT NULL,
  `transaction_id` INT NULL,
  `res_id` INT NULL,
  `trans_date` DATE NULL,
  PRIMARY KEY (`user_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reservation` (
  `res_id` INT NOT NULL,
  `user_name` VARCHAR(45) NULL,
  `ticket_id` INT NULL,
  `date_reserve` DATE NULL,
  `date_allocate` DATE NULL,
  `Train_ticket_PNR` INT NOT NULL,
  `users_user_name` VARCHAR(45) NOT NULL,
  `Transaction_user_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`res_id`, `Train_ticket_PNR`, `users_user_name`, `Transaction_user_name`),
  INDEX `fk_Reservation_Train_ticket1_idx` (`Train_ticket_PNR` ASC) VISIBLE,
  INDEX `fk_Reservation_users1_idx` (`users_user_name` ASC) VISIBLE,
  INDEX `fk_Reservation_Transaction1_idx` (`Transaction_user_name` ASC) VISIBLE,
  CONSTRAINT `fk_Reservation_Train_ticket1`
    FOREIGN KEY (`Train_ticket_PNR`)
    REFERENCES `mydb`.`Train_ticket` (`PNR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservation_users1`
    FOREIGN KEY (`users_user_name`)
    REFERENCES `mydb`.`users` (`user_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservation_Transaction1`
    FOREIGN KEY (`Transaction_user_name`)
    REFERENCES `mydb`.`Transaction` (`user_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ticket_cancellation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ticket_cancellation` (
  `PNR` INT NOT NULL,
  `user_name` VARCHAR(45) NULL,
  `ticket_id` INT NULL,
  `cost` INT NULL,
  `refund_amount` INT NULL,
  `Reservation_res_id` INT NOT NULL,
  `Reservation_Train_ticket_PNR` INT NOT NULL,
  `Reservation_users_user_name` VARCHAR(45) NOT NULL,
  `Reservation_Transaction_user_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PNR`),
  INDEX `fk_Ticket_cancellation_Reservation1_idx` (`Reservation_res_id` ASC, `Reservation_Train_ticket_PNR` ASC, `Reservation_users_user_name` ASC, `Reservation_Transaction_user_name` ASC) VISIBLE,
  CONSTRAINT `fk_Ticket_cancellation_Reservation1`
    FOREIGN KEY (`Reservation_res_id` , `Reservation_Train_ticket_PNR` , `Reservation_users_user_name` , `Reservation_Transaction_user_name`)
    REFERENCES `mydb`.`Reservation` (`res_id` , `Train_ticket_PNR` , `users_user_name` , `Transaction_user_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Passenger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Passenger` (
  `PNR` BIGINT(10) NOT NULL,
  `user_name` VARCHAR(45) NULL,
  `age` INT NULL,
  `p_name` VARCHAR(45) NULL,
  `Gender` CHAR NULL,
  `source` VARCHAR(45) NULL,
  `destination` VARCHAR(45) NULL,
  `train_no` BIGINT(10) NULL,
  `users_user_name` VARCHAR(45) NOT NULL,
  `Train_train_no` BIGINT(10) NOT NULL,
  `Ticket_cancellation_PNR` INT NOT NULL,
  `Train_ticket_PNR` INT NOT NULL,
  PRIMARY KEY (`PNR`, `Train_train_no`),
  INDEX `fk_Passenger_users1_idx` (`users_user_name` ASC) VISIBLE,
  INDEX `fk_Passenger_Train1_idx` (`Train_train_no` ASC) VISIBLE,
  INDEX `fk_Passenger_Ticket_cancellation1_idx` (`Ticket_cancellation_PNR` ASC) VISIBLE,
  INDEX `fk_Passenger_Train_ticket1_idx` (`Train_ticket_PNR` ASC) VISIBLE,
  CONSTRAINT `fk_Passenger_users1`
    FOREIGN KEY (`users_user_name`)
    REFERENCES `mydb`.`users` (`user_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Passenger_Train1`
    FOREIGN KEY (`Train_train_no`)
    REFERENCES `mydb`.`Train` (`train_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Passenger_Ticket_cancellation1`
    FOREIGN KEY (`Ticket_cancellation_PNR`)
    REFERENCES `mydb`.`Ticket_cancellation` (`PNR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Passenger_Train_ticket1`
    FOREIGN KEY (`Train_ticket_PNR`)
    REFERENCES `mydb`.`Train_ticket` (`PNR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Station`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Station` (
  `train_no` BIGINT(10) NOT NULL,
  `station_name` VARCHAR(45) NULL,
  `platforrm_no` INT NULL,
  `Train_train_no` BIGINT(10) NOT NULL,
  PRIMARY KEY (`train_no`),
  INDEX `fk_Station_Train1_idx` (`Train_train_no` ASC) VISIBLE,
  CONSTRAINT `fk_Station_Train1`
    FOREIGN KEY (`Train_train_no`)
    REFERENCES `mydb`.`Train` (`train_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`History`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`History` (
  `PNR` INT NOT NULL,
  `user_name` VARCHAR(45) NULL,
  `refund_amount` INT NULL,
  `source` VARCHAR(45) NULL,
  `destination` VARCHAR(45) NULL,
  `users_user_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PNR`),
  INDEX `fk_History_users1_idx` (`users_user_name` ASC) VISIBLE,
  CONSTRAINT `fk_History_users1`
    FOREIGN KEY (`users_user_name`)
    REFERENCES `mydb`.`users` (`user_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
