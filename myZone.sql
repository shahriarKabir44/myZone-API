-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: my_zone
-- ------------------------------------------------------
-- Server version	8.0.31

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation`
--

LOCK TABLES `conversation` WRITE;
/*!40000 ALTER TABLE `conversation` DISABLE KEYS */;
INSERT INTO `conversation` VALUES (2,21,19,'hi bro',1665758245760,0,21,0000000000),(3,19,22,'hey',1665752769009,0,22,0000000001);
/*!40000 ALTER TABLE `conversation` ENABLE KEYS */;
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
INSERT INTO `featured_post` VALUES ('/posts/21/9/1.jpg',6);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featured_post_group`
--

LOCK TABLES `featured_post_group` WRITE;
/*!40000 ALTER TABLE `featured_post_group` DISABLE KEYS */;
INSERT INTO `featured_post_group` VALUES (6,'food',21,0000000001,'/posts/21/9/1.jpg');
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
INSERT INTO `friendship` VALUES (21,19,1,1665747563859),(19,21,1,1665747563859),(19,22,1,1665747679790),(22,19,1,1665747679790);
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
INSERT INTO `interest_names` VALUES ('food'),('games');
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
INSERT INTO `message` VALUES (2,21,'hello',1665705629736),(2,21,'hi',1665705631841),(2,19,'hi',1665706063088),(2,21,'hi',1665734228739),(2,21,'hello',1665734238027),(2,21,'good day',1665734279474),(2,21,'hi',1665734306418),(2,21,'hello',1665734423315),(2,21,'good day',1665734455068),(2,21,'yo',1665734552203),(2,21,'hello',1665735359098),(2,21,'morning',1665735876486),(2,21,'hi',1665735902766),(2,21,'nice day',1665735926846),(2,21,'hiii',1665735952051),(2,21,'hi',1665736202242),(2,21,'hi',1665736247914),(2,21,'morning!',1665736272475),(2,21,'good day',1665736294730),(2,21,'hi',1665736366227),(2,21,'good day',1665736373227),(2,21,'hi',1665736417363),(2,21,'nice day',1665736442899),(2,21,'good',1665736488640),(3,22,'hi',1665747814090),(3,19,'hello',1665747828708),(3,22,'good dat',1665747876835),(3,22,'hi there',1665747962059),(3,19,'hi',1665748030141),(3,22,'hello',1665748039023),(3,19,'good day',1665748049413),(3,22,'nice',1665748067851),(2,19,'hi',1665749248075),(3,22,'hi',1665749791308),(2,19,'good day',1665749801660),(3,19,'good day',1665749849268),(3,19,'hi',1665749945530),(3,19,'hi',1665752198694),(3,22,'good day',1665752223652),(3,19,'howdy',1665752336717),(3,22,'hi',1665752644921),(3,19,'hi',1665752747372),(3,22,'hello',1665752755879),(3,19,'hey',1665752769009),(2,21,'hi',1665757949178),(2,19,'hello',1665757962152),(2,21,'howdy',1665757992056),(2,19,'hi',1665758007450),(2,21,'good day',1665758017583),(2,19,'hi bro',1665758245760);
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (20,19,21,'s has send you a friend request.',19,1665702734187,'3',0000000000),(21,21,19,'shahriar kabir has accepted request.',21,1665702740690,'3',0000000000),(22,19,21,'s has send you a friend request.',19,1665703127849,'3',0000000000),(23,21,19,'shahriar kabir has accepted your friend request.',21,1665703136912,'3',0000000000),(24,21,19,'shahriar kabir has accepted your friend request.',21,1665703214629,'3',0000000000),(25,21,19,'shahriar kabir has send you a friend request.',21,1665747563836,'3',0000000000),(26,19,21,'s has accepted your friend request.',19,1665747576541,'3',0000000000),(27,19,22,'s has send you a friend request.',19,1665747679783,'3',0000000000),(28,22,19,'Rahul Islam has accepted your friend request.',22,1665747700968,'3',0000000000);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (8,'abcdewoi dogs ','[\"/posts/19/8/0.jpg\"]',19,'19267',1664695365624,0000000000,00000000),(9,'food','[\"/posts/21/9/1.jpg\",\"/posts/21/9/0.jpg\"]',21,'19278',1665680981694,0000000000,00000000);
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
  `numFriends` int(10) unsigned zerofill DEFAULT '0000000000',
  `websocketid` varchar(70) DEFAULT NULL,
  `password` varchar(45) NOT NULL,
  `numUnseenNotification` int(10) unsigned zerofill DEFAULT '0000000000',
  `numNewFriendRequests` int(10) unsigned zerofill DEFAULT '0000000000',
  `numUnseenMessages` int(10) unsigned zerofill DEFAULT '0000000000',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (19,'s','sa','/profileImages/19.jpg','/stockCoverPhoto.jpg',0000000002,'1','s',0000000000,0000000000,0000000000),(20,'Shahriar Kabir','shahriar1234','/profileImages/20.jpg','/stockCoverPhoto.jpg',0000000000,'0','abcd',0000000000,0000000000,0000000000),(21,'shahriar kabir','shahriar kabir','/profileImages/21.jpg','/stockCoverPhoto.jpg',0000000001,'1','abc',0000000000,0000000000,0000000000),(22,'Rahul Islam','rahul','/profileImages/22.jpg','/stockCoverPhoto.jpg',0000000001,'1','abcd',0000000000,0000000000,0000000000);
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
INSERT INTO `user_interests` VALUES (21,'food');
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

-- Dump completed on 2022-10-14 22:49:22
