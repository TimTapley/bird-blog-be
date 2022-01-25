# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.36)
# Database: bird-blog
# Generation Time: 2022-01-12 09:16:04 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table posts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL DEFAULT '',
  `species-common` varchar(255) NOT NULL DEFAULT '',
  `species-binomial` varchar(255) NOT NULL DEFAULT '',
  `sighting-date` date NOT NULL,
  `user-id` varchar(20) NOT NULL DEFAULT '',
  `date-time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `image` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;

INSERT INTO `posts` (`id`, `content`, `species-common`, `species-binomial`, `sighting-date`, `user-id`, `date-time`, `deleted`, `image`, `location`)
VALUES
	(1,'testing','Blackbird','Turdus Merula','2022-01-01','1','2022-01-11 13:47:40',0,'','Titchwell, Norfolk');

/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user-following
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user-following`;

CREATE TABLE `user-following` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user-id` int(11) NOT NULL,
  `following-id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `user-following` WRITE;
/*!40000 ALTER TABLE `user-following` DISABLE KEYS */;

INSERT INTO `user-following` (`id`, `user-id`, `following-id`)
VALUES
	(1,1,2),
	(2,2,1);

/*!40000 ALTER TABLE `user-following` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT '',
  `bio` varchar(500) DEFAULT NULL,
  `email` varchar(255) DEFAULT '',
  `password` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `bio`, `email`, `password`)
VALUES
	(1,'Tim Tapley','I like birds','tim@tim.com','password'),
	(2,'Hilary Tapley','I like birds too','hilary@hilary.com','password'),
	(3,'Sally Smith','I like birds as well','sally@sally.com','password'),
	(4,'Ted Smith','And I like birds','ted@ted.com','password'),
	(5,'Polly Partridge','Why do they call me grey?','polly@polly.com','password'),
	(6,'Sid Starling','Oh I do like a murmuration','sid@sid.com','password'),
	(7,'Buzz Buzzard','The mayor of birddom','buzz@buzz.com','password'),
	(8,'Jack Daw','Ole grey eyes','jack@jack.com','password'),
	(9,'Polly Partridge','','polly@polly.com','password'),
	(10,'Harry Hawk','','harry@harry.com','password'),
	(11,'Harry Hawk','','harry@harry.com','password'),
	(12,'Harry Hawk','','harry@harry.com','password'),
	(13,'Harry Hawk','','harry@harry.com','password'),
	(14,'Barry Barnowl','','barry@barry.com','password'),
	(15,'Gary Goose','','gary@gary.com','password');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
