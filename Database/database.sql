DROP DATABASE IF EXISTS NoTechSupport;
CREATE DATABASE NoTechSupport;
USE NoTechSupport;


-- Creating Device table
CREATE TABLE Device (
  id                          int AUTO_INCREMENT,
  name                        varchar(50) NOT NULL,
  PRIMARY Key (id)
);

INSERT INTO Device (name) VALUES
("Computer"),
("Phone");

-- Creating Brand table
CREATE TABLE Brand (
  id                    		      int AUTO_INCREMENT,
  device_id                       int NOT NULL,
  name                            varchar(50) NOT NULL,
  tech_support_number             varchar(30) NOT NULL,
  FOREIGN KEY (device_id) REFERENCES Device(id),
  PRIMARY Key (id)
);

INSERT INTO Brand (device_id,name,tech_support_number) VALUES
(1, "Acer","1 (866) 695-2237"),
(1, "AGB ","1 (800) 356-6317"),
(1, "Alienware ","1 (877) 330-9732"),
(1, "Apple","1 (800) 692–7753"),
(1, "Asus","1 (888) 678-3688"),
(1, "BenQ ","1 (866) 600-2367"),
(1, "Bmax ","33 (811) 694-769"),
(1, "BOXX ","1 (512) 835-0400"),
(1, "Casper ","1 (888) 498-0003"),
(1, "CyberPowerPC ","1 (888) 900-5180"),
(1, "Dell","1 (800) 624-9897"),
(1, "Digital Storm ","1 (866) 817-8676"),
(1, "Durabook ","1 (800) 552-8946"),
(1, "Dynabook ","1 (800) 457-7777"),
(1, "Eluktronics ","1 (888) 552-0750"),
(1, "Epson ","1 (800) 463-7766"),
(1, "Evoo ","1 (877) 436-3866"),
(1, "Falcon Northwest ","1 (888) 800-7440"),
(1, "Fujitsu ","1 (888) 385-4878"),
(1, "Gateway ","1 (866) 695-2237"),
(1, "Gigabyte ","1 (626) 854-9338"),
(1, "Google","1 (866) 246-6453"),
(1, "HCL ","1 (408) 550-1505"),
(1, "HP","1 (888) 999-4747"),
(1, "HTC ","1 (866) 449-8358"),
(1, "Hyundai Technology ","1 (800) 560-0626 "),
(1, "IBM ","1 (877) 426-6006"),
(1, "Jumper ","86 (400) 833-3331"),
(1, "Lava International ","1 (860) 500-5001"),
(1, "Lenovo","1 (855) 253-6686 option #1"),
(1, "LG","1 (800) 243-0000"),
(1, "Microsoft","1 (800) 642-7676"),
(1, "Monster Notebook","1 (800) 666-7837"),
(1, "njoy ","1 (833) 275-6569"),
(1, "Onkyo ","1 (800) 229-1687"),
(1, "Optima ","1 (888) 867-8462"),
(1, "Origin PC ","1 (877) 674-4460"),
(1, "OverPowered ","1 (800) 379-3820"),
(1, "Panasonic ","1 (800) 211-7262"),
(1, "Philips ","1 (800) 722-9377"),
(1, "Razer","1 (855) 872-5233 "),
(1, "Realme ","1 (800) 102-2777"),
(1, "Sager Notebook computers ","1 (800) 741-2219"),
(1, "Samsung Electronics","1 (800) 726-7864"),
(1, "Sony VAIO ","1 (800) 433-5778"),
(1, "System76 ","1 (720) 226-9269"),
(1, "Toshiba ","1 (800) 457-7777"),
(1, "Velocity Micro ","1 (804) 419-0900"),
(1, "Xiaomi","1 (833) 942-6648"),
(1, "XMG ","49 (341) 246-7040"),
(1, "Xolo ","1 (860) 500-5001");

INSERT INTO Brand (device_id,name,tech_support_number) VALUES 
(2, "SAMSUNG","1 (800) 726-7864"),
(2, "APPLE","1 (800) 275–2273"),
(2, "HUAWEI","1 (877) 448-2934"),
(2, "NOKIA","1 (833) 766-5420"),
(2, "SONY","1 (800) 345-7669"),
(2, "LG","1 (800) 243-0000"),
(2, "HTC","1 (800) 824-6779"),
(2, "MOTOROLA","1 (800) 734-5870"),
(2, "LENOVO","1 (855) 253-6686 option #1"),
(2, "XIAOMI","1 (833) 942-6648"),
(2, "GOOGLE","1 (866) 246-6453"),
(2, "OPPO","1 (800) 103-2777"),
(2, "ONEPLUS","1 (833) 777-3633"),
(2, "VIVO","1 (800) 208-3388"),
(2, "BLACKBERRY","1 (877) 255-2377"),
(2, "ASUS","1 (888) 678-3688"),
(2, "ALCATEL","1 (855) 368-0829"),
(2, "ZTE","1 (877) 817-1759"),
(2, "MICROSOFT","1 (800) 642-7676"),
(2, "VODAFONE","91 (991) 630-473 "),
(2, "ENERGIZER","1 (800) 383-7323"),
(2, "CAT","1 (646) 568-9682"),
(2, "SHARP","1 (800) 237-4277"),
(2, "MICROMAX","1 (800) 202-0091"),
(2, "BLU","1 (877) 602-8762"),
(2, "ACER","1 (866) 695-2237"),
(2, "WIKO","1 (855)945-6872"),
(2, "PANASONIC","1 (800) 211-7262"),
(2, "VERYKOOL","1 (858) 373-1600"),
(2, "PLUM","1 (305) 640-1835"),
(2, "Lively ","1 (800) 650-5918");


-- Creating Model table
CREATE TABLE Model (
  id                    		      int AUTO_INCREMENT,
  brand_id                        int NOT NULL,
  name                            varchar(50),
  year                            varchar(4),
  FOREIGN KEY (brand_id) REFERENCES Brand(id),
  PRIMARY Key (id)
);

-- Creating Domains table
CREATE TABLE Domains (
  id                    		      int AUTO_INCREMENT,
  name                            varchar(50) NOT NULL,
  is_certified                    bit NOT NULL,
  likes                           int NOT NULL,
  PRIMARY Key (id)
);

