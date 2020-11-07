-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cinema
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cinema` ;

-- -----------------------------------------------------
-- Schema cinema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cinema` DEFAULT CHARACTER SET utf8 ;
USE `cinema` ;

-- -----------------------------------------------------
-- Table `cinema`.`cinema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`cinema` ;

CREATE TABLE IF NOT EXISTS `cinema`.`cinema` (
  `cinema_id` INT NOT NULL AUTO_INCREMENT,
  `cinema_city` VARCHAR(45) NOT NULL,
  `cinema_zip` VARCHAR(5) NOT NULL,
  `cinema_address` VARCHAR(45) NOT NULL,
  `cinema_nr_of_places` INT NOT NULL,
  `cinema_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was modified',
  `cinema_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was created',
  PRIMARY KEY (`cinema_id`))
ENGINE = InnoDB;

CREATE INDEX `idx_address` ON `cinema`.`cinema` (`cinema_city` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cinema`.`movie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`movie` ;

CREATE TABLE IF NOT EXISTS `cinema`.`movie` (
  `movie_id` INT NOT NULL AUTO_INCREMENT,
  `movie_title` VARCHAR(128) NOT NULL,
  `movie_fsk` TINYINT(4) NOT NULL,
  `movie_duration` TIME NOT NULL,
  `movie_genre` VARCHAR(45) NOT NULL,
  `movie_language` VARCHAR(45) NOT NULL,
  `movie_actor` VARCHAR(45) NOT NULL,
  `movie_director` VARCHAR(45) NOT NULL,
  `movie_subtitle` TINYINT NOT NULL,
  `movie_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was modified',
  `movie_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was created',
  `movie_movie_price_facor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`movie_id`))
ENGINE = InnoDB;

CREATE INDEX `idx_title` ON `cinema`.`movie` (`movie_title` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cinema`.`operator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`operator` ;

CREATE TABLE IF NOT EXISTS `cinema`.`operator` (
  `operator_id` INT NOT NULL AUTO_INCREMENT,
  `operator_last_name` VARCHAR(45) NULL,
  `operator_first_name` VARCHAR(45) NULL,
  `operator_personal_number` VARCHAR(45) NULL,
  `operator_zip` VARCHAR(45) NULL,
  `operator_city` VARCHAR(45) NULL,
  `operator_address` VARCHAR(45) NULL,
  `operator_email` VARCHAR(45) NULL,
  `operator_phone_number` VARCHAR(45) NULL,
  PRIMARY KEY (`operator_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`show`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`show` ;

CREATE TABLE IF NOT EXISTS `cinema`.`show` (
  `show_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `show_date` DATE NULL,
  `show_time` TIME NULL,
  `show_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was modified',
  `show_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp when this record was created',
  `cinema_cinema_id` INT NOT NULL,
  `film_film_id` INT NOT NULL,
  `operator_operator_id` INT NOT NULL,
  `movie_movie_id` INT NOT NULL,
  PRIMARY KEY (`show_id`),
  CONSTRAINT `fk_show_cinema`
    FOREIGN KEY (`cinema_cinema_id`)
    REFERENCES `cinema`.`cinema` (`cinema_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_show_operator1`
    FOREIGN KEY (`operator_operator_id`)
    REFERENCES `cinema`.`operator` (`operator_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_show_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `cinema`.`movie` (`movie_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_show_cinema_idx` ON `cinema`.`show` (`cinema_cinema_id` ASC) VISIBLE;

CREATE INDEX `fk_show_operator1_idx` ON `cinema`.`show` (`operator_operator_id` ASC) VISIBLE;

CREATE INDEX `fk_show_movie1_idx` ON `cinema`.`show` (`movie_movie_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cinema`.`seat_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`seat_category` ;

CREATE TABLE IF NOT EXISTS `cinema`.`seat_category` (
  `seat_category_id` INT NOT NULL AUTO_INCREMENT,
  `seat_category_description` VARCHAR(45) NULL,
  `seat_category_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `seat_category_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `seat_category_price_factor` VARCHAR(45) NULL,
  PRIMARY KEY (`seat_category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`seat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`seat` ;

CREATE TABLE IF NOT EXISTS `cinema`.`seat` (
  `seat_number` VARCHAR(45) NULL,
  `seat_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `seat_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `seat_category_seat_category_id` INT NOT NULL,
  `cinema_cinema_id` INT NOT NULL,
  PRIMARY KEY (`seat_category_seat_category_id`, `cinema_cinema_id`),
  CONSTRAINT `fk_seat_seat_category1`
    FOREIGN KEY (`seat_category_seat_category_id`)
    REFERENCES `cinema`.`seat_category` (`seat_category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_seat_cinema1`
    FOREIGN KEY (`cinema_cinema_id`)
    REFERENCES `cinema`.`cinema` (`cinema_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_seat_seat_category1_idx` ON `cinema`.`seat` (`seat_category_seat_category_id` ASC) VISIBLE;

CREATE INDEX `fk_seat_cinema1_idx` ON `cinema`.`seat` (`cinema_cinema_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cinema`.`movie_format`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`movie_format` ;

CREATE TABLE IF NOT EXISTS `cinema`.`movie_format` (
  `movie_format_id` INT NOT NULL AUTO_INCREMENT,
  `movie_format_width` VARCHAR(5) NULL,
  `movie_format_height` VARCHAR(5) NULL,
  `movie_format_edited` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `movie_format_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`movie_format_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`cinema_movie_format`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`cinema_movie_format` ;

CREATE TABLE IF NOT EXISTS `cinema`.`cinema_movie_format` (
  `cinema_movie_format_id` INT UNSIGNED NOT NULL,
  `cinema_movie_format_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cinema_movie_format_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cinema_cinema_id` INT NOT NULL,
  `movie_format_movie_format_id` INT NOT NULL,
  PRIMARY KEY (`cinema_movie_format_id`),
  CONSTRAINT `fk_cinema_movie_format_cinema1`
    FOREIGN KEY (`cinema_cinema_id`)
    REFERENCES `cinema`.`cinema` (`cinema_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cinema_movie_format_movie_format1`
    FOREIGN KEY (`movie_format_movie_format_id`)
    REFERENCES `cinema`.`movie_format` (`movie_format_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_cinema_movie_format_cinema1_idx` ON `cinema`.`cinema_movie_format` (`cinema_cinema_id` ASC) VISIBLE;

CREATE INDEX `fk_cinema_movie_format_movie_format1_idx` ON `cinema`.`cinema_movie_format` (`movie_format_movie_format_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cinema`.`movie_movie_format`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`movie_movie_format` ;

CREATE TABLE IF NOT EXISTS `cinema`.`movie_movie_format` (
  `movie_movie_format_id` INT NOT NULL AUTO_INCREMENT,
  `movie_movie_format_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `movie_movie_format_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `movie_format_movie_format_id` INT NOT NULL,
  `movie_movie_id` INT NOT NULL,
  PRIMARY KEY (`movie_movie_format_id`),
  CONSTRAINT `fk_movie_movie_format_movie_format1`
    FOREIGN KEY (`movie_format_movie_format_id`)
    REFERENCES `cinema`.`movie_format` (`movie_format_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_movie_movie_format_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `cinema`.`movie` (`movie_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_movie_movie_format_movie_format1_idx` ON `cinema`.`movie_movie_format` (`movie_format_movie_format_id` ASC) VISIBLE;

CREATE INDEX `fk_movie_movie_format_movie1_idx` ON `cinema`.`movie_movie_format` (`movie_movie_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cinema`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`customer` ;

CREATE TABLE IF NOT EXISTS `cinema`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_last_name` VARCHAR(45) NULL,
  `customer_first_name` VARCHAR(45) NULL,
  `customer_email` VARCHAR(45) NULL,
  `customer_zip` VARCHAR(45) NULL,
  `customer_address` VARCHAR(45) NULL,
  `customer_phone` VARCHAR(45) NULL,
  `customer_newsletter` VARCHAR(45) NULL,
  `customer_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cinema`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`order` ;

CREATE TABLE IF NOT EXISTS `cinema`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `order_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `customer_customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`customer_customer_id`)
    REFERENCES `cinema`.`customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_order_customer1_idx` ON `cinema`.`order` (`customer_customer_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cinema`.`ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cinema`.`ticket` ;

CREATE TABLE IF NOT EXISTS `cinema`.`ticket` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `ticket_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ticket_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `ticket_reservation` VARCHAR(45) NULL,
  `ticket_base_price` VARCHAR(45) NULL,
  `ticket_reservation_time_price` VARCHAR(45) NULL,
  `order_order_id` INT NOT NULL,
  `seat_seat_category_seat_category_id` INT NOT NULL,
  `seat_cinema_cinema_id` INT NOT NULL,
  `show_show_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ticket_id`),
  CONSTRAINT `fk_ticket_order1`
    FOREIGN KEY (`order_order_id`)
    REFERENCES `cinema`.`order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ticket_seat1`
    FOREIGN KEY (`seat_seat_category_seat_category_id` , `seat_cinema_cinema_id`)
    REFERENCES `cinema`.`seat` (`seat_category_seat_category_id` , `cinema_cinema_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ticket_show1`
    FOREIGN KEY (`show_show_id`)
    REFERENCES `cinema`.`show` (`show_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_ticket_order1_idx` ON `cinema`.`ticket` (`order_order_id` ASC) VISIBLE;

CREATE INDEX `fk_ticket_seat1_idx` ON `cinema`.`ticket` (`seat_seat_category_seat_category_id` ASC, `seat_cinema_cinema_id` ASC) VISIBLE;

CREATE INDEX `fk_ticket_show1_idx` ON `cinema`.`ticket` (`show_show_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
