-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-06-01 20:03:14.551

-- tables
-- Table: Company
CREATE TABLE Company (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(64) NOT NULL,
    address varchar(255) NOT NULL,
    city_id int NOT NULL,
    CONSTRAINT Company_pk PRIMARY KEY (id)
);

-- Table: HS_Codes_2_digit
CREATE TABLE HS_Codes_2_digit (
    code int NOT NULL AUTO_INCREMENT,
    description varchar(255) NOT NULL,
    CONSTRAINT HS_Codes_2_digit_pk PRIMARY KEY (code)
);

-- Table: HS_Codes_4_digit
CREATE TABLE HS_Codes_4_digit (
    code int NOT NULL AUTO_INCREMENT,
    description varchar(64) NOT NULL,
    CONSTRAINT HS_Codes_4_digit_pk PRIMARY KEY (code)
) COMMENT 'e.g. card, cash, paypal, wire transfer';

-- Table: Port
CREATE TABLE Port (
    id int NOT NULL,
    Name varchar(30) NOT NULL,
    City int NOT NULL,
    Country_ID varchar(30) NOT NULL,
    city_id int NOT NULL,
    CONSTRAINT Port_pk PRIMARY KEY (id)
);

-- Table: Shipping_Line
CREATE TABLE Shipping_Line (
    id int NOT NULL,
    name varchar(60) NOT NULL,
    CONSTRAINT Shipping_Line_pk PRIMARY KEY (id)
);

-- Table: Vessel
CREATE TABLE Vessel (
    id int NOT NULL,
    name varchar(60) NOT NULL,
    Shipping_Line_id int NOT NULL,
    Shipping_Line_2_id int NOT NULL,
    CONSTRAINT Vessel_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(128) NOT NULL,
    state varchar(30) NOT NULL,
    country_id int NOT NULL,
    country_name int NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: commodity
CREATE TABLE commodity (
    code int NOT NULL AUTO_INCREMENT,
    Type varchar(255) NOT NULL,
    Description varchar(255) NOT NULL,
    UNIQUE INDEX payment_data_ak_1 (Type),
    CONSTRAINT commodity_pk PRIMARY KEY (code)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(128) NOT NULL,
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: shipment
CREATE TABLE shipment (
    id int NOT NULL AUTO_INCREMENT,
    time_created timestamp NOT NULL,
    Month int NOT NULL,
    Date date NOT NULL,
    Initial_Port_ID int NOT NULL,
    Ultimate_Port_ID int NOT NULL,
    Reefer bool NOT NULL,
    Hazmat bool NOT NULL,
    Voyage varchar(6) NOT NULL,
    Quantity_and_Units int NOT NULL,
    UOM char(3) NOT NULL,
    Value int NOT NULL,
    TEUS decimal(2,2) NOT NULL,
    Container_Size char(2) NOT NULL,
    SHIPMENTCOUNT int NOT NULL,
    Canada_Company_id int NOT NULL,
    Vessel_id int NOT NULL,
    commodity_id int NOT NULL,
    HS_Codes_2_digit_id int NOT NULL,
    HS_Codes_4_digit_id int NOT NULL,
    Foreign_Company_id int NOT NULL,
    UNIQUE INDEX Initial_Port_ID (Initial_Port_ID),
    UNIQUE INDEX Ultimate_Port_ID (Ultimate_Port_ID),
    CONSTRAINT shipment_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Canada_Company_city (table: Company)
ALTER TABLE Company ADD CONSTRAINT Canada_Company_city FOREIGN KEY Canada_Company_city (city_id)
    REFERENCES city (id);

-- Reference: Port_city (table: Port)
ALTER TABLE Port ADD CONSTRAINT Port_city FOREIGN KEY Port_city (city_id)
    REFERENCES city (id);

-- Reference: Vessel_Shipping_Line (table: Vessel)
ALTER TABLE Vessel ADD CONSTRAINT Vessel_Shipping_Line FOREIGN KEY Vessel_Shipping_Line (Shipping_Line_2_id)
    REFERENCES Shipping_Line (id);

-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: shipment_Company_Can (table: shipment)
ALTER TABLE shipment ADD CONSTRAINT shipment_Company_Can FOREIGN KEY shipment_Company_Can (Foreign_Company_id)
    REFERENCES Company (id);

-- Reference: shipment_Company_For (table: shipment)
ALTER TABLE shipment ADD CONSTRAINT shipment_Company_For FOREIGN KEY shipment_Company_For (Canada_Company_id)
    REFERENCES Company (id);

-- Reference: shipment_HS_Codes_2_digit (table: shipment)
ALTER TABLE shipment ADD CONSTRAINT shipment_HS_Codes_2_digit FOREIGN KEY shipment_HS_Codes_2_digit (HS_Codes_2_digit_id)
    REFERENCES HS_Codes_2_digit (code);

-- Reference: shipment_HS_Codes_4_digit (table: shipment)
ALTER TABLE shipment ADD CONSTRAINT shipment_HS_Codes_4_digit FOREIGN KEY shipment_HS_Codes_4_digit (HS_Codes_4_digit_id)
    REFERENCES HS_Codes_4_digit (code);

-- Reference: shipment_Port_In (table: shipment)
ALTER TABLE shipment ADD CONSTRAINT shipment_Port_In FOREIGN KEY shipment_Port_In (Initial_Port_ID)
    REFERENCES Port (id);

-- Reference: shipment_Port_Ul (table: shipment)
ALTER TABLE shipment ADD CONSTRAINT shipment_Port_Ul FOREIGN KEY shipment_Port_Ul (Ultimate_Port_ID)
    REFERENCES Port (id);

-- Reference: shipment_Vessel (table: shipment)
ALTER TABLE shipment ADD CONSTRAINT shipment_Vessel FOREIGN KEY shipment_Vessel (Vessel_id)
    REFERENCES Vessel (id);

-- Reference: shipment_commodity (table: shipment)
ALTER TABLE shipment ADD CONSTRAINT shipment_commodity FOREIGN KEY shipment_commodity (commodity_id)
    REFERENCES commodity (code);

-- End of file.

