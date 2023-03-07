-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `floor` INT NULL DEFAULT NULL,
  `door` VARCHAR(5) NULL DEFAULT NULL,
  `postal_code` VARCHAR(20) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cif` VARCHAR(9) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `tel` VARCHAR(20) NOT NULL,
  `fax` VARCHAR(20) NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`, `cif`, `address_id`),
  UNIQUE INDEX `cif_UNIQUE` (`cif` ASC) VISIBLE,
  INDEX `fk_supplier_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `optica`.`address` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`brand` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `supplier_id` INT NOT NULL,
  PRIMARY KEY (`id`, `supplier_id`),
  INDEX `fk_brand_supplier1_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_brand_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `optica`.`supplier` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `tel` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `invited_by` INT NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`, `invited_by`, `address_id`),
  INDEX `fk_customer_customer1_idx` (`invited_by` ASC) VISIBLE,
  INDEX `fk_customer_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `optica`.`address` (`id`),
  CONSTRAINT `fk_customer_customer1`
    FOREIGN KEY (`invited_by`)
    REFERENCES `optica`.`customer` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`glasses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `left_glass_grade` DECIMAL(10,2) NOT NULL,
  `right_glass_grade` DECIMAL(10,2) NOT NULL,
  `base_type` ENUM('plastic', 'metal', 'mixed') NOT NULL,
  `base_color` VARCHAR(20) NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `left_glass_color` VARCHAR(20) NULL DEFAULT NULL,
  `right_glass_color` VARCHAR(20) NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `brand_id` INT NOT NULL,
  PRIMARY KEY (`id`, `brand_id`),
  INDEX `fk_glasses_copy1_brand_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_copy1_brand`
    FOREIGN KEY (`brand_id`)
    REFERENCES `optica`.`brand` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica`.`sell`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`sell` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `glasses_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `customer_id`, `glasses_id`, `employee_id`),
  INDEX `fk_employee_has_glasses_glasses1_idx` (`glasses_id` ASC) VISIBLE,
  INDEX `fk_employee_has_glasses_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_sell_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_has_glasses_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `optica`.`employee` (`id`),
  CONSTRAINT `fk_employee_has_glasses_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `optica`.`glasses` (`id`),
  CONSTRAINT `fk_sell_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `optica`.`customer` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


/*************** INSERTS *****************/
insert into employee (name) values ('John');
insert into employee (name) values ('Marie');

insert into address (street,number,postal_code,city,country)
values('Manso',12,'a-312','Lahore','Uganda'),
('Peracamps',121,'312','Pekas','Nigeria'),
('Larav',22,'223-22','Pundit','India');

insert into supplier(cif,name,tel,address_id) values('12345678Z','RayBeri','0088-017181678',2);
insert into customer(name, tel, invited_by, address_id) values ('Rarem','946123842',1,1);

insert into brand(name, supplier_id) values ('RayBan', 1);
insert into glasses(left_glass_grade, right_glass_grade, base_type, price, brand_id ) values (3.16, 4.55, 'mixed', 222.99, 1);
insert into sell(employee_id, customer_id, glasses_id) values(1,1,1);

/************** CONSULTES **************/
/*Llista el total de compres d’un client/a.*/
select count(*)
from sell s inner join customer c on s.customer_id=c.id
where c.id = 1
/*Llista les diferents ulleres que ha venut un empleat durant un any.*/
select distinct g.*
from glasses g inner join sell s on g.id=s.glasses_id
inner join employee e on e.id = s.employee_id
where e.id = 1
/*Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.*/
select distinct sr.*
from supplier sr inner join brand b on sr.id=b.supplier_id
inner join glasses g on b.id = g.brand_id
inner join sell s on s.glasses_id=g.id