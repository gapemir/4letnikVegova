-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: Servisi
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Current Database: `Servisi`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `servisi` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_slovenian_ci */;

USE `Servisi`;

--
-- Table structure for table `oseba`
--

DROP TABLE IF EXISTS `oseba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oseba` (
  `davSt` int(11) NOT NULL,
  `ime` varchar(20) NOT NULL,
  `priimek` varchar(30) NOT NULL,
  `kraj` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`davSt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oseba`
--

LOCK TABLES `oseba` WRITE;
/*!40000 ALTER TABLE `oseba` DISABLE KEYS */;
INSERT INTO `oseba` VALUES (12312312,'Jaka','Jurman','Ljubljana'),(33312312,'Vili','Car','Ljubljana'),(98712312,'Janez','Kranjski','Kranj');
/*!40000 ALTER TABLE `oseba` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servis`
--

DROP TABLE IF EXISTS `servis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servis` (
  `regOznaka` varchar(10) NOT NULL,
  `datum` date NOT NULL,
  `cena` decimal(8,2) NOT NULL,
  `opombe` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`regOznaka`,`datum`),
  CONSTRAINT `servis_ibfk_1` FOREIGN KEY (`regOznaka`) REFERENCES `vozilo` (`regOznaka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servis`
--

LOCK TABLES `servis` WRITE;
/*!40000 ALTER TABLE `servis` DISABLE KEYS */;
/*!40000 ALTER TABLE `servis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serviser`
--

DROP TABLE IF EXISTS `serviser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serviser` (
  `ID` int(11) NOT NULL,
  `ime` varchar(20) NOT NULL,
  `priimek` varchar(20) NOT NULL,
  `geslo` varchar(40) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serviser`
--

LOCK TABLES `serviser` WRITE;
/*!40000 ALTER TABLE `serviser` DISABLE KEYS */;
/*!40000 ALTER TABLE `serviser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uporabnik`
--

DROP TABLE IF EXISTS `uporabnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uporabnik` (
  `eMail` varchar(30) NOT NULL,
  `geslo` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uporabnik`
--

LOCK TABLES `uporabnik` WRITE;
/*!40000 ALTER TABLE `uporabnik` DISABLE KEYS */;
/*!40000 ALTER TABLE `uporabnik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vozilo`
--

DROP TABLE IF EXISTS `vozilo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vozilo` (
  `regOznaka` varchar(10) NOT NULL,
  `lastnik` int(11) NOT NULL,
  `stanjeVozila` varchar(20) NOT NULL,
  PRIMARY KEY (`regOznaka`),
  KEY `lastnik` (`lastnik`),
  CONSTRAINT `vozilo_ibfk_1` FOREIGN KEY (`lastnik`) REFERENCES `oseba` (`davSt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_slovenian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vozilo`
--

LOCK TABLES `vozilo` WRITE;
/*!40000 ALTER TABLE `vozilo` DISABLE KEYS */;
INSERT INTO `vozilo` VALUES ('LJ 123-321',12312312,'ok'),('LJ 999-007',33312312,'nevarno');
/*!40000 ALTER TABLE `vozilo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-23 17:30:27
