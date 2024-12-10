-- -----------------------------------------------------
-- Schema VENDASDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `VENDASDB` ;
USE `VENDASDB` ;

-- -----------------------------------------------------
-- Table `VENDASDB`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VENDASDB`.`supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `companyname` VARCHAR(40) NULL,
  `contactname` VARCHAR(50) NULL,
  `contacttitle` VARCHAR(40) NULL,
  `city` VARCHAR(40) NULL,
  `country` VARCHAR(40) NULL,
  `phone` VARCHAR(30) NULL,
  `fax` VARCHAR(30) NULL,
  PRIMARY KEY (`id`)
);

-- -----------------------------------------------------
-- Table `VENDASDB`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VENDASDB`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `productname` VARCHAR(50) NULL,
  `supplierid` INT NOT NULL,
  `unitprice` DECIMAL(12,2) NULL,
  `package` VARCHAR(30) NULL,
  `isdiscontinued` BIT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_supplier1_idx` (`supplierid` ASC),
  CONSTRAINT `fk_product_supplier1`
    FOREIGN KEY (`supplierid`)
    REFERENCES `VENDASDB`.`supplier` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

-- -----------------------------------------------------
-- Table `VENDASDB`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VENDASDB`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(40) NULL,
  `lastname` VARCHAR(40) NULL,
  `city` VARCHAR(40) NULL,
  `country` VARCHAR(40) NULL,
  `phone` VARCHAR(20) NULL,
  PRIMARY KEY (`id`)
);

-- -----------------------------------------------------
-- Table `VENDASDB`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VENDASDB`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `orderdate` DATETIME NULL,
  `ordernumber` VARCHAR(10) NULL,
  `customerid` INT NOT NULL,
  `totalamount` DECIMAL(12,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_customer1_idx` (`customerid` ASC),
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`customerid`)
    REFERENCES `VENDASDB`.`customer` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

-- -----------------------------------------------------
-- Table `VENDASDB`.`orderitem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VENDASDB`.`orderitem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `orderid` INT NOT NULL,
  `productid` INT NOT NULL,
  `unitprice` DECIMAL(12,2) NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orderitem_product1_idx` (`productid` ASC),
  INDEX `fk_orderitem_order1_idx` (`orderid` ASC),
  CONSTRAINT `fk_orderitem_product1`
    FOREIGN KEY (`productid`)
    REFERENCES `VENDASDB`.`product` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_orderitem_order1`
    FOREIGN KEY (`orderid`)
    REFERENCES `VENDASDB`.`order` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);
