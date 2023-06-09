CREATE TABLE IF NOT EXISTS `av_boosting` (
  `identifier` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `photo` longtext DEFAULT NULL,
  `level` varchar(50) DEFAULT '0',
  `hacks` int(11) DEFAULT 0,
  `deliveries` int(11) DEFAULT 0,
  `time` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `player_vehicles` ADD COLUMN IF NOT EXISTS `vinscratch` INT(1) DEFAULT 0;

CREATE TABLE IF NOT EXISTS `av_gangs` (
  `identifier` varchar(50) DEFAULT NULL,
  `playerName` varchar(50) DEFAULT NULL,
  `isBoss` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `photo` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `av_strains` (
  `identifier` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `combination` varchar(50) DEFAULT NULL,
  `level` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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

CREATE TABLE IF NOT EXISTS `av_realestate` (
  `groupName` varchar(50) NOT NULL DEFAULT '',
  `type` varchar(50) DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `customer_identifier` varchar(50) DEFAULT NULL,
  `customer` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `initial` text DEFAULT NULL,
  `nextDate` text DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `password` varchar(4) DEFAULT '1234',
  `entrance` text DEFAULT '{}',
  `inventory` varchar(50) DEFAULT NULL,
  `interior` varchar(50) DEFAULT NULL,
  `available` int(11) DEFAULT 1,
  KEY `group` (`groupName`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE IF NOT EXISTS `av_items` (
  `job` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `job` (`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `av_restaurants` (
  `name` varchar(50) NOT NULL,
  `job` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `av_society` (
  `job` varchar(50) DEFAULT NULL,
  `money` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;