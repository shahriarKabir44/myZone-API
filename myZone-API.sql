-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: myzone
-- ------------------------------------------------------
-- Server version	8.0.30-0ubuntu0.22.04.1

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
  PRIMARY KEY (`Id`),
  KEY `sender_idx` (`participant2`),
  CONSTRAINT `sender` FOREIGN KEY (`participant2`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation`
--

LOCK TABLES `conversation` WRITE;
/*!40000 ALTER TABLE `conversation` DISABLE KEYS */;
INSERT INTO `conversation` VALUES (1,20,19,'hi',1665166898117,0);
/*!40000 ALTER TABLE `conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `featured_post`
--

DROP TABLE IF EXISTS `featured_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `featured_post` (
  `photoURL` longtext NOT NULL,
  `groupId` int NOT NULL,
  KEY `featured_group_idx` (`groupId`),
  CONSTRAINT `featured_group` FOREIGN KEY (`groupId`) REFERENCES `featured_post_group` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featured_post`
--

LOCK TABLES `featured_post` WRITE;
/*!40000 ALTER TABLE `featured_post` DISABLE KEYS */;
INSERT INTO `featured_post` VALUES ('http://localhost:4000/posts/19/8/0.jpg',1);
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
  UNIQUE KEY `label_UNIQUE` (`label`),
  KEY `featurer_idx` (`createdBy`),
  CONSTRAINT `featurer` FOREIGN KEY (`createdBy`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featured_post_group`
--

LOCK TABLES `featured_post_group` WRITE;
/*!40000 ALTER TABLE `featured_post_group` DISABLE KEYS */;
INSERT INTO `featured_post_group` VALUES (1,'food',19,0000000002,'http://localhost:4000/posts/19/8/0.jpg');
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
INSERT INTO `friendship` VALUES (20,19,1,1665159817230),(19,20,1,1665159817230);
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
INSERT INTO `interest_names` VALUES ('food');
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
INSERT INTO `message` VALUES (1,19,'hello',1665160470225),(1,20,'hi',1665160576342),(1,19,'howdy!',1665160603583),(1,19,'yo',1665163381204),(1,20,'hi',1665163755788),(1,20,'hello',1665163811421),(1,19,'hi there',1665164167495),(1,20,'hello',1665164209431),(1,19,'hi',1665164260892),(1,20,'hi',1665164426935),(1,20,'hi',1665164524335),(1,19,'hello',1665164536510),(1,19,'hello',1665164908812),(1,19,'hi',1665164945163),(1,19,'what',1665164997064),(1,19,'good day',1665165067203),(1,19,'hello',1665166772067),(1,19,'howdy',1665166824915),(1,19,'hi',1665166898117);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,20,19,'Shahriar Kabir has send you a friend request.',20,1665159285749,'3',0000000000),(2,20,19,'Shahriar Kabir has send you a friend request.',20,1665159450529,'3',0000000000),(3,19,20,'s has send you a friend request.',19,1665159506180,'3',0000000000),(4,20,19,'Shahriar Kabir has send you a friend request.',20,1665159535684,'3',0000000000),(5,20,19,'Shahriar Kabir has send you a friend request.',20,1665159587858,'3',0000000000),(6,20,19,'Shahriar Kabir has send you a friend request.',20,1665159817210,'3',0000000000);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (8,'abcdewoi dogs ','[\"http://localhost:4000/posts/19/8/0.jpg\"]',19,'19267',1664695365624,0000000000,00000000);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_comments`
--

LOCK TABLES `post_comments` WRITE;
/*!40000 ALTER TABLE `post_comments` DISABLE KEYS */;
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
  `numFriends` int(10) unsigned zerofill DEFAULT NULL,
  `websocketid` varchar(70) DEFAULT NULL,
  `serviceworker_id` varchar(70) DEFAULT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (19,'s','sa','http://localhost:4000/profileImages/19.jpg','https://www.al.com/resizer/ILBcdq1ksZC39_8hhnJ_HXsP9j0=/800x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/NSDL77J3KJFZXCK3MFWAV7HMUE.JPG',NULL,'1',NULL,'s'),(20,'Shahriar Kabir','shahriar1234','http://localhost:4000/profileImages/20.jpg','https://www.al.com/resizer/ILBcdq1ksZC39_8hhnJ_HXsP9j0=/800x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/NSDL77J3KJFZXCK3MFWAV7HMUE.JPG',NULL,'1',NULL,'abcd');
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
INSERT INTO `user_interests` VALUES (19,'food');
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

-- Dump completed on 2022-10-08  1:37:30
