-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: my_zone
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `conversation`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `conversation` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `participant1` int DEFAULT NULL,
  `participant2` int DEFAULT NULL,
  `last_message` mediumtext,
  `time` bigint DEFAULT NULL,
  `is_group_conversation` int DEFAULT NULL,
  `receiver` int DEFAULT NULL,
  `isSeen` int(10) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_conversation_participant2` (`participant2`),
  CONSTRAINT `fk_conversation_participant2` FOREIGN KEY (`participant2`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation`
--

LOCK TABLES `conversation` WRITE;
/*!40000 ALTER TABLE `conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `featured_post`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `featured_post` (
  `photoURL` mediumtext,
  `groupId` int DEFAULT NULL,
  KEY `fk_featured_post_groupId` (`groupId`),
  CONSTRAINT `fk_featured_post_groupId` FOREIGN KEY (`groupId`) REFERENCES `featured_post_group` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featured_post`
--

LOCK TABLES `featured_post` WRITE;
/*!40000 ALTER TABLE `featured_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `featured_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `featured_post_group`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `featured_post_group` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(45) DEFAULT NULL,
  `createdBy` int DEFAULT NULL,
  `numPosts` int(10) unsigned zerofill DEFAULT NULL,
  `initialPhoto` mediumtext,
  PRIMARY KEY (`Id`),
  KEY `fk_featured_post_group_createdBy` (`createdBy`),
  CONSTRAINT `fk_featured_post_group_createdBy` FOREIGN KEY (`createdBy`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featured_post_group`
--

LOCK TABLES `featured_post_group` WRITE;
/*!40000 ALTER TABLE `featured_post_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `featured_post_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendship`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `friendship` (
  `friend1` int DEFAULT NULL,
  `friend2` int DEFAULT NULL,
  `friendship_type` int DEFAULT NULL,
  `initiation_time` bigint DEFAULT NULL,
  KEY `fk_friendship_friend1` (`friend1`),
  KEY `fk_friendship_friend2` (`friend2`),
  CONSTRAINT `fk_friendship_friend1` FOREIGN KEY (`friend1`) REFERENCES `user` (`Id`),
  CONSTRAINT `fk_friendship_friend2` FOREIGN KEY (`friend2`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendship`
--

LOCK TABLES `friendship` WRITE;
/*!40000 ALTER TABLE `friendship` DISABLE KEYS */;
/*!40000 ALTER TABLE `friendship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_conversation`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `group_conversation` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `created_by` int DEFAULT NULL,
  `room_name` varchar(45) DEFAULT NULL,
  `group_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_group_conversation_created_by` (`created_by`),
  CONSTRAINT `fk_group_conversation_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`Id`)
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

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `group_conversation_members` (
  `groupId` int DEFAULT NULL,
  `memberId` int DEFAULT NULL,
  KEY `fk_group_conversation_members_groupId` (`groupId`),
  KEY `fk_group_conversation_members_memberId` (`memberId`),
  CONSTRAINT `fk_group_conversation_members_groupId` FOREIGN KEY (`groupId`) REFERENCES `group_conversation` (`Id`),
  CONSTRAINT `fk_group_conversation_members_memberId` FOREIGN KEY (`memberId`) REFERENCES `user` (`Id`)
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

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `interest_names` (
  `interest_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interest_names`
--

LOCK TABLES `interest_names` WRITE;
/*!40000 ALTER TABLE `interest_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `interest_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `message` (
  `conversationId` int DEFAULT NULL,
  `sender` int DEFAULT NULL,
  `body` mediumtext,
  `time` bigint DEFAULT NULL,
  KEY `fk_message_conversationId` (`conversationId`),
  KEY `fk_message_sender` (`sender`),
  CONSTRAINT `fk_message_conversationId` FOREIGN KEY (`conversationId`) REFERENCES `conversation` (`Id`),
  CONSTRAINT `fk_message_sender` FOREIGN KEY (`sender`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `notification` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `senderId` int DEFAULT NULL,
  `receiverId` int DEFAULT NULL,
  `body` mediumtext,
  `relatedSchemaId` int DEFAULT NULL,
  `time` bigint DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `isSeen` int(10) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `post` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `body` mediumtext,
  `attached_media` mediumtext,
  `posted_by` int DEFAULT NULL,
  `posted_day` varchar(15) DEFAULT NULL,
  `posted_on` bigint DEFAULT NULL,
  `numReactions` int(10) unsigned zerofill DEFAULT NULL,
  `numComments` bigint(8) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_post_posted_by` (`posted_by`),
  CONSTRAINT `fk_post_posted_by` FOREIGN KEY (`posted_by`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_comments`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `post_comments` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `commentBody` mediumtext,
  `commentedBy` int DEFAULT NULL,
  `postId` int DEFAULT NULL,
  `time` bigint DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_post_comments_commentedBy` (`commentedBy`),
  KEY `fk_post_comments_postId` (`postId`),
  CONSTRAINT `fk_post_comments_commentedBy` FOREIGN KEY (`commentedBy`) REFERENCES `user` (`Id`),
  CONSTRAINT `fk_post_comments_postId` FOREIGN KEY (`postId`) REFERENCES `post` (`Id`)
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

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `post_reactions` (
  `postId` int DEFAULT NULL,
  `reactedBy` int DEFAULT NULL,
  `time` bigint DEFAULT NULL,
  KEY `fk_post_reactions_reactedBy` (`reactedBy`),
  KEY `fk_post_reactions_postId` (`postId`),
  CONSTRAINT `fk_post_reactions_postId` FOREIGN KEY (`postId`) REFERENCES `post` (`Id`),
  CONSTRAINT `fk_post_reactions_reactedBy` FOREIGN KEY (`reactedBy`) REFERENCES `user` (`Id`)
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

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `profileImage` mediumtext,
  `coverPhoto` mediumtext,
  `numFriends` int(10) unsigned zerofill DEFAULT NULL,
  `websocketid` varchar(2) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `numUnseenNotification` int(10) unsigned zerofill DEFAULT NULL,
  `numNewFriendRequests` int(10) unsigned zerofill DEFAULT NULL,
  `numUnseenMessages` int(10) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_interests`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_interests` (
  `userId` int DEFAULT NULL,
  `interestName` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_interests`
--

LOCK TABLES `user_interests` WRITE;
/*!40000 ALTER TABLE `user_interests` DISABLE KEYS */;
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

-- Dump completed on 2023-12-27 11:21:48
