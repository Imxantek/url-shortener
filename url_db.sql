-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: url_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `analytics`
--

DROP TABLE IF EXISTS `analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics` (
  `aID` int NOT NULL AUTO_INCREMENT,
  `short_url` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `click_time` datetime DEFAULT NULL,
  `country` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `browser` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`aID`),
  KEY `short_url` (`short_url`),
  CONSTRAINT `analytics_ibfk_1` FOREIGN KEY (`short_url`) REFERENCES `urls` (`short_url`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics`
--

LOCK TABLES `analytics` WRITE;
/*!40000 ALTER TABLE `analytics` DISABLE KEYS */;
INSERT INTO `analytics` VALUES (1,'67gYyHa','2026-07-07 11:38:10','Poland','Mozilla/5.0'),(2,'67gYyHa','2026-07-07 11:39:19','Localhost (Test)','Mozilla/5.0'),(3,'67gYyHa','2026-07-07 11:39:21','Localhost (Test)','Mozilla/5.0'),(4,'67gYyHa','2026-07-07 11:39:22','Localhost (Test)','Mozilla/5.0'),(5,'67gYyHa','2026-07-07 11:39:23','Localhost (Test)','Mozilla/5.0'),(6,'67gYyHa','2026-07-07 11:42:14','Localhost (Test)','PostmanRuntime/7.54.0'),(7,'67gYyHb','2026-07-09 15:07:46','Localhost (Test)','Mozilla/5.0'),(8,'67gYyHb','2026-07-09 15:08:07','Localhost (Test)','Mozilla/5.0'),(9,'67gYyHY','2026-07-09 17:43:34','Localhost (Test)','Mozilla/5.0'),(10,'67gYyHb','2026-07-09 17:52:41','Localhost (Test)','Mozilla/5.0'),(11,'67gYyHb','2026-07-09 17:54:58','Localhost (Test)','Mozilla/5.0'),(12,'67gYyHb','2026-07-09 17:57:43','Localhost (Test)','Mozilla/5.0'),(13,'67gYyHb','2026-07-09 17:57:57','Localhost (Test)','Mozilla/5.0'),(14,'67gYyHb','2026-07-09 18:30:32','Localhost (Test)','Mozilla/5.0'),(15,'67gYyHa','2026-07-09 18:37:15','Localhost (Test)','Mozilla/5.0'),(16,'67gYyHa','2026-07-09 18:37:17','Localhost (Test)','Mozilla/5.0'),(17,'67gYyHa','2026-07-09 18:37:18','Localhost (Test)','Mozilla/5.0'),(18,'67gYyHa','2026-07-09 18:37:20','Localhost (Test)','Mozilla/5.0'),(19,'67gYyHa','2026-07-09 18:37:21','Localhost (Test)','Mozilla/5.0'),(20,'67gYyHa','2026-07-09 18:37:23','Localhost (Test)','Mozilla/5.0'),(21,'67gYyHa','2026-07-09 18:37:24','Localhost (Test)','Mozilla/5.0'),(22,'67gYyHa','2026-07-09 18:37:25','Localhost (Test)','Mozilla/5.0'),(23,'67gYyHa','2026-07-09 18:37:27','Localhost (Test)','Mozilla/5.0'),(24,'67gYyHa','2026-07-09 18:37:29','Localhost (Test)','Mozilla/5.0'),(25,'67gYyHa','2026-07-09 18:37:30','Localhost (Test)','Mozilla/5.0'),(26,'67gYyHb','2026-07-09 20:07:58','Localhost (Test)','Opera'),(27,'67gYyHb','2026-07-09 20:08:40','Localhost (Test)','Opera'),(28,'67gYyHa','2026-07-09 23:09:22','Localhost (Test)','Opera'),(29,'67gYyHa','2026-07-09 23:09:25','Localhost (Test)','Opera'),(30,'67gYyHa','2026-07-10 21:59:44','Localhost (Test)','Opera'),(31,'67gYyHa','2026-07-10 21:59:57','Localhost (Test)','Opera'),(32,'67gYyHa','2026-07-10 22:02:36','Localhost (Test)','Opera');
/*!40000 ALTER TABLE `analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `urls`
--

DROP TABLE IF EXISTS `urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `urls` (
  `full_url` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `short_url` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`full_url`),
  UNIQUE KEY `short_url` (`short_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `urls`
--

LOCK TABLES `urls` WRITE;
/*!40000 ALTER TABLE `urls` DISABLE KEYS */;
INSERT INTO `urls` VALUES ('https://google.com','67gYyHY','2026-07-07 11:32:11'),('https://mediaexpert.pl','67gYyHf','2026-07-09 12:57:59'),('https://pinterest.com','67gYyHZ','2026-07-07 11:32:11'),('https://spotify.com','67gYyHe','2026-07-07 11:32:11'),('https://www.x-kom.pl/p/1267059-telewizor-32-i-mniejszy-xiaomi-tv-a-2025-32.html','67gYyHa','2026-07-07 11:32:11'),('https://youtube.com','67gYyHb','2026-07-07 11:32:11');
/*!40000 ALTER TABLE `urls` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-10 22:09:26
