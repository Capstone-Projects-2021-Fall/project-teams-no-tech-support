DROP DATABASE IF EXISTS NoTechSupport;
CREATE DATABASE NoTechSupport;
USE NoTechSupport;


-- Creating Device table
CREATE TABLE Device (
  id                    		  int AUTO_INCREMENT,
  name                            varchar(50) NOT NULL,
  PRIMARY Key (id)
);


-- Creating Brand table
CREATE TABLE Brand (
  id                    		  int AUTO_INCREMENT,
  device_id                       int NOT NULL,
  tech_support_number             int NOT NULL,
  FOREIGN KEY (device_id) REFERENCES Device(id),
  PRIMARY Key (id)
);


-- Creating Model table
CREATE TABLE Model (
  id                    		  int AUTO_INCREMENT,
  brand_id                        int NOT NULL,
  name                            varchar(50),
  year                            varchar(4),
  FOREIGN KEY (brand_id) REFERENCES Brand(id),
  PRIMARY Key (id)
);

-- Creating Domains table
CREATE TABLE Domains (
  id                    		  int AUTO_INCREMENT,
  name                            varchar(50) NOT NULL,
  is_certified                    bit NOT NULL,
  likes                           int NOT NULL,
  PRIMARY Key (id)
);