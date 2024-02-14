-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: geometrija
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `barve`
--

DROP TABLE IF EXISTS `barve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barve` (
  `barvaID` int(11) NOT NULL,
  `barva` char(20) NOT NULL,
  PRIMARY KEY (`barvaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barve`
--

LOCK TABLES `barve` WRITE;
/*!40000 ALTER TABLE `barve` DISABLE KEYS */;
INSERT INTO `barve` VALUES (1,'bela'),(2,'modra'),(3,'rdeca'),(4,'jaaaaa');
/*!40000 ALTER TABLE `barve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tocke2d`
--

DROP TABLE IF EXISTS `tocke2d`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tocke2d` (
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `barvaID` int(11) NOT NULL,
  PRIMARY KEY (`x`,`y`),
  KEY `barvaID` (`barvaID`),
  CONSTRAINT `tocke2d_ibfk_1` FOREIGN KEY (`barvaID`) REFERENCES `barve` (`barvaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tocke2d`
--

LOCK TABLES `tocke2d` WRITE;
/*!40000 ALTER TABLE `tocke2d` DISABLE KEYS */;
INSERT INTO `tocke2d` VALUES (4,4,1),(1,2,2),(1,4,2),(7,8,2),(12,23,2),(13,10,2),(1,1,3),(8,3,3),(9,3,3);
/*!40000 ALTER TABLE `tocke2d` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-14  6:53:58
