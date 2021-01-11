CREATE DATABASE  IF NOT EXISTS `estate_agency` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `estate_agency`;
-- MySQL dump 10.13  Distrib 5.7.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: estate_agency
-- ------------------------------------------------------
-- Server version	5.7.26-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `clientID` char(12) NOT NULL DEFAULT '',
  `name` varchar(30) DEFAULT NULL,
  `clientaddress` varchar(100) DEFAULT NULL,
  `tel` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`clientID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES ('C1','John','#112, Coat Ave., Beautiful City, Nice Country','11265438790'),('C2','Michael','#113,Moon Ave., Beautiful City, Nice Country','1120987654'),('C3','Christ','#23, coat Ave., Cow City, nice Country','1120981234'),('C4','Adam','#45,Sun Ave, Beautiful city, Nice Country','1120987054'),('C5','Kelly','#23, God Ave., Cow City, Nice Country','1124536657'),('C6','Cloe','#87, Bell Ville, Nice country','1294787899'),('C7','Merry','#112, Sun Ave., Beautiful City, Nice Country','1128737509'),('C8','Brown','#113,Sun Ave., Beautiful City, Nice Country','1123546754'),('C9','Christ','#34, Bell Ville, Nice country','1123546954');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `multitimerent`
--

DROP TABLE IF EXISTS `multitimerent`;
/*!50001 DROP VIEW IF EXISTS `multitimerent`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `multitimerent` AS SELECT 
 1 AS `clientID`,
 1 AS `name`,
 1 AS `clientaddress`,
 1 AS `tel`,
 1 AS `propertyID`,
 1 AS `rent_date`,
 1 AS `price`,
 1 AS `end_date`,
 1 AS `count(*)`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property` (
  `propertyID` int(11) NOT NULL DEFAULT '0',
  `type` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`propertyID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property`
--

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
INSERT INTO `property` VALUES (1,'Flat','#113, Sun Ave, Beautiful City, Nice Country'),(2,'House','#12, God Ave, Cow City, Nice Country'),(3,'Flat','#112, Sun Ave, Beautiful City, Nice Country'),(4,'apartment','#75, Sun Ave, Bell ville, Nice Country'),(5,'flat','#114, Sun Ave, Beautiful City, Nice Country'),(6,'house','#15, God Ave, Cow City, Nice Country');
/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rent`
--

DROP TABLE IF EXISTS `rent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rent` (
  `propertyID` int(11) NOT NULL DEFAULT '0',
  `rent_date` date NOT NULL DEFAULT '2000-01-01',
  `clientID` char(12) NOT NULL DEFAULT '',
  `price` decimal(7,2) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`propertyID`,`rent_date`,`clientID`),
  KEY `rent_ibfk_2` (`clientID`),
  CONSTRAINT `rent_ibfk_1` FOREIGN KEY (`propertyID`) REFERENCES `property` (`propertyID`),
  CONSTRAINT `rent_ibfk_2` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rent`
--

LOCK TABLES `rent` WRITE;
/*!40000 ALTER TABLE `rent` DISABLE KEYS */;
INSERT INTO `rent` VALUES (1,'1999-01-01','C2',700.00,'2001-01-01'),(1,'2001-03-09','C1',650.00,'2007-12-09'),(1,'2007-12-10','C1',700.00,'2017-12-10'),(1,'2008-01-01','C8',800.00,'2018-01-01'),(2,'2000-07-06','C5',1000.00,'2010-07-06'),(2,'2011-03-01','C3',1000.00,'2011-10-01'),(2,'2012-02-02','C5',1200.00,'2017-02-02'),(3,'2010-02-01','C7',700.00,'2015-02-01'),(3,'2015-05-02','C3',600.00,'2020-05-02'),(4,'2017-01-20','C9',500.00,'2027-01-20'),(5,'2018-01-20','C1',600.00,'2019-01-20'),(6,'2018-03-20','C4',600.00,'2020-03-20');
/*!40000 ALTER TABLE `rent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `rentproperty`
--

DROP TABLE IF EXISTS `rentproperty`;
/*!50001 DROP VIEW IF EXISTS `rentproperty`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `rentproperty` AS SELECT 
 1 AS `propertyID`,
 1 AS `rent_date`,
 1 AS `clientID`,
 1 AS `price`,
 1 AS `end_date`,
 1 AS `type`,
 1 AS `address`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'estate_agency'
--

--
-- Final view structure for view `multitimerent`
--

/*!50001 DROP VIEW IF EXISTS `multitimerent`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `multitimerent` AS select `client`.`clientID` AS `clientID`,`client`.`name` AS `name`,`client`.`clientaddress` AS `clientaddress`,`client`.`tel` AS `tel`,`rent`.`propertyID` AS `propertyID`,`rent`.`rent_date` AS `rent_date`,`rent`.`price` AS `price`,`rent`.`end_date` AS `end_date`,count(0) AS `count(*)` from (`client` join `rent` on((`client`.`clientID` = `rent`.`clientID`))) group by `client`.`clientID` having (count(0) > 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rentproperty`
--

/*!50001 DROP VIEW IF EXISTS `rentproperty`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rentproperty` AS select `r`.`propertyID` AS `propertyID`,`r`.`rent_date` AS `rent_date`,`r`.`clientID` AS `clientID`,`r`.`price` AS `price`,`r`.`end_date` AS `end_date`,`p`.`type` AS `type`,`p`.`address` AS `address` from (`rent` `r` join `property` `p` on((`r`.`propertyID` = `p`.`propertyID`))) where ((`p`.`type` like '%flat%') and (`p`.`address` like '%Beautiful City%') and (year(`r`.`rent_date`) = 2018)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-22  9:09:06
