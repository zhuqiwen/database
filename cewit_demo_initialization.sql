-- MySQL
-- Created by QIWEN_ZHU
-- Host: 127.0.0.1    Database: cewit
-- ------------------------------------------------------
-- Server version	5.7
-- Mac OS X El Capitan 10.11.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- the following is for root user to create database for cewit users
-- after creating the database, 
-- grant all privileges on cewit_demo.* to 'cewit'@'localhost' identified by 'cewit';
-- flush privileges;
-- exit and use cewit to login

DROP SCHEMA IF EXISTS cewit_demo;
CREATE SCHEMA cewit_demo   
   DEFAULT CHARACTER SET utf8
   DEFAULT COLLATE utf8_general_ci;
USE cewit_demo;
-- disable autocommit
SET AUTOCOMMIT=0;


-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'affliate'
-- 
-- ---

DROP TABLE IF EXISTS `affliate`;
		
CREATE TABLE `affliate` (
  `af_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `first_name` CHAR(255) NOT NULL,
  `last_name` CHAR(255) NOT NULL,
  `gender` ENUM(3) NOT NULL,
  `email` CHAR(255) NOT NULL,
  `is_active` TINYINT(1) NOT NULL,
  `join_date` DATE NOT NULL,
  `street` CHAR(255) NOT NULL,
  `city` CHAR(255) NOT NULL,
  `state` CHAR(255) NOT NULL,
  `iu_id` CHAR(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`af_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'cewit_program'
-- 
-- ---

DROP TABLE IF EXISTS `cewit_program`;
		
CREATE TABLE `cewit_program` (
  `program_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) NOT NULL,
  `lead` CHAR(255) NOT NULL,
  `target` CHAR(255) NOT NULL,
  `date` DATE NOT NULL,
  `location` CHAR(255) NOT NULL,
  `contact_first_name` CHAR(255) NOT NULL,
  `contact_last_name` CHAR(255) NOT NULL,
  `contact_email` CHAR(255) NOT NULL,
  `note` CHAR(255) NOT NULL,
  `attendance` INTEGER NOT NULL COMMENT 'this redundancy is for easy query',
  PRIMARY KEY (`program_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'c_program_attendance'
-- 
-- ---

DROP TABLE IF EXISTS `c_program_attendance`;
		
CREATE TABLE `c_program_attendance` (
  `attendance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `program_id_cewit_program` INTEGER(10) NOT NULL,
  `af_id_affliate` INTEGER(10) NOT NULL,
  PRIMARY KEY (`attendance_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'academic_program'
-- 
-- ---

DROP TABLE IF EXISTS `academic_program`;
		
CREATE TABLE `academic_program` (
  `program_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `major` CHAR(255) NOT NULL,
  `degree` CHAR(255) NOT NULL,
  `field` CHAR(255) NOT NULL,
  `type` CHAR(255) NOT NULL COMMENT 'academic or professional or phd or graduate or college',
  `school` CHAR(255) NOT NULL,
  PRIMARY KEY (`program_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'a_program_enrollment'
-- 
-- ---

DROP TABLE IF EXISTS `a_program_enrollment`;
		
CREATE TABLE `a_program_enrollment` (
  `enrollment_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `program_id_academic_program` INTEGER(10) NOT NULL,
  `af_id_affliate` INTEGER(10) NOT NULL,
  `start_time` DATE NOT NULL,
  `end_time` DATE NOT NULL,
  PRIMARY KEY (`enrollment_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'skill'
-- 
-- ---

DROP TABLE IF EXISTS `skill`;
		
CREATE TABLE `skill` (
  `skill_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `skill_name` CHAR(255) NOT NULL COMMENT 'c or c++ or python, etc',
  PRIMARY KEY (`skill_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'has_skill'
-- bridging entity connecting table skill and table affiliate
-- ---

DROP TABLE IF EXISTS `has_skill`;
		
CREATE TABLE `has_skill` (
  `has_skill_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `af_id_affliate` INTEGER(10) NOT NULL,
  `skill_id_skill` INTEGER(10) NOT NULL,
  PRIMARY KEY (`has_skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- COMMENT 'bridging entity connecting table skill and table affiliate'


-- ---
-- Table 'interest'
-- more general than skill table; leadership, teaching, app development, social media, digital humanities, etc.
-- ---

DROP TABLE IF EXISTS `interest`;
		
CREATE TABLE `interest` (
  `interest_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `interest_name` CHAR(255) NOT NULL,
  PRIMARY KEY (`interest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- COMMENT 'more general than skill table; leadership, teaching, app dev'

-- ---
-- Table 'is_interested'
-- 
-- ---

DROP TABLE IF EXISTS `is_interested`;
		
CREATE TABLE `is_interested` (
  `is_interested_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `af_id_affliate` INTEGER(10) NOT NULL,
  `interest_id_interest` INTEGER(10) NOT NULL,
  PRIMARY KEY (`is_interested_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'employer'
-- 
-- ---

DROP TABLE IF EXISTS `employer`;
		
CREATE TABLE `employer` (
  `employer_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `name` CHAR(255) NOT NULL,
  `type` ENUM NOT NULL COMMENT 'academic, corporate, public service, military, ngo',
  `city` CHAR(255) NOT NULL,
  `state` CHAR(255) NOT NULL,
  `country` CHAR(255) NOT NULL,
  PRIMARY KEY (`employer_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'employment'
-- 
-- ---

DROP TABLE IF EXISTS `employment`;
		
CREATE TABLE `employment` (
  `employment_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `employer_id_employer` INTEGER(10) NOT NULL,
  `people_id_people` INTEGER(10) NOT NULL DEFAULT NULL,
  PRIMARY KEY (`employment_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'corporate_sponsor'
-- 
-- ---

DROP TABLE IF EXISTS `corporate_sponsor`;
		
CREATE TABLE `corporate_sponsor` (
  `cs_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `af_id_affliate` INTEGER(10) NOT NULL,
  `company` CHAR(255) NOT NULL,
  `city` CHAR(255) NOT NULL,
  `state` CHAR(255) NOT NULL,
  `country` CHAR(255) NOT NULL,
  `type` CHAR(255) NOT NULL,
  PRIMARY KEY (`cs_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'other'
-- 
-- ---

DROP TABLE IF EXISTS `other`;
		
CREATE TABLE `other` (
  `other_id` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `af_id_affliate` INTEGER(10) NOT NULL,
  PRIMARY KEY (`other_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Table 'people'
-- 
-- ---

DROP TABLE IF EXISTS `people`;
		
CREATE TABLE `people` (
  `people_id` INTEGER(10) NOT NULL AUTO_INCREMENT DEFAULT NULL,
  `title_rank` CHAR(255) NOT NULL DEFAULT 'NULL',
  `department` CHAR(255) NULL DEFAULT NULL,
  `school` CHAR(255) NULL DEFAULT NULL,
  `job_research_area` CHAR(255) NULL DEFAULT NULL,
  `is_iuwit_lt_member` TINYINT(1) NOT NULL,
  `is_cewit_staff` TINYINT(1) NOT NULL,
  `is_ac_member` TINYINT(1) NOT NULL,
  `is_circles_participant` TINYINT(1) NOT NULL,
  `is_circles_leader` TINYINT(1) NOT NULL,
  `is_flt_member` TINYINT(1) NOT NULL,
  `is_alt_member` TINYINT(1) NOT NULL,
  `is_volunteer` TINYINT(1) NOT NULL,
  `is_intern` TINYINT(1) NOT NULL,
  `is_fulltime` TINYINT(1) NOT NULL,
  `is_faculty` TINYINT(1) NOT NULL,
  `is_staff` TINYINT(1) NOT NULL,
  `is_alumnae` TINYINT(1) NOT NULL,
  `af_id_affliate` INTEGER(10) NOT NULL,
  PRIMARY KEY (`people_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `c_program_attendance` ADD FOREIGN KEY (program_id_cewit_program) REFERENCES `cewit_program` (`program_id`);
ALTER TABLE `c_program_attendance` ADD FOREIGN KEY (af_id_affliate) REFERENCES `affliate` (`af_id`);
ALTER TABLE `a_program_enrollment` ADD FOREIGN KEY (program_id_academic_program) REFERENCES `academic_program` (`program_id`);
ALTER TABLE `a_program_enrollment` ADD FOREIGN KEY (af_id_affliate) REFERENCES `affliate` (`af_id`);
ALTER TABLE `has_skill` ADD FOREIGN KEY (af_id_affliate) REFERENCES `affliate` (`af_id`);
ALTER TABLE `has_skill` ADD FOREIGN KEY (skill_id_skill) REFERENCES `skill` (`skill_id`);
ALTER TABLE `is_interested` ADD FOREIGN KEY (af_id_affliate) REFERENCES `affliate` (`af_id`);
ALTER TABLE `is_interested` ADD FOREIGN KEY (interest_id_interest) REFERENCES `interest` (`interest_id`);
ALTER TABLE `employment` ADD FOREIGN KEY (employer_id_employer) REFERENCES `employer` (`employer_id`);
ALTER TABLE `employment` ADD FOREIGN KEY (people_id_people) REFERENCES `people` (`people_id`);
ALTER TABLE `corporate_sponsor` ADD FOREIGN KEY (af_id_affliate) REFERENCES `affliate` (`af_id`);
ALTER TABLE `other` ADD FOREIGN KEY (af_id_affliate) REFERENCES `affliate` (`af_id`);
ALTER TABLE `people` ADD FOREIGN KEY (af_id_affliate) REFERENCES `affliate` (`af_id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `affliate` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `cewit_program` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `c_program_attendance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `academic_program` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `a_program_enrollment` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `skill` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `has_skill` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `interest` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `is_interested` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `employer` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `employment` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `corporate_sponsor` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `other` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `people` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `affliate` (`af_id`,`first_name`,`last_name`,`gender`,`email`,`is_active`,`join_date`,`street`,`city`,`state`,`iu_id`) VALUES
-- ('','','','','','','','','','','');
-- INSERT INTO `cewit_program` (`program_id`,`name`,`lead`,`target`,`date`,`location`,`contact_first_name`,`contact_last_name`,`contact_email`,`note`,`attendance`) VALUES
-- ('','','','','','','','','','','');
-- INSERT INTO `c_program_attendance` (`attendance_id`,`program_id_cewit_program`,`af_id_affliate`) VALUES
-- ('','','');
-- INSERT INTO `academic_program` (`program_id`,`major`,`degree`,`field`,`type`,`school`) VALUES
-- ('','','','','','');
-- INSERT INTO `a_program_enrollment` (`enrollment_id`,`program_id_academic_program`,`af_id_affliate`,`start_time`,`end_time`) VALUES
-- ('','','','','');
-- INSERT INTO `skill` (`skill_id`,`skill_name`) VALUES
-- ('','');
-- INSERT INTO `has_skill` (`has_skill_id`,`af_id_affliate`,`skill_id_skill`) VALUES
-- ('','','');
-- INSERT INTO `interest` (`interest_id`,`interest_name`) VALUES
-- ('','');
-- INSERT INTO `is_interested` (`is_interested_id`,`af_id_affliate`,`interest_id_interest`) VALUES
-- ('','','');
-- INSERT INTO `employer` (`employer_id`,`name`,`type`,`city`,`state`,`country`) VALUES
-- ('','','','','','');
-- INSERT INTO `employment` (`employment_id`,`employer_id_employer`,`people_id_people`) VALUES
-- ('','','');
-- INSERT INTO `corporate_sponsor` (`cs_id`,`af_id_affliate`,`company`,`city`,`state`,`country`,`type`) VALUES
-- ('','','','','','','');
-- INSERT INTO `other` (`other_id`,`af_id_affliate`) VALUES
-- ('','');
-- INSERT INTO `people` (`people_id`,`title_rank`,`department`,`school`,`job_research_area`,`is_iuwit_lt_member`,`is_cewit_staff`,`is_ac_member`,`is_circles_participant`,`is_circles_leader`,`is_flt_member`,`is_alt_member`,`is_volunteer`,`is_intern`,`is_fulltime`,`is_faculty`,`is_staff`,`is_alumnae`,`af_id_affliate`) VALUES
-- ('','','','','','','','','','','','','','','','','','','');
