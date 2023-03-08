-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mini_spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mini_spotify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mini_spotify` ;

-- -----------------------------------------------------
-- Table `mini_spotify`.`suscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`suscription` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `plan` ENUM('free', 'premium') NOT NULL,
  `payment_type` ENUM('card', 'paypal') NULL,
  `start_date` DATETIME NOT NULL,
  `unsubscribe_date` DATETIME NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`payment_paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`payment_paypal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `paypal_user_name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`payment_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`payment_card` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` INT NOT NULL,
  `expiry_month` INT NOT NULL,
  `expriy_year` INT NOT NULL,
  `security_code` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(90) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `birth_date` DATETIME NULL,
  `gender` ENUM('male', 'female', 'other') NULL,
  `postal_code` VARCHAR(20) NULL,
  `country` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `suscription_id` INT NOT NULL,
  `payment_paypal_id` INT NOT NULL,
  `payment_card_id` INT NOT NULL,
  PRIMARY KEY (`id`, `suscription_id`, `payment_paypal_id`, `payment_card_id`),
  INDEX `fk_user_suscription_idx` (`suscription_id` ASC) VISIBLE,
  INDEX `fk_user_payment_paypal1_idx` (`payment_paypal_id` ASC) VISIBLE,
  INDEX `fk_user_payment_card1_idx` (`payment_card_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_suscription`
    FOREIGN KEY (`suscription_id`)
    REFERENCES `mini_spotify`.`suscription` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_payment_paypal1`
    FOREIGN KEY (`payment_paypal_id`)
    REFERENCES `mini_spotify`.`payment_paypal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_payment_card1`
    FOREIGN KEY (`payment_card_id`)
    REFERENCES `mini_spotify`.`payment_card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NOT NULL,
  `order_number` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `suscription_id` INT NOT NULL,
  PRIMARY KEY (`id`, `suscription_id`),
  INDEX `fk_payment_suscription1_idx` (`suscription_id` ASC) VISIBLE,
  UNIQUE INDEX `order_number_UNIQUE` (`order_number` ASC) VISIBLE,
  CONSTRAINT `fk_payment_suscription1`
    FOREIGN KEY (`suscription_id`)
    REFERENCES `mini_spotify`.`suscription` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_playlist_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`artist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `image` BLOB NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `release_date` DATETIME NOT NULL,
  `image` BLOB NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`id`, `artist_id`),
  INDEX `fk_album_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `mini_spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`song` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `length` INT NOT NULL,
  `reproduced_times` BIGINT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`id`, `album_id`),
  INDEX `fk_song_album1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `mini_spotify`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`playlist_has_song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`playlist_has_song` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `playlist_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  `added_by` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`, `playlist_id`, `song_id`, `added_by`),
  INDEX `fk_playlist_has_song_song1_idx` (`song_id` ASC) VISIBLE,
  INDEX `fk_playlist_has_song_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_playlist_has_song_user1_idx` (`added_by` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_has_song_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `mini_spotify`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_has_song_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `mini_spotify`.`song` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_has_song_user1`
    FOREIGN KEY (`added_by`)
    REFERENCES `mini_spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`user_follows_artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`user_follows_artist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`, `user_id`, `artist_id`),
  INDEX `fk_artist_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_artist_has_user_artist1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_artist_has_user_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `mini_spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artist_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`user_favorite_song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`user_favorite_song` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`, `user_id`, `song_id`),
  INDEX `fk_song_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_song_has_user_song1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_has_user_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `mini_spotify`.`song` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_song_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_spotify`.`user_favorite_album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_spotify`.`user_favorite_album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`, `user_id`, `album_id`),
  INDEX `fk_album_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_album_has_user_album1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_has_user_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `mini_spotify`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_album_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
