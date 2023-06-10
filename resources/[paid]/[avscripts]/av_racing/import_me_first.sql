CREATE TABLE IF NOT EXISTS `av_boosting` (
  `identifier` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `photo` longtext DEFAULT NULL,
  `level` varchar(50) DEFAULT '0',
  `hacks` int(11) DEFAULT 0,
  `deliveries` int(11) DEFAULT 0,
  `time` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `av_racing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `identifier` longtext DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `leaderboard` text DEFAULT NULL,
  `createdby` varchar(50) DEFAULT NULL,
  `distance` varchar(50) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
