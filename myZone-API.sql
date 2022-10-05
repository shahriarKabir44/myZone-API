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
-- Table structure for table `friendship`
--

DROP TABLE IF EXISTS `friendship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friendship` (
  `friend1` int NOT NULL,
  `friend2` int NOT NULL,
  `friendship_type` int NOT NULL,
  `initiation_time` varchar(45) NOT NULL,
  KEY `initiator_idx` (`friend1`),
  KEY `target_idx` (`friend2`),
  CONSTRAINT `initiator` FOREIGN KEY (`friend1`) REFERENCES `user` (`Id`),
  CONSTRAINT `target` FOREIGN KEY (`friend2`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `conversation_id` int NOT NULL,
  `sender` int NOT NULL,
  `body` longtext NOT NULL,
  `time` int NOT NULL,
  KEY `conversation_idx` (`conversation_id`),
  KEY `sender_idx` (`sender`),
  CONSTRAINT `conversation` FOREIGN KEY (`conversation_id`) REFERENCES `conversation` (`Id`),
  CONSTRAINT `message_sender` FOREIGN KEY (`sender`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `body` varchar(45) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-05 15:01:22
