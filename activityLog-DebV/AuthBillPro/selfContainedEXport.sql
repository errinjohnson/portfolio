
SET FOREIGN_KEY_CHECKS = 0;
USE AuthBillProV2Demo;

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- ------------------------------------------------------
-- Server version	8.0.35

--
-- GTID state at the beginning of the backup 
--

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(100) NOT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `Expenditures`
--

DROP TABLE IF EXISTS `Expenditures`;
CREATE TABLE `Expenditures` (
  `ExpenditureID` int NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `CategoryID` int DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `PaymentMethodID` int DEFAULT NULL,
  `VendorID` int DEFAULT NULL,
  `Remit` int DEFAULT NULL,
  PRIMARY KEY (`ExpenditureID`),
  KEY `CategoryID` (`CategoryID`),
  KEY `PaymentMethodID` (`PaymentMethodID`),
  KEY `VendorID` (`VendorID`),
  CONSTRAINT `Expenditures_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`CategoryID`),
  CONSTRAINT `Expenditures_ibfk_2` FOREIGN KEY (`PaymentMethodID`) REFERENCES `PaymentMethods` (`PaymentMethodID`),
  CONSTRAINT `Expenditures_ibfk_3` FOREIGN KEY (`VendorID`) REFERENCES `Vendors` (`VendorID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `PaymentMethods`
--

DROP TABLE IF EXISTS `PaymentMethods`;
CREATE TABLE `PaymentMethods` (
  `PaymentMethodID` int NOT NULL AUTO_INCREMENT,
  `MethodName` varchar(50) NOT NULL,
  PRIMARY KEY (`PaymentMethodID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `Vendors`
--

DROP TABLE IF EXISTS `Vendors`;
CREATE TABLE `Vendors` (
  `VendorID` int NOT NULL AUTO_INCREMENT,
  `VendorName` varchar(100) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `Zip` varchar(20) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Website` varchar(100) DEFAULT NULL,
  `AccountNumber` varchar(50) DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`VendorID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
CREATE TABLE `activities` (
  `activity_id` int NOT NULL AUTO_INCREMENT,
  `activity_date` date NOT NULL,
  `actType_name` varchar(255) NOT NULL,
  `participant_id` int DEFAULT NULL,
  `actCase_notes` text NOT NULL,
  `actBillable_hours` decimal(10,2) NOT NULL,
  `auth_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`activity_id`),
  KEY `participant_id` (`participant_id`),
  KEY `activities_ibfk_2` (`auth_number`),
  CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`participant_id`),
  CONSTRAINT `activities_ibfk_2` FOREIGN KEY (`auth_number`) REFERENCES `auth` (`auth_number`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `activity_types`
--

DROP TABLE IF EXISTS `activity_types`;
CREATE TABLE `activity_types` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `auth`
--

DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth` (
  `auth_number` varchar(255) NOT NULL,
  `auth_begin_date` date NOT NULL,
  `auth_end_date` date NOT NULL,
  `auth_rate` decimal(10,2) NOT NULL,
  `auth_billable_hours` int NOT NULL,
  `auth_remaining_billable_hours` int NOT NULL,
  `participant_id` int DEFAULT NULL,
  `participant_last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`auth_number`),
  KEY `participant_id` (`participant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `invoice_details`
--

DROP TABLE IF EXISTS `invoice_details`;
CREATE TABLE `invoice_details` (
  `invoice_detail_id` int NOT NULL AUTO_INCREMENT,
  `invoice_id` int DEFAULT NULL,
  `actType_name` varchar(255) DEFAULT NULL,
  `actBillable_hours` decimal(10,2) DEFAULT NULL,
  `activity_date` date DEFAULT NULL,
  PRIMARY KEY (`invoice_detail_id`),
  KEY `invoice_id` (`invoice_id`),
  CONSTRAINT `invoice_details_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `invoice_id` int NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(50) NOT NULL,
  `auth_number` varchar(50) DEFAULT NULL,
  `invoice_date` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `participant_name` text,
  PRIMARY KEY (`invoice_id`),
  UNIQUE KEY `invoice_number` (`invoice_number`),
  KEY `auth_number` (`auth_number`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
CREATE TABLE `links` (
  `link_id` int NOT NULL AUTO_INCREMENT,
  `participant_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `link` text,
  PRIMARY KEY (`link_id`),
  KEY `participant_id` (`participant_id`),
  CONSTRAINT `links_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`participant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
CREATE TABLE `notes` (
  `note` text,
  `follow_up` date DEFAULT NULL,
  `status` tinytext,
  `name` text,
  `reminder` varchar(3) DEFAULT NULL,
  `note_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`note_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `participants`
--

DROP TABLE IF EXISTS `participants`;
CREATE TABLE `participants` (
  `participant_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `registration` date DEFAULT NULL,
  PRIMARY KEY (`participant_id`),
  UNIQUE KEY `unique_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `resources`
--

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `title` text,
  `link` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
SET FOREIGN_KEY_CHECKS = 1;

-- Dump completed on 2024-08-14  7:58:47