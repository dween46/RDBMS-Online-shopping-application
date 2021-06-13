-- creator 
-- DEEN MOHAMMAD
-- created : 13/6/2021

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema online_shopping_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema online_shopping_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `online_shopping_DB` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `online_shopping_DB` ;

-- -----------------------------------------------------
-- Table `online_shopping_DB`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_DB`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `age` INT NOT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_DB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_DB`.`orders` (
  `order_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `customer_payment_method` VARCHAR(45) NULL,
  `date_order_placed` DATE NULL,
  `date_order_paid` DATE NULL,
  `order_price` INT NULL,
  `order_details` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fk_orders_customers1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `online_shopping_DB`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_DB`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_DB`.`suppliers` (
  `supplier_id` INT NOT NULL,
  `supplier_name` VARCHAR(45) NOT NULL,
  `supplier_branch_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_DB`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_DB`.`product_category` (
  `product_category_id` INT NOT NULL AUTO_INCREMENT,
  `product_category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_DB`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_DB`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_category_id` INT NOT NULL,
  `product_title` VARCHAR(45) NOT NULL,
  `product_supplier_id` INT NOT NULL,
  `product_description` VARCHAR(45) NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_supplier_idx` (`product_supplier_id` ASC) VISIBLE,
  INDEX `fk_product_category_idx` (`product_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_supplier`
    FOREIGN KEY (`product_supplier_id`)
    REFERENCES `online_shopping_DB`.`suppliers` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`product_category_id`)
    REFERENCES `online_shopping_DB`.`product_category` (`product_category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_DB`.`order_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_DB`.`order_product` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NULL DEFAULT 1,
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `fk_product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `online_shopping_DB`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `online_shopping_DB`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_DB`.`customer_payment_methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_DB`.`customer_payment_methods` (
  `customer_payment_method_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL,
  `payment_method_code` INT NULL,
  `card_number` INT NULL,
  `expiry_date` DATE NULL,
  PRIMARY KEY (`customer_payment_method_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_DB`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_DB`.`addresses` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL,
  `line_1` VARCHAR(45) NULL DEFAULT NULL,
  `line_2` VARCHAR(45) NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_DB`.`customer_addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_DB`.`customer_addresses` (
  `customer_address_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `date_to` DATE NULL,
  PRIMARY KEY (`customer_address_id`),
  UNIQUE INDEX `customer_address_id_UNIQUE` (`customer_address_id` ASC) VISIBLE,
  INDEX `customer_id_idx` (`customer_id` ASC) VISIBLE,
  INDEX `address_id_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `online_shopping_DB`.`customers` (`customer_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `online_shopping_DB`.`addresses` (`address_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_DB`.`product_prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_DB`.`product_prices` (
  `product_id` INT NOT NULL,
  `date_from` DATE NOT NULL,
  `product_price` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `fk_product_price`
    FOREIGN KEY (`product_id`)
    REFERENCES `online_shopping_DB`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`addresses` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `state` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `line_1` VARCHAR(45) NULL DEFAULT NULL,
  `line_2` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`customer_payment_methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer_payment_methods` (
  `customer_payment_method_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL DEFAULT NULL,
  `payment_method_code` INT NULL DEFAULT NULL,
  `card_number` INT NULL DEFAULT NULL,
  `expiry_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`customer_payment_method_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `age` INT NOT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `order_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `customer_payment_method` VARCHAR(45) NULL DEFAULT NULL,
  `date_order_placed` DATE NULL DEFAULT NULL,
  `date_order_paid` DATE NULL DEFAULT NULL,
  `order_price` INT NULL DEFAULT NULL,
  `order_details` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fk_orders_customers1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customers` (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product_category` (
  `product_category_id` INT NOT NULL AUTO_INCREMENT,
  `product_category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`suppliers` (
  `supplier_id` INT NOT NULL,
  `supplier_name` VARCHAR(45) NOT NULL,
  `supplier_branch_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_category_id` INT NOT NULL,
  `product_title` VARCHAR(45) NOT NULL,
  `product_supplier_id` INT NOT NULL,
  `product_description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_supplier_idx` (`product_supplier_id` ASC) VISIBLE,
  INDEX `fk_product_category_idx` (`product_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`product_category_id`)
    REFERENCES `mydb`.`product_category` (`product_category_id`),
  CONSTRAINT `fk_product_supplier`
    FOREIGN KEY (`product_supplier_id`)
    REFERENCES `mydb`.`suppliers` (`supplier_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`order_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_product` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NULL DEFAULT '1',
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `fk_product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`orders` (`order_id`),
  CONSTRAINT `fk_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`products` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
