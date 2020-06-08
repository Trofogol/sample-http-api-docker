-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: test_corp
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `test_corp`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `test_corp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `test_corp`;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `office` varchar(50) DEFAULT NULL,
  `position` enum('office manager','accountant','support team member','project manager','dev','ops','devops') NOT NULL,
  `workstation` smallint unsigned DEFAULT NULL,
  `birth_date` date NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workstation` (`workstation`),
  KEY `office` (`office`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`workstation`) REFERENCES `workstations` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`office`) REFERENCES `offices` (`name`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Bob J. Nickolson','Headquarter','office manager',5,'1972-06-06','2020-02-21'),(2,'Jennie Neiman','Metropoly','office manager',7,'1988-11-23','2020-02-21'),(3,'Alexander Lyzhnyov','Russia','office manager',9,'1982-03-30','2020-02-22'),(4,'Vik Klainer','Metropoly','support team member',6,'1991-09-23','2020-02-22'),(5,'Semen Falcev','Russia','ops',8,'1993-05-05','2020-02-22'),(6,'John Stivenson','Headquarter','project manager',1,'1988-04-05','2020-02-20'),(7,'Alice Rhino','Headquarter','accountant',4,'1979-06-08','2020-02-21');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offices`
--

DROP TABLE IF EXISTS `offices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offices` (
  `name` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `manager` smallint unsigned DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `manager` (`manager`),
  CONSTRAINT `offices_ibfk_1` FOREIGN KEY (`manager`) REFERENCES `employees` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offices`
--

LOCK TABLES `offices` WRITE;
/*!40000 ALTER TABLE `offices` DISABLE KEYS */;
INSERT INTO `offices` VALUES ('Headquarter','142534 Firefly blvd. 15 Gotham',1,'+54 264 1235 48'),('Metropoly','001423 Glory street 28 Metropolis',2,'+54 756 5486 54'),('Russia','645235 Razina street 2 Mukhosransk',3,'+7 598 04520 21');
/*!40000 ALTER TABLE `offices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workstations`
--

DROP TABLE IF EXISTS `workstations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workstations` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `hostname` varchar(25) NOT NULL,
  `address` varchar(15) NOT NULL,
  `office` varchar(50) DEFAULT NULL,
  `equipment` tinyint(1) DEFAULT NULL,
  `last_service` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `office` (`office`),
  CONSTRAINT `workstations_ibfk_1` FOREIGN KEY (`office`) REFERENCES `offices` (`name`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workstations`
--

LOCK TABLES `workstations` WRITE;
/*!40000 ALTER TABLE `workstations` DISABLE KEYS */;
INSERT INTO `workstations` VALUES (1,'linux-mint-001','192.168.100.00','Headquarter',0,'2020-02-20'),(2,'gotham-serv1','10.0.0.00','Headquarter',1,'2020-02-13'),(3,'metro-serv1','10.0.1.00','Metropoly',1,'2020-02-14'),(4,'linux-mint-002','192.168.100.00','Headquarter',0,'2020-02-21'),(5,'macbook-pro-1','192.168.100.00','Headquarter',0,'2020-02-21'),(6,'windows-station1','192.168.200.00','Metropoly',1,'2020-02-22'),(7,'macbook-pro-2','192.168.200.00','Metropoly',0,'2020-02-21'),(8,'windows-station2','192.168.300.00','Russia',1,'2020-02-22'),(9,'macbook-pro-3','192.168.300.00','Russia',0,'2020-02-21');
/*!40000 ALTER TABLE `workstations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-06 19:18:05
