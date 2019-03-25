/*
SQLyog Community v12.16 (64 bit)
MySQL - 5.5.46 : Database - tmp3
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `answers` */

DROP TABLE IF EXISTS `answers`;

CREATE TABLE `answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `filepath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=latin1;

/*Data for the table `answers` */

insert  into `answers`(`id`,`question_id`,`title`,`filepath`) values 
(75,18,'2 Times',''),
(76,18,'Only Weekend',''),
(77,18,'Every day',''),
(78,19,'No, I don\'t follow any',''),
(79,19,'No, but I\'m trying to avoid fatty foods',''),
(80,19,'Yes, I do',''),
(81,20,'I have never visited it',''),
(82,20,'I\'m planning to play Zumba next week',''),
(83,20,'It was a great experience',''),
(84,20,'Sorry, I didn\'t like it',''),
(85,21,'Less than an hour',''),
(86,21,'It depends on my trainer',''),
(87,21,'Several hours',''),
(88,23,'Yes, I already bought some clothes',''),
(89,23,'Yes, but I can\'t afford it ',''),
(90,23,'No, I didn\'t like the merchandise',''),
(91,23,'I didn\'t know about it','');

/*Table structure for table `questions` */

DROP TABLE IF EXISTS `questions`;

CREATE TABLE `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `type` enum('open','single','multi') DEFAULT NULL,
  `filepath` varchar(255) DEFAULT NULL,
  `is_required` enum('T','F') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

/*Data for the table `questions` */

insert  into `questions`(`id`,`survey_id`,`title`,`description`,`type`,`filepath`,`is_required`) values 
(18,1,'Question 1: How often do you visit our gym? ','Please, tell us the weekly frequency of your gym visitations.','single','Desert.jpg','T'),
(19,1,'Question 2: Do you follow any food restrictions?','We need to know your food regime.','single','Koala.jpg','T'),
(20,1,'Question 3: Do you like our new Zumba class?','It\'s a new class and we need to know how do you rate it.','multi',NULL,'T'),
(21,1,'Question 4: How many hours do you spend in the gym?','The continuous training ensures faster results','single',NULL,'F'),
(22,1,'Question 5: Tell us your favorite fitness equipment.','Your answer will help us improve our equipment','open',NULL,'T'),
(23,1,'Question 6: Do you like our new play-wear shop?','We offer big choice of wedges, tracksuits and sneakers','single',NULL,'F');

/*Table structure for table `survey_answers` */

DROP TABLE IF EXISTS `survey_answers`;

CREATE TABLE `survey_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer_id` int(11) DEFAULT NULL,
  `open_answer` text,
  `is_valid` enum('T','F') DEFAULT 'T',
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=latin1;

/*Data for the table `survey_answers` */

insert  into `survey_answers`(`id`,`survey_id`,`user_id`,`question_id`,`answer_id`,`open_answer`,`is_valid`,`created`) values 
(91,1,1,23,91,NULL,'T','2019-03-24 21:29:05'),
(92,1,1,22,NULL,'[dsadasd ad]','T','2019-03-24 21:29:05'),
(93,1,1,20,82,NULL,'T','2019-03-24 21:29:05'),
(94,1,1,20,83,NULL,'T','2019-03-24 21:29:05'),
(95,1,1,18,77,NULL,'T','2019-03-24 21:29:05'),
(96,1,1,19,79,NULL,'T','2019-03-24 21:29:05');

/*Table structure for table `surveys` */

DROP TABLE IF EXISTS `surveys`;

CREATE TABLE `surveys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `expiration_dt` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `surveys` */

insert  into `surveys`(`id`,`name`,`description`,`expiration_dt`,`created`) values 
(1,'Fitness Evaluation','We would like to help you to get in shape fast. So, please, let us know your food regime and fitness program.','2019-03-25 10:00:00','2019-03-24 14:31:07');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fName` varchar(255) DEFAULT NULL,
  `lName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `pass` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`fName`,`lName`,`email`,`pass`,`phone`,`address`,`modified`) values 
(1,'Test','User','null@stivasoft.com','pass','12345678901','Address 33','2019-03-03 17:22:09'),
(2,'First','Last','null2@stivasoft.com','pass','12345678901','address','2019-03-11 23:09:27'),
(3,'Zaza','Da','aaa@aaa.aaa','pass','3333333333','dsa as ','2019-03-11 23:09:49');

/*Table structure for table `users_surveys` */

DROP TABLE IF EXISTS `users_surveys`;

CREATE TABLE `users_surveys` (
  `user_id` int(11) NOT NULL,
  `survey_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`survey_id`),
  KEY `fk_surveys` (`survey_id`),
  CONSTRAINT `fk_surveys` FOREIGN KEY (`survey_id`) REFERENCES `surveys` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `users_surveys` */

insert  into `users_surveys`(`user_id`,`survey_id`) values 
(1,1),
(2,1),
(3,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
