 
CREATE TABLE `user` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `profileImage` varchar(45) DEFAULT NULL,
  `coverPhoto` varchar(45) DEFAULT NULL,
  `numFriends` varchar(45) DEFAULT NULL,
  `websocketid` varchar(70) DEFAULT NULL,
  `serviceworker_id` varchar(70) DEFAULT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 CREATE TABLE `interest_names` (
  `interest_name` varchar(45) NOT NULL,
  PRIMARY KEY (`interest_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user_interests` (
  `userId` int NOT NULL,
  `interestName` varchar(45) NOT NULL,
  KEY `user_idx` (`userId`),
  KEY `interest_name_idx` (`interestName`),
  CONSTRAINT `interest_name` FOREIGN KEY (`interestName`) REFERENCES `interest_names` (`interest_name`),
  CONSTRAINT `user` FOREIGN KEY (`userId`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 

 
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `body` varchar(45) DEFAULT NULL,
  `attached_media` varchar(110) DEFAULT NULL,
  `posted_by` int NOT NULL,
  `posted_day` varchar(15) NOT NULL,
  `posted_on` int NOT NULL,
  `numReactions` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `postedby_idx` (`posted_by`),
  CONSTRAINT `postedby` FOREIGN KEY (`posted_by`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


 
CREATE TABLE `post_reactions` (
  `postId` int NOT NULL,
  `reactedBy` int NOT NULL,
  `time` varchar(45) NOT NULL,
  KEY `reacted_on_idx` (`postId`),
  KEY `reacted_by_idx` (`reactedBy`),
  CONSTRAINT `reacted_by` FOREIGN KEY (`reactedBy`) REFERENCES `user` (`Id`),
  CONSTRAINT `reacted_on` FOREIGN KEY (`postId`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

  
CREATE TABLE `post_comments` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `commentBody` longtext NOT NULL,
  `commentedBy` int NOT NULL,
  `postId` int NOT NULL,
  `time` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `commentedOn_idx` (`postId`),
  KEY `commentedBy_idx` (`commentedBy`),
  CONSTRAINT `commentedBy` FOREIGN KEY (`commentedBy`) REFERENCES `user` (`Id`),
  CONSTRAINT `commentedOn` FOREIGN KEY (`postId`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 
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

 
CREATE TABLE `group_conversation` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `created_by` int NOT NULL,
  `room_name` varchar(45) NOT NULL,
  `group_name` varchar(45) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `group_conv_creator_idx` (`created_by`),
  CONSTRAINT `group_conv_creator` FOREIGN KEY (`created_by`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



 
CREATE TABLE `message` (
  `conversation_id` int NOT NULL,
  `sender` int NOT NULL,
  `body` varchar(45) NOT NULL,
  `time` int NOT NULL,
  KEY `conversation_idx` (`conversation_id`),
  KEY `sender_idx` (`sender`),
  CONSTRAINT `conversation` FOREIGN KEY (`conversation_id`) REFERENCES `conversation` (`Id`),
  CONSTRAINT `message_sender` FOREIGN KEY (`sender`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


 
CREATE TABLE `group_conversation_members` (
  `groupId` int NOT NULL,
  `memberId` int NOT NULL,
  KEY `groupId_idx` (`groupId`),
  KEY `memberId_idx` (`memberId`),
  CONSTRAINT `groupId` FOREIGN KEY (`groupId`) REFERENCES `group_conversation` (`Id`),
  CONSTRAINT `memberId` FOREIGN KEY (`memberId`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


 
CREATE TABLE `featured_post_group` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(45) NOT NULL,
  `createdBy` int NOT NULL,
  `numPosts` int(10) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `featurer_idx` (`createdBy`),
  CONSTRAINT `featurer` FOREIGN KEY (`createdBy`) REFERENCES `user` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


 
CREATE TABLE `featured_post` (
  `postId` int NOT NULL,
  `groupId` int NOT NULL,
  KEY `featured_idx` (`postId`),
  KEY `featured_group_idx` (`groupId`),
  CONSTRAINT `featured` FOREIGN KEY (`postId`) REFERENCES `post` (`id`),
  CONSTRAINT `featured_group` FOREIGN KEY (`groupId`) REFERENCES `featured_post_group` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;