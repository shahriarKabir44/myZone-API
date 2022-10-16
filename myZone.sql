CREATE DATABASE  IF NOT EXISTS `my_zone` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `my_zone`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: my_zone
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `conversation`
--

DROP TABLE IF EXISTS `conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversation` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `participant1` int NOT NULL,
  `participant2` int NOT NULL,
  `last_message` longtext,
  `time` bigint DEFAULT NULL,
  `is_group_conversation` int NOT NULL,
  `receiver` int NOT NULL,
  `isSeen` int(10) unsigned zerofill DEFAULT '0000000000',
  PRIMARY KEY (`Id`),
  KEY `sender_idx` (`participant2`),
  CONSTRAINT `messageSender` FOREIGN KEY (`participant2`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation`
--

LOCK TABLES `conversation` WRITE;
/*!40000 ALTER TABLE `conversation` DISABLE KEYS */;
INSERT INTO `conversation` VALUES (2,21,19,'hi bro',1665758245760,0,21,0000000000),(3,19,22,'hey',1665752769009,0,22,0000000001),(4,37,38,'Hello!',1665846099419,0,38,0000000000),(5,37,39,'Hi!',1665846116582,0,39,0000000000);
/*!40000 ALTER TABLE `conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `converstion`
--

DROP TABLE IF EXISTS `converstion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `converstion` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `receiver` int NOT NULL,
  `sender` int NOT NULL,
  `last_message` longtext NOT NULL,
  `time` varchar(45) DEFAULT NULL,
  `is_group_conversation` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `sender_idx` (`sender`),
  CONSTRAINT `sender` FOREIGN KEY (`sender`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `converstion`
--

LOCK TABLES `converstion` WRITE;
/*!40000 ALTER TABLE `converstion` DISABLE KEYS */;
/*!40000 ALTER TABLE `converstion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `featured_post`
--

DROP TABLE IF EXISTS `featured_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `featured_post` (
  `photoURL` varchar(75) NOT NULL,
  `groupId` int NOT NULL,
  UNIQUE KEY `unique_group` (`groupId`,`photoURL`),
  KEY `featured_group_idx` (`groupId`),
  CONSTRAINT `featured_group` FOREIGN KEY (`groupId`) REFERENCES `featured_post_group` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featured_post`
--

LOCK TABLES `featured_post` WRITE;
/*!40000 ALTER TABLE `featured_post` DISABLE KEYS */;
INSERT INTO `featured_post` VALUES ('/posts/21/9/1.jpg',6),('/posts/36/13/0.jpg',7),('/posts/38/14/0.jpg',8),('/posts/39/15/1.jpg',9),('/posts/37/16/0.jpg',10),('/posts/40/19/0.jpg',11),('/posts/41/20/0.jpg',12),('/posts/42/21/0.jpg',13),('/posts/43/22/0.jpg',14),('/posts/46/25/0.jpg',15);
/*!40000 ALTER TABLE `featured_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `featured_post_group`
--

DROP TABLE IF EXISTS `featured_post_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `featured_post_group` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(45) NOT NULL,
  `createdBy` int NOT NULL,
  `numPosts` int(10) unsigned zerofill DEFAULT '0000000000',
  `initialPhoto` longtext,
  PRIMARY KEY (`Id`),
  KEY `featurer_idx` (`createdBy`),
  CONSTRAINT `featurer` FOREIGN KEY (`createdBy`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featured_post_group`
--

LOCK TABLES `featured_post_group` WRITE;
/*!40000 ALTER TABLE `featured_post_group` DISABLE KEYS */;
INSERT INTO `featured_post_group` VALUES (6,'food',21,0000000001,'/posts/21/9/1.jpg'),(7,'Travel',36,0000000001,'/posts/36/13/0.jpg'),(8,'Travel',38,0000000001,'/posts/38/14/0.jpg'),(9,'Cats',39,0000000001,'/posts/39/15/1.jpg'),(10,'Garden',37,0000000001,'/posts/37/16/0.jpg'),(11,'',40,0000000001,'/posts/40/19/0.jpg'),(12,'Birthday',41,0000000001,'/posts/41/20/0.jpg'),(13,'Friends',42,0000000001,'/posts/42/21/0.jpg'),(14,'Friends',43,0000000001,'/posts/43/22/0.jpg'),(15,'Holud',46,0000000002,'/posts/46/25/0.jpg'),(16,'Holud',46,0000000000,NULL);
/*!40000 ALTER TABLE `featured_post_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendship`
--

DROP TABLE IF EXISTS `friendship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friendship` (
  `friend1` int NOT NULL,
  `friend2` int NOT NULL,
  `friendship_type` int NOT NULL,
  `initiation_time` bigint NOT NULL,
  KEY `initiator_idx` (`friend1`),
  KEY `target_idx` (`friend2`),
  CONSTRAINT `initiator` FOREIGN KEY (`friend1`) REFERENCES `user` (`Id`),
  CONSTRAINT `target` FOREIGN KEY (`friend2`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendship`
--

LOCK TABLES `friendship` WRITE;
/*!40000 ALTER TABLE `friendship` DISABLE KEYS */;
INSERT INTO `friendship` VALUES (21,19,1,1665747563859),(19,21,1,1665747563859),(19,22,1,1665747679790),(22,19,1,1665747679790),(33,21,2,1665771499805),(21,33,3,1665771499805),(35,21,2,1665837727099),(21,35,3,1665837727099),(35,22,2,1665837774122),(22,35,3,1665837774122),(35,20,2,1665837787118),(20,35,3,1665837787118),(36,35,2,1665838231446),(35,36,3,1665838231446),(36,20,2,1665838245045),(20,36,3,1665838245045),(36,21,2,1665838250006),(21,36,3,1665838250006),(36,22,2,1665838259310),(22,36,3,1665838259310),(37,21,2,1665838483868),(21,37,3,1665838483868),(37,36,2,1665838500117),(36,37,3,1665838500117),(37,33,2,1665838509314),(33,37,3,1665838509314),(37,22,2,1665838520736),(22,37,3,1665838520736),(37,35,2,1665838527454),(35,37,3,1665838527454),(37,20,2,1665838533732),(20,37,3,1665838533732),(38,35,2,1665839991177),(35,38,3,1665839991177),(38,36,2,1665839998461),(36,38,3,1665839998461),(38,37,1,1665840010584),(37,38,1,1665840010584),(38,20,2,1665840031902),(20,38,3,1665840031902),(38,33,2,1665840039150),(33,38,3,1665840039150),(39,35,2,1665840393451),(35,39,3,1665840393451),(39,21,2,1665840397069),(21,39,3,1665840397069),(39,38,2,1665840403851),(38,39,3,1665840403851),(39,33,2,1665840408389),(33,39,3,1665840408389),(39,36,2,1665840414075),(36,39,3,1665840414075),(39,37,1,1665840417960),(37,39,1,1665840417960),(39,22,2,1665840423733),(22,39,3,1665840423733),(41,40,1,1665936038972),(40,41,1,1665936038972),(42,35,2,1665936238730),(35,42,3,1665936238730),(42,37,1,1665936246993),(37,42,1,1665936246993),(42,38,2,1665936257641),(38,42,3,1665936257641),(42,39,2,1665936266075),(39,42,3,1665936266075),(42,36,2,1665936271113),(36,42,3,1665936271113),(42,40,1,1665936295411),(40,42,1,1665936295411),(42,41,1,1665936367280),(41,42,1,1665936367280),(43,35,2,1665936765017),(35,43,3,1665936765017),(43,39,2,1665936777570),(39,43,3,1665936777570),(43,37,1,1665936784536),(37,43,1,1665936784536),(43,36,2,1665936791178),(36,43,3,1665936791178),(43,21,2,1665936796921),(21,43,3,1665936796921),(43,42,1,1665936802912),(42,43,1,1665936802912),(43,41,1,1665936808002),(41,43,1,1665936808002),(43,40,1,1665936816167),(40,43,1,1665936816167),(44,35,2,1665937013227),(35,44,3,1665937013227),(44,38,2,1665937023200),(38,44,3,1665937023200),(44,36,2,1665937028344),(36,44,3,1665937028344),(44,39,2,1665937033417),(39,44,3,1665937033417),(44,42,1,1665937044053),(42,44,1,1665937044053),(44,41,1,1665937050386),(41,44,1,1665937050386),(44,40,1,1665937058508),(40,44,1,1665937058508),(44,43,1,1665937063758),(43,44,1,1665937063758),(44,37,1,1665937094987),(37,44,1,1665937094987),(45,37,1,1665937489498),(37,45,1,1665937489498),(45,42,1,1665937498983),(42,45,1,1665937498983),(45,43,1,1665937504824),(43,45,1,1665937504824),(45,40,1,1665937514496),(40,45,1,1665937514496),(45,41,1,1665937522289),(41,45,1,1665937522289),(45,44,1,1665937528437),(44,45,1,1665937528437),(46,36,2,1665937757778),(36,46,3,1665937757778),(46,37,1,1665937764873),(37,46,1,1665937764873),(46,38,2,1665937777388),(38,46,3,1665937777388),(46,42,1,1665937783762),(42,46,1,1665937783762),(46,39,2,1665937791347),(39,46,3,1665937791347),(46,40,1,1665937799051),(40,46,1,1665937799051),(46,41,1,1665937805173),(41,46,1,1665937805173),(46,43,1,1665937811382),(43,46,1,1665937811382),(46,44,1,1665937817202),(44,46,1,1665937817202),(46,45,1,1665937822280),(45,46,1,1665937822280),(41,47,2,1665938017707),(47,41,3,1665938017707),(40,47,2,1665938054760),(47,40,3,1665938054760),(37,47,2,1665938085320),(47,37,3,1665938085320),(43,47,2,1665938098345),(47,43,3,1665938098345),(45,47,2,1665938142705),(47,45,3,1665938142705),(44,47,1,1665938458384),(47,44,1,1665938458384);
/*!40000 ALTER TABLE `friendship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_conversation`
--

DROP TABLE IF EXISTS `group_conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_conversation` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `created_by` int NOT NULL,
  `room_name` varchar(45) NOT NULL,
  `group_name` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `group_conv_creator_idx` (`created_by`),
  CONSTRAINT `group_conv_creator` FOREIGN KEY (`created_by`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_conversation`
--

LOCK TABLES `group_conversation` WRITE;
/*!40000 ALTER TABLE `group_conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_conversation_members`
--

DROP TABLE IF EXISTS `group_conversation_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_conversation_members` (
  `groupId` int NOT NULL,
  `memberId` int NOT NULL,
  KEY `groupId_idx` (`groupId`),
  KEY `memberId_idx` (`memberId`),
  CONSTRAINT `groupId` FOREIGN KEY (`groupId`) REFERENCES `group_conversation` (`Id`),
  CONSTRAINT `memberId` FOREIGN KEY (`memberId`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_conversation_members`
--

LOCK TABLES `group_conversation_members` WRITE;
/*!40000 ALTER TABLE `group_conversation_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_conversation_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interest_names`
--

DROP TABLE IF EXISTS `interest_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interest_names` (
  `interest_name` varchar(45) NOT NULL,
  PRIMARY KEY (`interest_name`),
  UNIQUE KEY `interest_name_UNIQUE` (`interest_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interest_names`
--

LOCK TABLES `interest_names` WRITE;
/*!40000 ALTER TABLE `interest_names` DISABLE KEYS */;
INSERT INTO `interest_names` VALUES ('animals'),('dance'),('food'),('games'),('gardening'),('music'),('sleeping');
/*!40000 ALTER TABLE `interest_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `conversationId` int NOT NULL,
  `sender` int NOT NULL,
  `body` longtext NOT NULL,
  `time` bigint NOT NULL,
  KEY `conversation_idx` (`conversationId`),
  KEY `sender_idx` (`sender`),
  CONSTRAINT `conversation` FOREIGN KEY (`conversationId`) REFERENCES `conversation` (`Id`),
  CONSTRAINT `message_sender` FOREIGN KEY (`sender`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (2,21,'hello',1665705629736),(2,21,'hi',1665705631841),(2,19,'hi',1665706063088),(2,21,'hi',1665734228739),(2,21,'hello',1665734238027),(2,21,'good day',1665734279474),(2,21,'hi',1665734306418),(2,21,'hello',1665734423315),(2,21,'good day',1665734455068),(2,21,'yo',1665734552203),(2,21,'hello',1665735359098),(2,21,'morning',1665735876486),(2,21,'hi',1665735902766),(2,21,'nice day',1665735926846),(2,21,'hiii',1665735952051),(2,21,'hi',1665736202242),(2,21,'hi',1665736247914),(2,21,'morning!',1665736272475),(2,21,'good day',1665736294730),(2,21,'hi',1665736366227),(2,21,'good day',1665736373227),(2,21,'hi',1665736417363),(2,21,'nice day',1665736442899),(2,21,'good',1665736488640),(3,22,'hi',1665747814090),(3,19,'hello',1665747828708),(3,22,'good dat',1665747876835),(3,22,'hi there',1665747962059),(3,19,'hi',1665748030141),(3,22,'hello',1665748039023),(3,19,'good day',1665748049413),(3,22,'nice',1665748067851),(2,19,'hi',1665749248075),(3,22,'hi',1665749791308),(2,19,'good day',1665749801660),(3,19,'good day',1665749849268),(3,19,'hi',1665749945530),(3,19,'hi',1665752198694),(3,22,'good day',1665752223652),(3,19,'howdy',1665752336717),(3,22,'hi',1665752644921),(3,19,'hi',1665752747372),(3,22,'hello',1665752755879),(3,19,'hey',1665752769009),(2,21,'hi',1665757949178),(2,19,'hello',1665757962152),(2,21,'howdy',1665757992056),(2,19,'hi',1665758007450),(2,21,'good day',1665758017583),(2,19,'hi bro',1665758245760),(4,37,'Hello!',1665846099419),(5,37,'Hi!',1665846116582);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `senderId` int NOT NULL,
  `receiverId` int NOT NULL,
  `body` longtext,
  `relatedSchemaId` int DEFAULT NULL,
  `time` bigint DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `isSeen` int(10) unsigned zerofill DEFAULT '0000000000',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (20,19,21,'s has send you a friend request.',19,1665702734187,'3',0000000000),(21,21,19,'shahriar kabir has accepted request.',21,1665702740690,'3',0000000000),(22,19,21,'s has send you a friend request.',19,1665703127849,'3',0000000000),(23,21,19,'shahriar kabir has accepted your friend request.',21,1665703136912,'3',0000000000),(24,21,19,'shahriar kabir has accepted your friend request.',21,1665703214629,'3',0000000000),(25,21,19,'shahriar kabir has send you a friend request.',21,1665747563836,'3',0000000000),(26,19,21,'s has accepted your friend request.',19,1665747576541,'3',0000000000),(27,19,22,'s has send you a friend request.',19,1665747679783,'3',0000000000),(28,22,19,'Rahul Islam has accepted your friend request.',22,1665747700968,'3',0000000000),(29,33,21,'Nusrat Jahan has send you a friend request.',33,1665771499787,'3',0000000000),(30,35,21,'Naima Ajmeen has send you a friend request.',35,1665837727091,'3',0000000000),(31,35,22,'Naima Ajmeen has send you a friend request.',35,1665837774111,'3',0000000000),(32,35,20,'Naima Ajmeen has send you a friend request.',35,1665837787106,'3',0000000000),(33,36,35,'Ashfia Shahnaz has send you a friend request.',36,1665838231435,'3',0000000000),(34,36,20,'Ashfia Shahnaz has send you a friend request.',36,1665838245037,'3',0000000000),(35,36,21,'Ashfia Shahnaz has send you a friend request.',36,1665838250000,'3',0000000000),(36,36,22,'Ashfia Shahnaz has send you a friend request.',36,1665838259299,'3',0000000000),(37,37,21,'Talbia Fida has send you a friend request.',37,1665838483856,'3',0000000000),(38,37,36,'Talbia Fida has send you a friend request.',37,1665838500107,'3',0000000000),(39,37,33,'Talbia Fida has send you a friend request.',37,1665838509304,'3',0000000000),(40,37,22,'Talbia Fida has send you a friend request.',37,1665838520726,'3',0000000000),(41,37,35,'Talbia Fida has send you a friend request.',37,1665838527447,'3',0000000000),(42,37,20,'Talbia Fida has send you a friend request.',37,1665838533725,'3',0000000000),(43,38,35,'Sinthiya Sadia has send you a friend request.',38,1665839991166,'3',0000000000),(44,38,36,'Sinthiya Sadia has send you a friend request.',38,1665839998450,'3',0000000000),(45,38,37,'Sinthiya Sadia has send you a friend request.',38,1665840010574,'3',0000000000),(46,38,20,'Sinthiya Sadia has send you a friend request.',38,1665840031895,'3',0000000000),(47,38,33,'Sinthiya Sadia has send you a friend request.',38,1665840039139,'3',0000000000),(48,39,35,'Shurovy Rahman has send you a friend request.',39,1665840393438,'3',0000000000),(49,39,21,'Shurovy Rahman has send you a friend request.',39,1665840397063,'3',0000000000),(50,39,38,'Shurovy Rahman has send you a friend request.',39,1665840403838,'3',0000000000),(51,39,33,'Shurovy Rahman has send you a friend request.',39,1665840408383,'3',0000000000),(52,39,36,'Shurovy Rahman has send you a friend request.',39,1665840414062,'3',0000000000),(53,39,37,'Shurovy Rahman has send you a friend request.',39,1665840417957,'3',0000000000),(54,39,22,'Shurovy Rahman has send you a friend request.',39,1665840423719,'3',0000000000),(55,37,39,'Talbia Fida has accepted your friend request.',37,1665841287382,'3',0000000000),(56,37,38,'Talbia Fida has accepted your friend request.',37,1665841345494,'3',0000000000),(57,37,38,'Talbia Fida has commented on your post.',14,1665845352104,'2',0000000000),(58,37,38,'Talbia Fida has liked your post.',14,1665845365315,'1',0000000000),(59,41,40,'Rifat Tamanna Mim has send you a friend request.',41,1665936038958,'3',0000000000),(60,40,41,'Tanjila Afrin has accepted your friend request.',40,1665936048582,'3',0000000000),(61,42,35,'Fahima Momi has send you a friend request.',42,1665936238717,'3',0000000000),(62,42,37,'Fahima Momi has send you a friend request.',42,1665936246981,'3',0000000000),(63,42,38,'Fahima Momi has send you a friend request.',42,1665936257629,'3',0000000000),(64,42,39,'Fahima Momi has send you a friend request.',42,1665936266062,'3',0000000000),(65,42,36,'Fahima Momi has send you a friend request.',42,1665936271101,'3',0000000000),(66,42,40,'Fahima Momi has send you a friend request.',42,1665936295398,'3',0000000000),(67,40,42,'Tanjila Afrin has accepted your friend request.',40,1665936301326,'3',0000000000),(68,42,41,'Fahima Momi has send you a friend request.',42,1665936367269,'3',0000000000),(69,41,42,'Rifat Tamanna Mim has accepted your friend request.',41,1665936376365,'3',0000000000),(70,37,42,'Talbia Fida has accepted your friend request.',37,1665936402185,'3',0000000000),(71,43,35,'Mir Mugdho has send you a friend request.',43,1665936765005,'3',0000000000),(72,43,39,'Mir Mugdho has send you a friend request.',43,1665936777559,'3',0000000000),(73,43,37,'Mir Mugdho has send you a friend request.',43,1665936784525,'3',0000000000),(74,43,36,'Mir Mugdho has send you a friend request.',43,1665936791166,'3',0000000000),(75,43,21,'Mir Mugdho has send you a friend request.',43,1665936796911,'3',0000000000),(76,43,42,'Mir Mugdho has send you a friend request.',43,1665936802901,'3',0000000000),(77,43,41,'Mir Mugdho has send you a friend request.',43,1665936807989,'3',0000000000),(78,43,40,'Mir Mugdho has send you a friend request.',43,1665936816157,'3',0000000000),(79,37,43,'Talbia Fida has accepted your friend request.',37,1665936839999,'3',0000000000),(80,40,43,'Tanjila Afrin has accepted your friend request.',40,1665936844702,'3',0000000000),(81,41,43,'Rifat Tamanna Mim has accepted your friend request.',41,1665936849373,'3',0000000000),(82,42,43,'Fahima Momi has accepted your friend request.',42,1665936857038,'3',0000000000),(83,44,35,'Rowshan Jahan Showravi has send you a friend request.',44,1665937013213,'3',0000000000),(84,44,38,'Rowshan Jahan Showravi has send you a friend request.',44,1665937023189,'3',0000000000),(85,44,36,'Rowshan Jahan Showravi has send you a friend request.',44,1665937028333,'3',0000000000),(86,44,39,'Rowshan Jahan Showravi has send you a friend request.',44,1665937033405,'3',0000000000),(87,44,42,'Rowshan Jahan Showravi has send you a friend request.',44,1665937044040,'3',0000000000),(88,44,41,'Rowshan Jahan Showravi has send you a friend request.',44,1665937050374,'3',0000000000),(89,44,40,'Rowshan Jahan Showravi has send you a friend request.',44,1665937058495,'3',0000000000),(90,44,43,'Rowshan Jahan Showravi has send you a friend request.',44,1665937063741,'3',0000000000),(91,44,37,'Rowshan Jahan Showravi has send you a friend request.',44,1665937094973,'3',0000000000),(92,37,44,'Talbia Fida has accepted your friend request.',37,1665937101868,'3',0000000000),(93,40,44,'Tanjila Afrin has accepted your friend request.',40,1665937108654,'3',0000000000),(94,41,44,'Rifat Tamanna Mim has accepted your friend request.',41,1665937115533,'3',0000000000),(95,42,44,'Fahima Momi has accepted your friend request.',42,1665937121285,'3',0000000000),(96,43,44,'Mir Mugdho has accepted your friend request.',43,1665937128181,'3',0000000000),(97,45,37,'Esrat Eti has send you a friend request.',45,1665937489485,'3',0000000000),(98,45,42,'Esrat Eti has send you a friend request.',45,1665937498972,'3',0000000000),(99,45,43,'Esrat Eti has send you a friend request.',45,1665937504812,'3',0000000000),(100,45,40,'Esrat Eti has send you a friend request.',45,1665937514484,'3',0000000000),(101,45,41,'Esrat Eti has send you a friend request.',45,1665937522277,'3',0000000000),(102,45,44,'Esrat Eti has send you a friend request.',45,1665937528428,'3',0000000000),(103,37,45,'Talbia Fida has accepted your friend request.',37,1665937544686,'3',0000000000),(104,40,45,'Tanjila Afrin has accepted your friend request.',40,1665937550981,'3',0000000000),(105,41,45,'Rifat Tamanna Mim has accepted your friend request.',41,1665937557835,'3',0000000000),(106,42,45,'Fahima Momi has accepted your friend request.',42,1665937564885,'3',0000000000),(107,43,45,'Mir Mugdho has accepted your friend request.',43,1665937570141,'3',0000000000),(108,44,45,'Rowshan Jahan Showravi has accepted your friend request.',44,1665937575886,'3',0000000000),(109,46,36,'Soma paul has send you a friend request.',46,1665937757767,'3',0000000000),(110,46,37,'Soma paul has send you a friend request.',46,1665937764860,'3',0000000000),(111,46,38,'Soma paul has send you a friend request.',46,1665937777380,'3',0000000000),(112,46,42,'Soma paul has send you a friend request.',46,1665937783749,'3',0000000000),(113,46,39,'Soma paul has send you a friend request.',46,1665937791335,'3',0000000000),(114,46,40,'Soma paul has send you a friend request.',46,1665937799043,'3',0000000000),(115,46,41,'Soma paul has send you a friend request.',46,1665937805164,'3',0000000000),(116,46,43,'Soma paul has send you a friend request.',46,1665937811372,'3',0000000000),(117,46,44,'Soma paul has send you a friend request.',46,1665937817191,'3',0000000000),(118,46,45,'Soma paul has send you a friend request.',46,1665937822269,'3',0000000000),(119,37,46,'Talbia Fida has accepted your friend request.',37,1665937828476,'3',0000000000),(120,40,46,'Tanjila Afrin has accepted your friend request.',40,1665937834652,'3',0000000000),(121,41,46,'Rifat Tamanna Mim has accepted your friend request.',41,1665937840052,'3',0000000000),(122,42,46,'Fahima Momi has accepted your friend request.',42,1665937844989,'3',0000000000),(123,43,46,'Mir Mugdho has accepted your friend request.',43,1665937851100,'3',0000000000),(124,44,46,'Rowshan Jahan Showravi has accepted your friend request.',44,1665937856710,'3',0000000000),(125,45,46,'Esrat Eti has accepted your friend request.',45,1665937863859,'3',0000000000),(126,42,47,'Fahima Momi has commented on your post.',26,1665938003926,'2',0000000000),(127,42,47,'Fahima Momi has liked your post.',26,1665938005474,'1',0000000000),(128,41,47,'Rifat Tamanna Mim has send you a friend request.',41,1665938017700,'3',0000000000),(129,41,47,'Rifat Tamanna Mim has commented on your post.',26,1665938039437,'2',0000000000),(130,40,47,'Tanjila Afrin has send you a friend request.',40,1665938054749,'3',0000000000),(131,40,47,'Tanjila Afrin has commented on your post.',26,1665938075719,'2',0000000000),(132,37,47,'Talbia Fida has send you a friend request.',37,1665938085308,'3',0000000000),(133,43,47,'Mir Mugdho has send you a friend request.',43,1665938098334,'3',0000000000),(134,44,47,'Rowshan Jahan Showravi has commented on your post.',26,1665938128293,'2',0000000000),(135,45,47,'Esrat Eti has send you a friend request.',45,1665938142692,'3',0000000000),(136,41,47,'Rifat Tamanna Mim has commented on your post.',27,1665938322458,'2',0000000000),(137,41,47,'Rifat Tamanna Mim has commented on your post.',27,1665938335090,'2',0000000000),(138,42,47,'Fahima Momi has commented on your post.',28,1665938365730,'2',0000000000),(139,43,47,'Mir Mugdho has commented on your post.',28,1665938394804,'2',0000000000),(140,43,47,'Mir Mugdho has commented on your post.',28,1665938405300,'2',0000000000),(141,43,47,'Mir Mugdho has commented on your post.',27,1665938443547,'2',0000000000),(142,43,47,'Mir Mugdho has commented on your post.',27,1665938450674,'2',0000000000),(143,44,47,'Rowshan Jahan Showravi has send you a friend request.',44,1665938458372,'3',0000000000),(144,45,47,'Esrat Eti has commented on your post.',28,1665938488466,'2',0000000000),(145,47,44,'Faiza Khan has accepted your friend request.',47,1665938534668,'3',0000000000);
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `body` longtext,
  `attached_media` longtext,
  `posted_by` int NOT NULL,
  `posted_day` varchar(15) NOT NULL,
  `posted_on` bigint NOT NULL,
  `numReactions` int(10) unsigned zerofill NOT NULL,
  `numComments` bigint(8) unsigned zerofill NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `postedby_idx` (`posted_by`),
  CONSTRAINT `postedby` FOREIGN KEY (`posted_by`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (8,'abcdewoi dogs ','[\"/posts/19/8/0.jpg\"]',19,'19267',1664695365624,0000000000,00000000),(9,'food','[\"/posts/21/9/1.jpg\",\"/posts/21/9/0.jpg\"]',21,'19278',1665680981694,0000000000,00000000),(10,'Rag 2019','[\"/posts/35/10/0.jpg\"]',35,'19280',1665837853736,0000000000,00000000),(11,'CSE Fest','[\"/posts/35/11/0.jpg\"]',35,'19280',1665837904309,0000000000,00000000),(12,'Cox\'s Bazar','[\"/posts/35/12/0.jpg\"]',35,'19280',1665837954445,0000000000,00000000),(13,'Cox\'s Bazar','[\"/posts/36/13/0.jpg\"]',36,'19280',1665838177565,0000000000,00000000),(14,'Sylhet','[\"/posts/38/14/0.jpg\",\"/posts/38/14/1.jpg\"]',38,'19280',1665839928160,0000000001,00000001),(15,'Master Shifu','[\"/posts/39/15/0.jpg\",\"/posts/39/15/1.jpg\"]',39,'19280',1665840286721,0000000001,00000000),(16,'Gardening','[\"/posts/37/16/0.jpg\"]',37,'19280',1665841460207,0000000001,00000000),(17,'Sunrise','[\"/posts/37/17/0.jpg\"]',37,'19280',1665841513916,0000000001,00000000),(18,'Tour','[\"/posts/37/18/0.jpg\"]',37,'19280',1665845260554,0000000001,00000000),(19,'Best Friend','[\"/posts/40/19/0.jpg\"]',40,'19281',1665935837102,0000000000,00000000),(20,'Birthday!','[\"/posts/41/20/0.jpg\"]',41,'19281',1665935991214,0000000002,00000000),(21,'Friends','[\"/posts/42/21/0.jpg\"]',42,'19281',1665936208886,0000000001,00000000),(22,'Friends','[\"/posts/43/22/0.jpg\"]',43,'19281',1665936724454,0000000000,00000000),(23,'Dance Fest','[\"/posts/44/23/0.jpg\"]',44,'19281',1665936998273,0000000000,00000000),(24,'Hair day','[\"/posts/45/24/0.jpg\"]',45,'19281',1665937464059,0000000000,00000000),(25,'Holud','[\"/posts/46/25/0.jpg\"]',46,'19281',1665937695929,0000000000,00000000),(26,'Refreshments','[\"/posts/47/26/0.jpg\"]',47,'19281',1665937972999,0000000008,00000004),(27,'Noodles','[\"/posts/47/27/0.jpg\"]',47,'19281',1665938180062,0000000006,00000004),(28,'My love!','[\"/posts/47/28/1.jpg\",\"/posts/47/28/0.jpg\"]',47,'19281',1665938224713,0000000007,00000005);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_comments`
--

DROP TABLE IF EXISTS `post_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_comments` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `commentBody` longtext NOT NULL,
  `commentedBy` int NOT NULL,
  `postId` int NOT NULL,
  `time` bigint NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `commentedOn_idx` (`postId`),
  KEY `commentedBy_idx` (`commentedBy`),
  CONSTRAINT `commentedBy` FOREIGN KEY (`commentedBy`) REFERENCES `user` (`Id`),
  CONSTRAINT `commentedOn` FOREIGN KEY (`postId`) REFERENCES `post` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_comments`
--

LOCK TABLES `post_comments` WRITE;
/*!40000 ALTER TABLE `post_comments` DISABLE KEYS */;
INSERT INTO `post_comments` VALUES (1,'Wow! ?',37,14,1665845352125),(2,'Have fun!',42,26,1665938003936),(3,'Which place?',41,26,1665938039447),(4,'Take me too',40,26,1665938075728),(5,'girl!!',44,26,1665938128304),(6,'oh wow!',47,28,1665938261853),(7,'tasty!',41,27,1665938322470),(8,'cook for me!',41,27,1665938335105),(9,'lovely',42,28,1665938365744),(10,'send me flowers!',43,28,1665938394814),(11,'❤️❤️❤️',43,28,1665938405310),(12,'???',43,27,1665938443557),(13,'??',43,27,1665938450687),(14,'??',45,28,1665938488474);
/*!40000 ALTER TABLE `post_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_reactions`
--

DROP TABLE IF EXISTS `post_reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_reactions` (
  `postId` int NOT NULL,
  `reactedBy` int NOT NULL,
  `time` bigint NOT NULL,
  KEY `reacted_on_idx` (`postId`),
  KEY `reacted_by_idx` (`reactedBy`),
  CONSTRAINT `reacted_by` FOREIGN KEY (`reactedBy`) REFERENCES `user` (`Id`),
  CONSTRAINT `reacted_on` FOREIGN KEY (`postId`) REFERENCES `post` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_reactions`
--

LOCK TABLES `post_reactions` WRITE;
/*!40000 ALTER TABLE `post_reactions` DISABLE KEYS */;
INSERT INTO `post_reactions` VALUES (14,37,1665845365334),(15,37,1665845405902),(16,37,1665845420426),(17,37,1665845422185),(18,37,1665845424632),(20,40,1665936094268),(20,41,1665936111978),(21,42,1665936214630),(26,42,1665938005486),(26,41,1665938020996),(26,40,1665938057725),(26,37,1665938087909),(26,43,1665938100780),(26,44,1665938114268),(26,45,1665938140765),(26,46,1665938156207),(28,47,1665938243927),(27,47,1665938246006),(28,41,1665938307326),(27,41,1665938309584),(28,42,1665938344261),(27,42,1665938345928),(28,43,1665938415726),(28,44,1665938460973),(27,44,1665938463248),(28,45,1665938473216),(27,45,1665938477847),(28,46,1665938496885),(27,46,1665938498860);
/*!40000 ALTER TABLE `post_reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `profileImage` longtext,
  `coverPhoto` longtext,
  `numFriends` int(10) unsigned zerofill DEFAULT '0000000000',
  `websocketid` varchar(70) DEFAULT NULL,
  `password` varchar(45) NOT NULL,
  `numUnseenNotification` int(10) unsigned zerofill DEFAULT '0000000000',
  `numNewFriendRequests` int(10) unsigned zerofill DEFAULT '0000000000',
  `numUnseenMessages` int(10) unsigned zerofill DEFAULT '0000000000',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (19,'s','sa','/profileImages/19.jpg','/stockCoverPhoto.jpg',0000000002,'1','s',0000000000,0000000000,0000000000),(20,'Shahriar Kabir','shahriar1234','/profileImages/20.jpg','/stockCoverPhoto.jpg',0000000000,'0','abcd',0000000000,0000000004,0000000000),(21,'shahriar kabir','shahriar kabir','/profileImages/21.jpg','/stockCoverPhoto.jpg',0000000001,'1','abc',0000000000,0000000006,0000000000),(22,'Rahul Islam','rahul','/profileImages/22.jpg','/stockCoverPhoto.jpg',0000000001,'1','abcd',0000000000,0000000004,0000000000),(33,'Nusrat Jahan','abc','/profileImages/33.jpg','/stockCoverPhoto.jpg',0000000000,'0','abc',0000000000,0000000003,0000000000),(34,'ab','a','/profileImages/34.jpg','/stockCoverPhoto.jpg',0000000000,'0','a',0000000000,0000000000,0000000000),(35,'Naima Ajmeen','naima@gmail.com','/profileImages/35.jpg','/stockCoverPhoto.jpg',0000000000,NULL,'naima',0000000000,0000000007,0000000000),(36,'Ashfia Shahnaz','any@gmail.com','/profileImages/36.jpg','/stockCoverPhoto.jpg',0000000000,NULL,'any',0000000000,0000000007,0000000000),(37,'Talbia Fida','fida@gmail.com','/profileImages/37.jpg','/stockCoverPhoto.jpg',0000000007,'0','fida',0000000000,0000000001,0000000000),(38,'Sinthiya Sadia','sinthiya@gmail.com','/profileImages/38.jpg','/stockCoverPhoto.jpg',0000000001,NULL,'sinthia',0000000000,0000000005,0000000000),(39,'Shurovy Rahman','shurovy@gmail.com','/profileImages/39.jpg','/stockCoverPhoto.jpg',0000000001,NULL,'shuvy',0000000000,0000000005,0000000000),(40,'Tanjila Afrin','tanz@gmail.com','/profileImages/40.jpg','/stockCoverPhoto.jpg',0000000006,'0','tanza',0000000000,0000000001,0000000000),(41,'Rifat Tamanna Mim','rifat@gmail.com','/profileImages/41.jpg','/stockCoverPhoto.jpg',0000000006,'1','mim',0000000000,0000000001,0000000000),(42,'Fahima Momi','fahima@gmail.com','/profileImages/42.jpg','/stockCoverPhoto.jpg',0000000007,NULL,'momi',0000000000,0000000001,0000000000),(43,'Mir Mugdho','mir@gmail.com','/profileImages/43.jpg','/stockCoverPhoto.jpg',0000000007,'0','mughdho',0000000000,0000000001,0000000000),(44,'Rowshan Jahan Showravi','rowshan@gmail.com','/profileImages/44.jpg','/stockCoverPhoto.jpg',0000000008,'0','rowshan',0000000000,0000000002,0000000000),(45,'Esrat Eti','eti@gmail.com','/profileImages/45.jpg','/stockCoverPhoto.jpg',0000000007,'0','iseti',0000000000,0000000001,0000000000),(46,'Soma paul','spaul@gmail.com','/profileImages/46.jpg','/stockCoverPhoto.jpg',0000000007,'0','sopaul',0000000000,0000000000,0000000000),(47,'Faiza Khan','khan@gmail.com','/profileImages/47.jpg','/stockCoverPhoto.jpg',0000000001,'0','fkhan',0000000000,0000000000,0000000000);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_interests`
--

DROP TABLE IF EXISTS `user_interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_interests` (
  `userId` int NOT NULL,
  `interestName` varchar(45) NOT NULL,
  UNIQUE KEY `unique_index` (`userId`,`interestName`),
  KEY `user_idx` (`userId`),
  KEY `interest_name_idx` (`interestName`),
  CONSTRAINT `interest_name` FOREIGN KEY (`interestName`) REFERENCES `interest_names` (`interest_name`),
  CONSTRAINT `user` FOREIGN KEY (`userId`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_interests`
--

LOCK TABLES `user_interests` WRITE;
/*!40000 ALTER TABLE `user_interests` DISABLE KEYS */;
INSERT INTO `user_interests` VALUES (21,'food'),(35,'food'),(35,'games'),(36,'music'),(36,'sleeping'),(37,'food'),(37,'games'),(37,'sleeping'),(38,'food'),(38,'games'),(38,'music'),(39,'animals'),(39,'games'),(39,'music'),(39,'sleeping'),(40,'animals'),(40,'games'),(40,'music'),(40,'sleeping'),(41,'animals'),(41,'food'),(41,'music'),(42,'games'),(42,'music'),(42,'sleeping'),(43,'games'),(43,'music'),(43,'sleeping'),(44,'dance'),(44,'food'),(44,'games'),(44,'gardening'),(44,'sleeping'),(45,'dance'),(45,'gardening'),(45,'music'),(45,'sleeping'),(46,'food'),(46,'games'),(46,'music'),(46,'sleeping'),(47,'food'),(47,'games'),(47,'gardening'),(47,'music'),(47,'sleeping');
/*!40000 ALTER TABLE `user_interests` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-16 23:13:11
