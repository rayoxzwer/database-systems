-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: db_assgnmt2
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `member_user_id` int NOT NULL,
  `house_number` varchar(10) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`member_user_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`member_user_id`) REFERENCES `member` (`member_user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (6,'256','Mangilik el','City3'),(7,'541','E251','City4'),(8,'171','Turan street','Astana'),(9,'303','E162','City5'),(18,'888','Sunset Avenue','City13'),(19,'999','River Lane','City14'),(20,'1010','Meadow Street','City15'),(21,'1111','Sunny Avenue','City16'),(22,'1212','Forest Lane','City17'),(23,'1313','Mountain Street','City18'),(24,'1414','Ocean Avenue','City19'),(25,'1515','Valley Lane','City20');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `appointment_id` int NOT NULL,
  `caregiver_user_id` int DEFAULT NULL,
  `member_user_id` int DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `appointment_time` time DEFAULT NULL,
  `work_hours` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `caregiver_user_id` (`caregiver_user_id`),
  KEY `member_user_id` (`member_user_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`caregiver_user_id`) REFERENCES `caregiver` (`caregiver_user_id`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`member_user_id`) REFERENCES `member` (`member_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,11,18,'2023-01-10','10:00:00',4,'Scheduled'),(2,12,19,'2023-02-15','14:30:00',5,'Confirmed'),(3,13,20,'2023-03-20','18:00:00',3,'Canceled'),(4,14,21,'2023-04-25','12:45:00',6,'Scheduled'),(5,15,22,'2023-05-30','16:20:00',2,'Confirmed'),(6,16,23,'2023-06-05','11:15:00',4,'Confirmed'),(7,17,24,'2023-07-11','17:30:00',3,'Scheduled'),(8,1,25,'2023-08-17','15:45:00',5,'Confirmed'),(9,2,6,'2023-07-11','15:30:00',3,'Scheduled'),(10,3,7,'2023-08-17','13:45:00',5,'Confirmed');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caregiver`
--

DROP TABLE IF EXISTS `caregiver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caregiver` (
  `caregiver_user_id` int NOT NULL,
  `photo` blob,
  `gender` varchar(10) DEFAULT NULL,
  `caregiving_type` varchar(255) DEFAULT NULL,
  `hourly_rate` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`caregiver_user_id`),
  CONSTRAINT `caregiver_ibfk_1` FOREIGN KEY (`caregiver_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caregiver`
--

LOCK TABLES `caregiver` WRITE;
/*!40000 ALTER TABLE `caregiver` DISABLE KEYS */;
INSERT INTO `caregiver` VALUES (1,_binary 'photo1','Male','Elderly Care',25.00),(2,_binary 'photo2','Female','Baby Sitter',20.00),(3,_binary 'photo3','Male','Special Needs Care',30.00),(4,_binary 'photo4','Female','Elderly Care',22.00),(5,_binary 'photo5','Male','Pet Care',8.00),(11,_binary 'photo11','Male','Baby Sitter',25.00),(12,_binary 'photo12','Male','Pet Care',18.00),(13,_binary 'photo13','Female','Baby Sitter',7.00),(14,_binary 'photo14','Male','Special Needs Care',30.00),(15,_binary 'photo15','Female','Elderly Care',5.00),(16,_binary 'photo16','Male','Baby Sitter',28.00),(17,_binary 'photo17','Female','Elderly Care',19.00);
/*!40000 ALTER TABLE `caregiver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job` (
  `job_id` int NOT NULL,
  `member_user_id` int DEFAULT NULL,
  `required_caregiving_type` varchar(255) DEFAULT NULL,
  `other_requirements` text,
  `date_posted` date DEFAULT NULL,
  PRIMARY KEY (`job_id`),
  KEY `member_user_id` (`member_user_id`),
  CONSTRAINT `job_ibfk_1` FOREIGN KEY (`member_user_id`) REFERENCES `member` (`member_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES (1,18,'Elderly Care','Assist with daily living activities, gentle.','2023-01-05'),(2,19,'Baby Sitter','Supervise and engage in educational activities.','2023-02-10'),(3,20,'Baby Sitter','Provide support for homework and learning.','2023-03-15'),(4,21,'Special Needs Care','Assist with therapy exercises.','2023-04-20'),(5,22,'Pet Care','Daily walks and feeding for pets.','2023-05-25'),(6,23,'Elderly Care','Companion care and assistance with daily tasks.','2023-06-01'),(7,24,'Baby Sitter','Create engaging and educational activities for children.','2023-07-07'),(8,25,'Special Needs Care','Provide support and assistance for individuals with special needs.','2023-08-13'),(9,6,'Pet Care','Daily walks and bla-bla.','2023-05-12'),(10,7,'Pet Care','Daily walks and feeding for pets. gentle.','2023-05-25'),(11,8,'Elderly Care','Assist with daily living.','2023-09-13');
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_application`
--

DROP TABLE IF EXISTS `job_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_application` (
  `caregiver_user_id` int DEFAULT NULL,
  `job_id` int DEFAULT NULL,
  `date_applied` date DEFAULT NULL,
  KEY `caregiver_user_id` (`caregiver_user_id`),
  KEY `job_application_ibfk_2` (`job_id`),
  CONSTRAINT `job_application_ibfk_1` FOREIGN KEY (`caregiver_user_id`) REFERENCES `caregiver` (`caregiver_user_id`),
  CONSTRAINT `job_application_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `job` (`job_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_application`
--

LOCK TABLES `job_application` WRITE;
/*!40000 ALTER TABLE `job_application` DISABLE KEYS */;
INSERT INTO `job_application` VALUES (11,1,'2023-01-02'),(12,2,'2023-02-12'),(13,3,'2023-03-18'),(14,4,'2023-04-22'),(15,5,'2023-05-28'),(16,6,'2023-06-03'),(17,7,'2023-07-09'),(1,8,'2023-08-15'),(3,10,'2023-02-15');
/*!40000 ALTER TABLE `job_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `job_applications_view`
--

DROP TABLE IF EXISTS `job_applications_view`;
/*!50001 DROP VIEW IF EXISTS `job_applications_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `job_applications_view` AS SELECT 
 1 AS `ja_job_id`,
 1 AS `ja_caregiver_user_id`,
 1 AS `caregiver_given_name`,
 1 AS `caregiver_surname`,
 1 AS `ja_date_applied`,
 1 AS `job_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `member_user_id` int NOT NULL,
  `house_rules` text,
  PRIMARY KEY (`member_user_id`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`member_user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (6,'Keep the living room tidy and organized.'),(7,'No smoking inside the house. Be punctual with meals.'),(8,'No pets.'),(9,'Assist with daily exercises and therapy.'),(18,'Keep the living room tidy and organized.'),(19,'No smoking inside the house. Be punctual with meals.'),(20,'Provide educational activities for the children.'),(21,'Assist with daily exercises and therapy.'),(22,'Care for the pets with love and attention.'),(23,'Ensure a safe and nurturing environment for the elderly.'),(24,'Create a positive and engaging atmosphere for children.'),(25,'Support individuals with special needs with patience and care.');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `given_name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `profile_description` text,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1@email.com','John','Doe','City21','1234567890','Caregiver with experience in elderly care.','password1'),(2,'user2@email.com','Jane','Smith','City22','9876543210','Friendly and responsible caregiver.','password2'),(3,'user3@email.com','Berik','Johnson','Astana','5551234567','Loving caregiver for children.','password3'),(4,'user4@email.com','Kulpash','Palenshe','Astana','3339876543','Experienced caregiver for special needs.','password4'),(5,'user5@email.com','Daniel','Davis','City2','1112345678','Detail-oriented and reliable caregiver.','password5'),(6,'user6@email.com','Bolat','Bolatov','City3','1234567890','Caregiver with experience in elderly care.','password1'),(7,'user7@email.com','Sasha','Sarsenbi','City4','9876543210','Friendly and responsible caregiver.','password2'),(8,'user8@email.com','Askar','Askarov','Astana','5634785216','Loving caregiver for children.','password3'),(9,'user9@email.com','Aigul','Bakbergen','City5','3339876543','Experienced caregiver for special needs.','password4'),(11,'user11@email.com','Sophia','Wilson','City6','5551112233','Experienced caregiver for the elderly.','password11'),(12,'user12@email.com','Oliver','Taylor','City7','7778889999','Responsible caregiver with a compassionate approach.','password12'),(13,'user13@email.com','Emma','Moore','City8','1112223333','Patient and caring caregiver for children.','password13'),(14,'user14@email.com','Liam','Miller','City9','4445556666','Attentive caregiver for individuals with special needs.','password14'),(15,'user15@email.com','Ava','Anderson','City10','9998887777','Enthusiastic caregiver for pets.','password15'),(16,'user16@email.com','Noah','Thomas','City11','1234567890','Experienced caregiver for seniors.','password16'),(17,'user17@email.com','Mia','Brown','City12','9876543210','Reliable caregiver for children.','password17'),(18,'user18@email.com','Ethan','Martinez','City13','5551234567','Compassionate caregiver for special needs individuals.','password18'),(19,'user19@email.com','Isabella','Garcia','City14','3339876543','Patient caregiver with a focus on education.','password19'),(20,'user20@email.com','Lucas','Jones','City15','1112345678','Responsible caregiver for pets.','password20'),(21,'user21@email.com','Aiden','Smith','City16','2223334444','Caring and energetic caregiver for children.','password21'),(22,'user22@email.com','Chloe','Davis','City17','7776665555','Attentive caregiver for individuals with special needs.','password22'),(23,'user23@email.com','Jackson','Wilson','City18','4445556666','Experienced caregiver for the elderly.','password23'),(24,'user24@email.com','Sophie','Taylor','City19','9998887777','Responsible caregiver with a compassionate approach.','password24'),(25,'user25@email.com','Mason','Moore','City20','1234567890','Patient and caring caregiver for children.','password25');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `job_applications_view`
--

/*!50001 DROP VIEW IF EXISTS `job_applications_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `job_applications_view` AS select `job_application`.`job_id` AS `ja_job_id`,`job_application`.`caregiver_user_id` AS `ja_caregiver_user_id`,`user`.`given_name` AS `caregiver_given_name`,`user`.`surname` AS `caregiver_surname`,`job_application`.`date_applied` AS `ja_date_applied`,`job`.`job_id` AS `job_id` from (((`job_application` join `caregiver` on((`caregiver`.`caregiver_user_id` = `job_application`.`caregiver_user_id`))) join `job` on((`job`.`job_id` = `job_application`.`job_id`))) join `user` on((`user`.`user_id` = `caregiver`.`caregiver_user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-21 21:52:05
