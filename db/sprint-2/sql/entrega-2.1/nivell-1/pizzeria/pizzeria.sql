-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb3 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `floor` INT NULL DEFAULT NULL,
  `door` VARCHAR(5) NULL DEFAULT NULL,
  `postal_code` VARCHAR(20) NULL DEFAULT NULL,
  `town` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NULL DEFAULT NULL,
  `tel` VARCHAR(20) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`, `address_id`),
  INDEX `fk_customer_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `pizzeria`.`address` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`store` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`, `address_id`),
  INDEX `fk_store_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_store_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `pizzeria`.`address` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NULL DEFAULT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `tel` VARCHAR(20) NOT NULL,
  `type` ENUM('kitchen', 'delivery') NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `store_id` INT NOT NULL,
  PRIMARY KEY (`id`, `store_id`),
  INDEX `fk_employee_store1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `pizzeria`.`store` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM('delivery', 'collect') NOT NULL,
  `total_price` DECIMAL(5,2) NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `customer_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `delivered_by` INT NOT NULL,
  PRIMARY KEY (`id`, `customer_id`, `store_id`, `delivered_by`),
  INDEX `fk_order_customer_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_order_store1_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_order_employee1_idx` (`delivered_by` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `pizzeria`.`customer` (`id`),
  CONSTRAINT `fk_order_employee1`
    FOREIGN KEY (`delivered_by`)
    REFERENCES `pizzeria`.`employee` (`id`),
  CONSTRAINT `fk_order_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `pizzeria`.`store` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `image` BLOB NULL DEFAULT NULL,
  `type` ENUM('drinks','burguers','pizza') NOT NULL,
  `description` TEXT NOT NULL,
  `price` DECIMAL(5,2) NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `category_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `pizzeria`.`category` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `pizzeria`.`ordered_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`ordered_products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`, `order_id`, `product_id`),
  INDEX `fk_order_has_product_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_order_has_product_order1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_has_product_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizzeria`.`order` (`id`),
  CONSTRAINT `fk_order_has_product_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pizzeria`.`product` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/************ INSERTS ****************************/

insert into address (street,number,postal_code,town,province)
values('Manso',12,'08005','Badalona','Barcelona'),
('Peracamps',121,'08015','Hospitalet','Barcelona'),
('Larav',22,'223-22','Sant-Cugat','Barcelona');

insert into product (name, type, description) values("cola", "drinks","beguda amb gas");

insert into customer (name, tel,address_id) values ("Nozar","612342391", 4);

insert into store (address_id) values (5);

insert into employee (name, nif, tel, type, store_id) values ("Maria", "12345678z","6781238119","delivery",1);

insert into `order` (type,customer_id,store_id,delivered_by) values ("delivery",2,1,1);

insert into ordered_products (product_id,order_id) values(1,2)

/**********QUERIES**************/
/*Llista quants productes de tipus “Begudes”. s'han venut en una determinada localitat.*/
select count(*)
from product p inner join ordered_products op on p.id=op.product_id
inner join `order` o on o.id=op.order_id
inner join customer c on c.id=o.customer_id
inner join address a on a.id=c.address_id
where p.type = 'drinks' and a.town ='Badalona'

/****Llista quantes comandes ha efectuat un determinat empleat/da.***/
select count(*)
from employee e inner join `order` o on e.id=o.delivered_by
where e.nif = '12345678z'