-- MySQL dump 9.11
--
-- Host: localhost    Database: uebung
-- ------------------------------------------------------
-- Server version	4.0.21-nt

--
-- Table structure for table `kunde`
--

CREATE TABLE kunde (
  kid int(6) unsigned NOT NULL auto_increment,
  kname varchar(30) NOT NULL default '',
  kvname varchar(30) NOT NULL default '',
  kgdat date default NULL,
  PRIMARY KEY  (kid)
) ENGINE=MyISAM COMMENT='kunde';

--
-- Dumping data for table `kunde`
--

INSERT INTO kunde VALUES (1,'Morger','Heinz','1955-04-07');
INSERT INTO kunde VALUES (2,'Bachmann','Urs','1960-04-04');
INSERT INTO kunde VALUES (3,'Bracher','Ivan','1964-04-03');
INSERT INTO kunde VALUES (4,'Gomez','Paula','1934-01-15');
INSERT INTO kunde VALUES (5,'Wanner','Harry','1975-07-02');
INSERT INTO kunde VALUES (6,'Berchtold','Silvia','1969-04-15');
INSERT INTO kunde VALUES (7,'Bollinger','Fritz','1950-03-25');
INSERT INTO kunde VALUES (8,'Klaus','Peter','1962-12-31');
INSERT INTO kunde VALUES (9,'Clavadetscher','Peter','1948-08-18');
INSERT INTO kunde VALUES (10,'Pauli','Martina','1981-04-30');

--
-- Table structure for table `best`
--

CREATE TABLE best (
  bid int(6) unsigned NOT NULL auto_increment,
  bdate date NOT NULL default '0000-00-00',
  bbemerkung varchar(255) default NULL,
  kid int(6) unsigned NOT NULL default '0',
  PRIMARY KEY  (bid)
) ENGINE=MyISAM;

--
-- Dumping data for table `best`
--

INSERT INTO best VALUES (1,'2003-04-17','AAA',4);
INSERT INTO best VALUES (2,'2003-01-12','BBB',8);
INSERT INTO best VALUES (3,'2002-12-15','CCC',7);
INSERT INTO best VALUES (4,'2003-03-23','DDD',4);
INSERT INTO best VALUES (5,'2003-02-02','EEE',1);
INSERT INTO best VALUES (6,'2002-11-05','FFF',2);
INSERT INTO best VALUES (7,'2003-06-28','GGG',4);
INSERT INTO best VALUES (8,'2002-12-01','HHH',6);
INSERT INTO best VALUES (9,'2002-12-12','JJJ',7);
INSERT INTO best VALUES (10,'2003-01-15','KKK',1);

--
-- Table structure for table `bpos`
--

CREATE TABLE bpos (
  bid int(6) unsigned NOT NULL default '0',
  aid int(6) unsigned NOT NULL default '0',
  menge int(6) unsigned NOT NULL default '0',
  PRIMARY KEY  (bid,aid)
) ENGINE=MyISAM;

--
-- Dumping data for table `bpos`
--

INSERT INTO bpos VALUES (3,1001,3);
INSERT INTO bpos VALUES (3,8000,44);
INSERT INTO bpos VALUES (10,2623,1);
INSERT INTO bpos VALUES (9,1500,3);
INSERT INTO bpos VALUES (1,3300,1);
INSERT INTO bpos VALUES (1,2210,1);
INSERT INTO bpos VALUES (1,1002,1);
INSERT INTO bpos VALUES (2,5454,10);
INSERT INTO bpos VALUES (3,2210,1);
INSERT INTO bpos VALUES (5,4444,5);
INSERT INTO bpos VALUES (4,8050,2);
INSERT INTO bpos VALUES (7,1001,1);
INSERT INTO bpos VALUES (7,1002,1);
INSERT INTO bpos VALUES (6,5454,3);
INSERT INTO bpos VALUES (8,2210,100);

--
-- Table structure for table `artikel`
--

CREATE TABLE artikel (
  aid int(6) unsigned NOT NULL default '0',
  abez varchar(30) NOT NULL default '',
  apreis decimal(10,2) default NULL,
  akat varchar(15) default NULL,
  PRIMARY KEY  (aid)
) ENGINE=MyISAM;

--
-- Dumping data for table `artikel`
--

INSERT INTO artikel VALUES (1001,'Blumenvase',56.3,'Home');
INSERT INTO artikel VALUES (2623,'Velo',899.9,'Vehicle');
INSERT INTO artikel VALUES (5454,'Motorrad',4589.3,'Vehicle');
INSERT INTO artikel VALUES (1500,'Lampe',48.95,'Home');
INSERT INTO artikel VALUES (8000,'Computer',5555.55,'Home');
INSERT INTO artikel VALUES (2210,'Regenschirm',18.5,'Home');
INSERT INTO artikel VALUES (4444,'Notebook',6690.5,'Bussiness');
INSERT INTO artikel VALUES (1002,'Hamburger',9.65,'Food');
INSERT INTO artikel VALUES (3300,'Tisch',2300,'Home');
INSERT INTO artikel VALUES (8050,'Hut',230.55,'Clothes');

