
-- -----------------------------------------------------
-- 1.CREAR LAS TABLAS REQUERIDAS CON LAS RELACIONES NECESARIAS
-- -----------------------------------------------------

-- Schema Tienda
CREATE SCHEMA IF NOT EXISTS store DEFAULT CHARACTER SET utf8;
USE store;

-- Tabla cliente
CREATE TABLE IF NOT EXISTS client(
  cli_id INT NOT NULL AUTO_INCREMENT,
  card_type VARCHAR(10) NOT NULL,
  card_number VARCHAR(11) NOT NULL,
  delete_at DATETIME(0) NULL,
  PRIMARY KEY (cli_id),
  UNIQUE INDEX cli_id_UNIQUE (cli_id ASC) VISIBLE,
  UNIQUE INDEX card_number_UNIQUE (card_number ASC, card_type ASC) VISIBLE)
ENGINE = InnoDB;

-- Tabla proveedor
CREATE TABLE IF NOT EXISTS supplier(
  sup_id INT NOT NULL AUTO_INCREMENT,
  sup_name VARCHAR(45) NOT NULL,
  sup_phone VARCHAR(15) NOT NULL,
  delete_at DATETIME(0) NULL,
  PRIMARY KEY (sup_id),
  UNIQUE INDEX sup_id_UNIQUE (sup_id ASC) VISIBLE)
ENGINE = InnoDB;

-- Tabla producto
CREATE TABLE IF NOT EXISTS product(
  pro_id INT NOT NULL AUTO_INCREMENT,
  supplier_sup_id INT NOT NULL,
  pro_name VARCHAR(45) NOT NULL,
  pro_quantity INT NOT NULL,
  price DECIMAL(10,3) NOT NULL,
  delete_at DATETIME(0) NULL,
  PRIMARY KEY (pro_id),
  UNIQUE INDEX pro_id_UNIQUE (pro_id ASC) VISIBLE,
  INDEX fk_product_supplier_idx (supplier_sup_id ASC) VISIBLE,
  CONSTRAINT fk_product_supplier
    FOREIGN KEY (supplier_sup_id)
    REFERENCES supplier (sup_id)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Tabla ventas
CREATE TABLE IF NOT EXISTS sale(
  sal_id INT NOT NULL  AUTO_INCREMENT,
  client_cli_id INT NOT NULL,
  product_pro_id INT NOT NULL,
  sal_quantity INT NOT NULL,
  delete_at DATETIME(0) NULL,
  PRIMARY KEY (sal_id),
  UNIQUE INDEX sal_id_UNIQUE (sal_id ASC) VISIBLE,
  INDEX fk_client_has_product_product1_idx (product_pro_id ASC) VISIBLE,
  INDEX fk_client_has_product_client1_idx (client_cli_id ASC) VISIBLE,
  CONSTRAINT fk_client_has_product_client1
    FOREIGN KEY (client_cli_id)
    REFERENCES client (cli_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_client_has_product_product1
    FOREIGN KEY (product_pro_id)
    REFERENCES product (pro_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- 2.LLENAR LAS TABLAS CON INFORMACIÓN PREVIA PARA PODER MANIPULAR LA BASE DE DATOS A NIVEL DE DATOS.
-- -----------------------------------------------------

-- Insertar información en la tabla cliente (client)
INSERT INTO client (card_type, card_number)
VALUES('CC', '12341234');

INSERT INTO client (card_type, card_number)
VALUES('CC', '456456');

INSERT INTO client (card_type, card_number)
VALUES('CC', '789789');

INSERT INTO client (card_type, card_number)
VALUES('TI', '789789');

INSERT INTO client (card_type, card_number)
VALUES('CE', '123123');

-- Insertar información en la tabla proveedor (supplier)
INSERT INTO supplier (sup_name, sup_phone)
VALUES('La vaquita', '1231234');

INSERT INTO supplier (sup_name, sup_phonee)
VALUES('Soluciones', '456123');

INSERT INTO supplier (sup_name, sup_phone)
VALUES('Mundiales', '7894561');

INSERT INTO supplier (sup_name, sup_phone)
VALUES('Mercados', '3456789');

INSERT INTO supplier (sup_name, sup_phone)
VALUES('Alimentos', '9876541');

-- Insertar información en la tabla producto (product)

INSERT INTO product (supplier_sup_id, pro_name, pro_quantity, price)
VALUES(1, 'Arroz', 10, 3500);

INSERT INTO product (supplier_sup_id, pro_name, pro_quantity, price)
VALUES(2, 'Peras', 25, 1500);

INSERT INTO product (supplier_sup_id, pro_name, pro_quantity, price)
VALUES(1, 'lentejas', 15, 2700);

INSERT INTO product (supplier_sup_id, pro_name, pro_quantity, price)
VALUES(3, 'Zanahoria', 35, 1650);

INSERT INTO product (supplier_sup_id, pro_name, pro_quantity, price)
VALUES(5, 'Avena', 20, 7500);

-- Insertar información en la tabla ventas (sale)
INSERT INTO sale (client_cli_id,  product_pro_id , sal_quantity)
VALUES(1, 2, 3);

INSERT INTO sale (client_cli_id,  product_pro_id , sal_quantity)
VALUES(2, 3, 1);

INSERT INTO sale (client_cli_id,  product_pro_id , sal_quantity)
VALUES(3, 5, 2);

INSERT INTO sale (client_cli_id,  product_pro_id , sal_quantity)
VALUES(4, 4, 5);

INSERT INTO sale (client_cli_id,  product_pro_id , sal_quantity)
VALUES(5, 1, 4);


-- -----------------------------------------------------
-- 3.	REALIZAR DOS BORRADOS LÓGICOS Y DOS BORRADOS FÍSICOS DE VENTAS REALIZADAS.
-- -----------------------------------------------------

-- Borrados Físicos
DELETE FROM sale
WHERE sal_id= 3; 

DELETE FROM sale
WHERE sal_id= 2; 

-- Borrados lógicos 
UPDATE sale 
SET delete_at = now()
WHERE sal_id= 1;

UPDATE sale 
SET delete_at = now()
WHERE sal_id= 4;


-- -----------------------------------------------------
-- 4.	MODIFICAR TRES PRODUCTOS EN SU NOMBRE Y PROVEEDOR QUE LOS PROVEE.
-- -----------------------------------------------------

UPDATE product 
SET pro_name= "Banano", supplier_sup_id= 2
WHERE pro_id= 3;

UPDATE product 
SET pro_name= "Chía", supplier_sup_id= 5
WHERE pro_id= 1;

UPDATE product 
SET pro_name= "Caramelo", supplier_sup_id= 1
WHERE pro_id= 5;






