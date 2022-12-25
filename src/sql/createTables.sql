-- Drop table CUSTOMER
DROP TABLE IF EXISTS CUSTOMER;
-- Create table CUSTOMER
CREATE TABLE CUSTOMER (
    cus_code int AUTO_INCREMENT,
    cus_lname varchar(20) NOT null,
    cus_fname varchar(20) NOT null,
    cus_gender tinyint(1) NOT null,
    cus_initial char(1),
    cus_areacode varchar(10) NOT null,
    cus_phone varchar(20) NOT null,
    cus_balance float DEFAULT 0 NOT null,
    PRIMARY KEY(cus_code)
);
--
--
-- Drop table VENDOR
DROP TABLE IF EXISTS VENDOR;
-- Create table VENDOR
CREATE TABLE VENDOR(
    v_code int AUTO_INCREMENT,
    v_name varchar(50) NOT null,
    v_contact varchar(25) NOT null,
    v_areacode varchar(3) NOT null,
    v_phone varchar(20) NOT null,
    v_state varchar(2) NOT null,
    v_order tinyint(1) NOT null,
    PRIMARY KEY(v_code)
);
--
--
-- Drop table PRODUCT
DROP TABLE IF EXISTS PRODUCT;
-- Create table PRODUCT
CREATE TABLE PRODUCT (
    p_code varchar(15),
    p_desc text NOT null,
    p_indate date NOT null,
    p_qoh int DEFAULT 0 NOT null,
    p_min int DEFAULT 1 NOT null,
    p_price float NOT null,
    p_discount float,
    p_min_order int DEFAULT 1 NOT null,
    p_reorder int DEFAULT 0 NOT null,
    p_name varchar(200) NOT null,
    v_code int,
    FOREIGN KEY(v_code) REFERENCES VENDOR(v_code),
    PRIMARY KEY(p_code)
);
-- 
-- 
-- Drop table INVOICE
DROP TABLE IF EXISTS INVOICE;
-- Create table INVOICE
CREATE TABLE INVOICE(
    inv_number char(15),
    cus_code int,
    inv_date date,
    inv_subtotal float,
    inv_tax float,
    inv_total float,
    inv_pay_type varchar(10),
    inv_pay_amount float(8),
    inv_shipping_cost float(8),
    inv_balance float(8),
    FOREIGN KEY(cus_code) REFERENCES CUSTOMER(cus_code),
    PRIMARY KEY(inv_number)
);
--
--
-- Drop table ACCT_TRANSACTION
DROP TABLE IF EXISTS ACCT_TRANSACTION;
-- Create table ACCT_TRANSACTION
CREATE TABLE ACCT_TRANSACTION(
    acct_trans_code int AUTO_INCREMENT NOT null,
    acct_trans_date date NOT null,
    acct_trans_type varchar(8) NOT null,
    acct_trans_amount float(8) NOT null,
    cus_code int,
    FOREIGN KEY(cus_code) REFERENCES CUSTOMER(cus_code),
    PRIMARY KEY(acct_trans_code)
);
--
-- 
-- Drop table LINE
DROP TABLE IF EXISTS LINE;
-- Create table LINE
CREATE TABLE LINE(
    inv_number char(15),
    line_number int,
    p_code varchar(15),
    line_units float,
    line_price float,
    line_total float,
    FOREIGN KEY(p_code) REFERENCES PRODUCT(p_code),
    FOREIGN KEY(inv_number) REFERENCES INVOICE(inv_number),
    PRIMARY KEY(inv_number, line_number)
);
-- 
-- 
-- Auto increment line_number
DELIMITER $$ 
CREATE TRIGGER line_number_increment BEFORE
INSERT ON LINE FOR EACH ROW BEGIN
SET NEW.line_number = (
        SELECT COALESCE(MAX(line_number), 0)
        FROM LINE
        WHERE inv_number = NEW.inv_number
    ) + 1;
END $$ 
DELIMITER;