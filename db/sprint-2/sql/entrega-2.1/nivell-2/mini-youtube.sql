-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema mini_youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mini_youtube` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mini_youtube` ;

-- -----------------------------------------------------
-- Table `mini_youtube`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(90) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `birth_date` DATETIME NULL,
  `gender` ENUM('male', 'female', 'other') NULL,
  `postal_code` VARCHAR(20) NULL,
  `country` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_youtube`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`videos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(225) NULL,
  `status` ENUM('private', 'public', 'hidden') NULL,
  `file_size` VARCHAR(20) NULL,
  `file_name` VARCHAR(255) NULL,
  `video_length` INT NULL,
  `thumbnail` BLOB NULL,
  `click_count` BIGINT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_videos_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_videos_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_youtube`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`tag` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_youtube`.`channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`channel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_channel_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_channel_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_youtube`.`videos_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`videos_tags` (
  `videos_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`videos_id`, `tag_id`),
  INDEX `fk_videos_has_tag_tag1_idx` (`tag_id` ASC) VISIBLE,
  INDEX `fk_videos_has_tag_videos1_idx` (`videos_id` ASC) VISIBLE,
  CONSTRAINT `fk_videos_has_tag_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `mini_youtube`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_has_tag_tag1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `mini_youtube`.`tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_youtube`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  `videos_user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`, `videos_user_id`),
  INDEX `fk_comment_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_comment_videos1_idx` (`videos_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_videos1`
    FOREIGN KEY (`videos_user_id`)
    REFERENCES `mini_youtube`.`videos` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_youtube`.`user_suscribes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`user_suscribes` (
  `channel_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`channel_id`, `user_id`),
  INDEX `fk_channel_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_channel_has_user_channel1_idx` (`channel_id` ASC) VISIBLE,
  CONSTRAINT `fk_channel_has_user_channel1`
    FOREIGN KEY (`channel_id`)
    REFERENCES `mini_youtube`.`channel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_channel_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_youtube`.`user_reacts_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`user_reacts_video` (
  `user_id` INT NOT NULL,
  `videos_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`user_id`, `videos_id`),
  INDEX `fk_user_has_videos_videos1_idx` (`videos_id` ASC) VISIBLE,
  INDEX `fk_user_has_videos_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_videos_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_videos_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `mini_youtube`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `status` ENUM('public', 'private') NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_playlist_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_youtube`.`playlist_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`playlist_videos` (
  `playlist_id` INT NOT NULL,
  `videos_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`, `videos_id`),
  INDEX `fk_playlist_has_videos_videos1_idx` (`videos_id` ASC) VISIBLE,
  INDEX `fk_playlist_has_videos_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_has_videos_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `mini_youtube`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_has_videos_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `mini_youtube`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_youtube`.`user_reacts_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_youtube`.`user_reacts_comment` (
  `comment_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`comment_id`, `user_id`),
  INDEX `fk_comment_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_comment_has_user_comment1_idx` (`comment_id` ASC) VISIBLE,
  CONSTRAINT `fk_comment_has_user_comment1`
    FOREIGN KEY (`comment_id`)
    REFERENCES `mini_youtube`.`comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_youtube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
