-- MySQL dump 10.17  Distrib 10.3.18-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: team2
-- ------------------------------------------------------
-- Server version	10.3.18-MariaDB-1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Announcements'),(6, 'Events<script>alert(\'1\');</script>');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created` datetime NOT NULL,
  `moderated` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`blog_id`,`moderated`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (15,2,1,'acc','<p>wiebviwe</p>\r\n','2019-12-02 07:53:07', 1);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cookies`
--

DROP TABLE IF EXISTS `cookies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cookies` (
  `token` varchar(100) NOT NULL,
  `user_id` int(10) NOT NULL,
  `expiryTime` int(20) NOT NULL,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cookies`
--

LOCK TABLES `cookies` WRITE;
/*!40000 ALTER TABLE `cookies` DISABLE KEYS */;
INSERT INTO `cookies` VALUES ('5de52f861ccf92.04709664',1,1577892998);
/*!40000 ALTER TABLE `cookies` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `post_categories`
--

DROP TABLE IF EXISTS `post_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`,`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_categories`
--

LOCK TABLES `post_categories` WRITE;
/*!40000 ALTER TABLE `post_categories` DISABLE KEYS */;
INSERT INTO `post_categories` VALUES (5,1,1),(6,42,1);
/*!40000 ALTER TABLE `post_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `published` datetime DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `summary` text NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1, 1, '2019-11-09 13:12:54', '2019-11-24 14:50:33', '2019-11-24 14:50:00', 'Hello World!', 'Welcome to your new RobPress Blog!\r\n\r\nYou are about to embark on an amazing journey...', '<p>Welcome to your new RobPress Blog!</p>\r\n\r\n<p>You are about to embark on an amazing journey...</p>\r\n\r\n<p>Here are just some of the exciting features you have to look forward to:</p>\r\n\r\n<ul>\r\n	<li>Create your own categories to sort your blog posts into</li>\r\n	<li>Build your own blog posts using a special WYSIWYG editor with ease</li>\r\n	<li>Facilitate user interaction through the innovative comments and moderation system</li>\r\n	<li>Create static pages to expand your site beyond the boundaries of being a blog</li>\r\n	<li>Create administrators to help you run your blog</li>\r\n	<li>Search through blog posts to make it easy to find the information you&#39;re looking for</li>\r\n	<li>Upload images and files to your posts easily</li>\r\n	<li>Create user profiles and biographies to create a community around your blog</li>\r\n</ul>\r\n\r\n<p>We hope you enjoy your new blog!</p>\r\n'),
(42, 2, '2019-12-02 04:10:25', '2019-12-02 04:10:25', '2019-12-02 04:10:00', 'wefwe', 'wefew', '<p>wefwef</p>\r\n');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `session_id` varchar(191) NOT NULL,
  `data` text DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `agent` varchar(300) DEFAULT NULL,
  `stamp` int(11) DEFAULT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('c4ca4238a0b923820dcc509a6f75849b', 'user|a:11:{s:2:\"id\";s:1:\"1\";s:8:\"username\";s:5:\"admin\";s:11:\"displayname\";s:20:\"<u>Administrator</u>\";s:5:\"email\";s:14:\"root@localhost\";s:8:\"password\";s:60:\"$2y$10$v1ASkff/e4uBTBJvqo01g.bHtmF.gYFxn1H8dE9rgsfLNHstNlVDu\";s:5:\"level\";s:1:\"2\";s:7:\"created\";s:19:\"2000-01-01 00:00:00\";s:3:\"bio\";s:52:\"<p><u><strong>I am Administrator!</strong></u></p>\r\n\";s:6:\"avatar\";s:0:\"\";s:8:\"attempts\";s:1:\"0\";s:6:\"cookie\";N;}token|s:13:\"1gbd5wanj2ixd\";', '::1', 'Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0', 1575290546),
('e2c0be24560d78c5e599c2a9c9d0bbd2', 'user|a:10:{s:2:\"id\";s:3:\"203\";s:8:\"username\";s:4:\"jash\";s:11:\"displayname\";s:4:\"jash\";s:5:\"email\";s:14:\"jash@gmail.com\";s:8:\"password\";s:60:\"$2y$10$qoM7z15X5kmE1qU5GHjlueA35lDZWyEOUWQyU26mFgSP/43wF2.8e\";s:5:\"level\";s:1:\"1\";s:7:\"created\";s:19:\"2019-12-02 07:42:57\";s:3:\"bio\";s:0:\"\";s:6:\"avatar\";s:0:\"\";s:8:\"attempts\";s:1:\"0\";}token|s:13:\"3vq7l6pr0qgwk\";', '::1', 'Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0', 1575290585),
('eccbc87e4b5ce2fe28308fd9f2a7baf3', 'user|a:10:{s:2:\"id\";s:1:\"3\";s:8:\"username\";s:5:\"team2\";s:11:\"displayname\";s:5:\"team2\";s:5:\"email\";s:18:\"team2@robpress.org\";s:8:\"password\";s:60:\"$2y$10$ezarw3uZiM20F7/Hkn/AA.njmOYbWJHt.5GapwrRCNUfv1ctyu2Da\";s:5:\"level\";s:1:\"2\";s:7:\"created\";s:19:\"2019-11-12 11:47:30\";s:3:\"bio\";s:0:\"\";s:6:\"avatar\";s:0:\"\";s:8:\"attempts\";s:1:\"0\";}token|s:13:\"39mbmt0lxou8k\";messages|a:0:{}', '152.78.132.2', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 1575277754),
('gqocuhbi9lq2f63nn6s6lek4mk', 'user|a:10:{s:2:\"id\";s:1:\"1\";s:8:\"username\";s:5:\"admin\";s:11:\"displayname\";s:13:\"Administrator\";s:5:\"email\";s:14:\"root@localhost\";s:8:\"password\";s:60:\"$2y$10$z40fSx94hruZ7AYLiDIMReiA5wQkDha3v2NrJXZX08xlfzhI8irx2\";s:5:\"level\";s:1:\"2\";s:7:\"created\";s:19:\"2000-01-01 00:00:00\";s:3:\"bio\";s:52:\"<p><u><strong>I am Administrator!</strong></u></p>\r\n\";s:6:\"avatar\";s:42:\"/uploads/image_5de2c52c198461.44797363jpeg\";s:8:\"attempts\";s:1:\"0\";}token|s:12:\"zccozuq3i8l8\";', '152.78.132.2', 'Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0', 1575276497);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `setting` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `key` (`setting`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1, 'text', 'name', 'RobPress', 'Blog Name'),
(2, 'text', 'front_title', 'Latest News', 'Front Page Title'),
(3, 'checkbox', 'comments', '1', 'Enable commenting on posts'),
(4, 'checkbox', 'moderate', '1', 'Enable comment moderation'),
(5, 'text', 'subtitle', 'Welcome to RobPress', 'Site Strapline'),
(6, 'text', 'email', 'root@localhost', 'Administrator Email'),
(7, 'checkbox', 'debug', '1', 'Debug mode');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `displayname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `created` datetime NOT NULL,
  `bio` text NOT NULL,
  `avatar` varchar(255) NOT NULL DEFAULT '',
  `attempts` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1, 'admin', 'Administrator', 'root@localhost', '$2y$10$z40fSx94hruZ7AYLiDIMReiA5wQkDha3v2NrJXZX08xlfzhI8irx2', 2, '2000-01-01 00:00:00', '<p><u><strong>I am Administrator!</strong></u></p>\r\n', '', 0),
(2, 'test', 'Test', 'test@test.com', '$2y$10$iutyXg82J.x40IVVK/X9Uerp4HJvSdsYeTlS40Lb4l3GW9F3qVZAG', 2, '2019-11-09 13:12:54', '', '', 0),
(3, 'team2', 'team2', 'team2@robpress.org', '$2y$10$ezarw3uZiM20F7/Hkn/AA.njmOYbWJHt.5GapwrRCNUfv1ctyu2Da', 2, '2019-11-12 11:47:30', '', '', 0),
(203, 'jash', 'jash', 'jash@gmail.com', '$2y$10$qoM7z15X5kmE1qU5GHjlueA35lDZWyEOUWQyU26mFgSP/43wF2.8e', 1, '2019-12-02 07:42:57', '', '', 0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-01 21:31:10
