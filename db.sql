-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- Server version:               5.7.22 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL 版本:                  10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for php01
DROP DATABASE IF EXISTS `php01`;
CREATE DATABASE IF NOT EXISTS `php01` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `php01`;

-- Dumping structure for table php01.image
DROP TABLE IF EXISTS `image`;
CREATE TABLE IF NOT EXISTS `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `url` varchar(80) DEFAULT NULL,
  `uid` varchar(50) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_img_user` (`uid`),
  KEY `FK_image_upload` (`time`),
  CONSTRAINT `FK_image_upload` FOREIGN KEY (`time`) REFERENCES `upload` (`time`),
  CONSTRAINT `FK_img_user` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Dumping data for table php01.image: ~6 rows (approximately)
DELETE FROM `image`;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` (`id`, `name`, `url`, `uid`, `time`) VALUES
	(1, '73811625_p0_master1200.jpg', 'http://127.0.0.10:1080/Uploads/image/uid=54119476701aba676f1599aa09101415/', '54119476701aba676f1599aa09101415', '2020-07-02 17:01:32'),
	(2, '74526892_p0_master1200.jpg', 'http://127.0.0.10:1080/Uploads/image/uid=54119476701aba676f1599aa09101415/', '54119476701aba676f1599aa09101415', '2020-07-02 17:03:29'),
	(3, '79948400_p0_master1200.jpg', 'http://127.0.0.10:1080/Uploads/image/uid=54119476701aba676f1599aa09101415/', '54119476701aba676f1599aa09101415', '2020-07-02 17:24:59'),
	(4, 'psc.jpg', 'http://127.0.0.10:1080/Uploads/image/uid=54119476701aba676f1599aa09101415/', '54119476701aba676f1599aa09101415', '2020-07-02 17:24:59'),
	(5, 'psc.jpg', 'http://127.0.0.10:1080/Uploads/image/uid=54119476701aba676f1599aa09101415/', '54119476701aba676f1599aa09101415', '2020-07-03 21:10:33'),
	(6, 'pst.jpg', 'http://127.0.0.10:1080/Uploads/image/uid=54119476701aba676f1599aa09101415/', '54119476701aba676f1599aa09101415', '2020-07-03 21:12:21');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;

-- Dumping structure for table php01.login
DROP TABLE IF EXISTS `login`;
CREATE TABLE IF NOT EXISTS `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` char(11) NOT NULL DEFAULT '0',
  `token` varchar(50) NOT NULL DEFAULT '0',
  `code` char(4) NOT NULL DEFAULT '0',
  `count` int(3) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='一个手机号可以注册三次，获得三个验证码。';

-- Dumping data for table php01.login: ~13 rows (approximately)
DELETE FROM `login`;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` (`id`, `phone`, `token`, `code`, `count`) VALUES
	(42, '11111111111', 'd831865ea83d829d3693d9b244194999', 'd831', 1),
	(43, '11111111112', '9a87f23ea9cc6709e5649d7132c58c09', '9a87', 2),
	(44, '11111111147', '33c43d1a8c994c0ecda8a0437dcce388', '33c4', 3),
	(45, '44444444444', '96a51859be161507b649c1bf2b0742ec', '96a5', 0),
	(46, '44444444445', '0a3ee728163cb0720d8c9aba7b38e7b1', '0a3e', 0),
	(47, '44444444446', '58e73576d3cc6bfb6fc951dca64289d0', '58e7', 3),
	(48, '55555555555', '7c4304c71d35e44b834156a385e1e751', '7c43', 1),
	(49, '66666666666', 'f66a76bf2a40a41296f7cdb5684d3387', 'f66a', 3),
	(50, '77777777777', '045af444ee68a061655f6f18127dff00', '045a', 0),
	(51, '44444444447', 'fe36beac8e029e60cbbcd4aae9fdc64e', 'fe36', 2),
	(52, '', '9d445ef349620da294f0b48b8a3c5fb5', '9d44', 2),
	(53, '15551555555', '30889680355b6d8934932b29cc5b9764', '3088', 3),
	(54, '11111441111', '05fc09fce033ec5d6d7a5f9d615f79aa', '05fc', 3);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;

-- Dumping structure for table php01.upload
DROP TABLE IF EXISTS `upload`;
CREATE TABLE IF NOT EXISTS `upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` char(10) NOT NULL DEFAULT '0',
  `uid` varchar(50) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `time` (`time`),
  KEY `FK_public_user` (`uid`),
  CONSTRAINT `FK_public_user` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='每次有用户上传时的记录，记录，上传时间，上传类型';

-- Dumping data for table php01.upload: ~5 rows (approximately)
DELETE FROM `upload`;
/*!40000 ALTER TABLE `upload` DISABLE KEYS */;
INSERT INTO `upload` (`id`, `type`, `uid`, `time`) VALUES
	(1, 'image', '54119476701aba676f1599aa09101415', '2020-07-02 17:01:32'),
	(2, 'image', '54119476701aba676f1599aa09101415', '2020-07-02 17:03:29'),
	(3, 'image', '54119476701aba676f1599aa09101415', '2020-07-02 17:24:59'),
	(5, 'image', '54119476701aba676f1599aa09101415', '2020-07-03 21:10:33'),
	(6, 'image', '54119476701aba676f1599aa09101415', '2020-07-03 21:12:21');
/*!40000 ALTER TABLE `upload` ENABLE KEYS */;

-- Dumping structure for table php01.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `uid` varchar(50) NOT NULL,
  `username` char(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `phone` char(11) NOT NULL,
  `name` varchar(20) NOT NULL DEFAULT '无',
  `score` int(11) NOT NULL DEFAULT '0',
  `identity` char(18) NOT NULL DEFAULT '450112xxxxxxxx2017',
  `addressID` varchar(50) NOT NULL DEFAULT '广西壮族自治区南宁市西乡塘区大学西路29号',
  `icourl` varchar(50) NOT NULL DEFAULT 'http://127.0.0.10:1080/Public/static/img/a.jpg',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `code` (`phone`),
  CONSTRAINT `FK_user_login` FOREIGN KEY (`phone`) REFERENCES `login` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table php01.user: ~4 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`uid`, `username`, `password`, `phone`, `name`, `score`, `identity`, `addressID`, `icourl`) VALUES
	('54119476701aba676f1599aa09101415', '55555555555', '555555', '55555555555', '无', 0, '450112xxxxxxxx2017', '广西壮族自治区南宁市西乡塘区大学西路29号', 'http://127.0.0.10:1080/Public/static/img/a.jpg'),
	('7135523e0ba78f01b44d5a404c0e8ed0', '44444444445', '444444', '44444444445', '无', 0, '450112xxxxxxxx2017', '广西壮族自治区南宁市西乡塘区大学西路29号', 'http://127.0.0.10:1080/Public/static/img/a.jpg'),
	('7db7df642a54a41366f9b39bcd3bb32b', '77777777777', '7777777', '77777777777', '无', 0, '450112xxxxxxxx2017', '广西壮族自治区南宁市西乡塘区大学西路29号', 'http://127.0.0.10:1080/Public/static/img/a.jpg'),
	('b055514937dcb22e3c235fa585ead66b', '11111441111', '111111', '11111441111', '无', 0, '450112xxxxxxxx2017', '广西壮族自治区南宁市西乡塘区大学西路29号', 'http://127.0.0.10:1080/Public/static/img/a.jpg'),
	('f665e1706fd838348c6223ecaf0443df', '44444444447', '444444', '44444444447', '无', 0, '450112xxxxxxxx2017', '广西壮族自治区南宁市西乡塘区大学西路29号', 'http://127.0.0.10:1080/Public/static/img/a.jpg');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table php01.video
DROP TABLE IF EXISTS `video`;
CREATE TABLE IF NOT EXISTS `video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(50) DEFAULT '0',
  `name` varchar(20) DEFAULT '0',
  `uid` varchar(50) DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_video_user` (`uid`),
  KEY `FK_video_upload` (`time`),
  CONSTRAINT `FK_video_upload` FOREIGN KEY (`time`) REFERENCES `upload` (`time`),
  CONSTRAINT `FK_video_user` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table php01.video: ~0 rows (approximately)
DELETE FROM `video`;
/*!40000 ALTER TABLE `video` DISABLE KEYS */;
/*!40000 ALTER TABLE `video` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
