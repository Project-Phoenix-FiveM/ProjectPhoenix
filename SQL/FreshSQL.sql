-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.6.12-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for projectphoenix
CREATE DATABASE IF NOT EXISTS `projectphoenix` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci */;
USE `projectphoenix`;

-- Dumping structure for table projectphoenix.apartments
CREATE TABLE IF NOT EXISTS `apartments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `citizenid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.apartments: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.bank_accounts
CREATE TABLE IF NOT EXISTS `bank_accounts` (
  `record_id` bigint(255) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(250) DEFAULT NULL,
  `business` varchar(50) DEFAULT NULL,
  `businessid` int(11) DEFAULT NULL,
  `gangid` varchar(50) DEFAULT NULL,
  `amount` bigint(255) NOT NULL DEFAULT 0,
  `account_type` enum('Current','Savings','business','Gang') NOT NULL DEFAULT 'Current',
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `citizenid` (`citizenid`),
  KEY `business` (`business`),
  KEY `businessid` (`businessid`),
  KEY `gangid` (`gangid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table projectphoenix.bank_accounts: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.bank_accounts_new
CREATE TABLE IF NOT EXISTS `bank_accounts_new` (
  `id` varchar(50) NOT NULL,
  `amount` int(11) DEFAULT 0,
  `transactions` longtext DEFAULT '[]',
  `auth` longtext DEFAULT '[]',
  `isFrozen` int(11) DEFAULT 0,
  `creator` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.bank_accounts_new: ~11 rows (approximately)
INSERT INTO `bank_accounts_new` (`id`, `amount`, `transactions`, `auth`, `isFrozen`, `creator`) VALUES
	('ambulance', 0, '[]', '[]', 0, NULL),
	('ballas', 0, '[]', '[]', 0, NULL),
	('cardealer', 0, '[]', '[]', 0, NULL),
	('cartel', 0, '[]', '[]', 0, NULL),
	('families', 0, '[]', '[]', 0, NULL),
	('lostmc', 0, '[]', '[]', 0, NULL),
	('mechanic', 0, '[]', '[]', 0, NULL),
	('police', 0, '[]', '[]', 0, NULL),
	('realestate', 0, '[]', '[]', 0, NULL),
	('triads', 0, '[]', '[]', 0, NULL),
	('vagos', 0, '[]', '[]', 0, NULL);

-- Dumping structure for table projectphoenix.bank_cards
CREATE TABLE IF NOT EXISTS `bank_cards` (
  `record_id` bigint(255) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `cardNumber` varchar(50) DEFAULT NULL,
  `cardPin` varchar(50) DEFAULT NULL,
  `cardActive` tinyint(4) DEFAULT 1,
  `cardLocked` tinyint(4) DEFAULT 0,
  `cardType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`citizenid`),
  KEY `record_id` (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table projectphoenix.bank_cards: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.bank_statements
CREATE TABLE IF NOT EXISTS `bank_statements` (
  `record_id` bigint(255) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `business` varchar(50) DEFAULT NULL,
  `businessid` int(11) DEFAULT NULL,
  `gangid` varchar(50) DEFAULT NULL,
  `deposited` int(11) DEFAULT NULL,
  `withdraw` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `business` (`business`),
  KEY `businessid` (`businessid`),
  KEY `gangid` (`gangid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table projectphoenix.bank_statements: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer',
  PRIMARY KEY (`id`),
  KEY `license` (`license`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.bans: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.crypto
CREATE TABLE IF NOT EXISTS `crypto` (
  `crypto` varchar(50) NOT NULL DEFAULT 'qbit',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL,
  PRIMARY KEY (`crypto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.crypto: ~1 rows (approximately)
INSERT INTO `crypto` (`crypto`, `worth`, `history`) VALUES
	('qbit', 1004, '[{"NewWorth":1010,"PreviousWorth":1010},{"NewWorth":1010,"PreviousWorth":1010},{"NewWorth":1010,"PreviousWorth":1010},{"NewWorth":1004,"PreviousWorth":1010}]');

-- Dumping structure for table projectphoenix.crypto_transactions
CREATE TABLE IF NOT EXISTS `crypto_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.crypto_transactions: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.dealers
CREATE TABLE IF NOT EXISTS `dealers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `time` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.dealers: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.dpkeybinds
CREATE TABLE IF NOT EXISTS `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table projectphoenix.dpkeybinds: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.fuel_stations
CREATE TABLE IF NOT EXISTS `fuel_stations` (
  `location` int(11) NOT NULL,
  `owned` int(11) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT NULL,
  `fuelprice` int(11) DEFAULT NULL,
  `balance` int(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.fuel_stations: ~27 rows (approximately)
INSERT INTO `fuel_stations` (`location`, `owned`, `owner`, `fuel`, `fuelprice`, `balance`, `label`) VALUES
	(1, 0, '0', 100000, 3, 0, 'Davis Avenue Ron'),
	(2, 0, '0', 100000, 4, 0, 'Rhodo\'s Fuel Inc'),
	(3, 0, '0', 100000, 3, 0, 'Dutch London Xero'),
	(4, 0, '0', 100000, 3, 0, 'Little Seoul LTD'),
	(5, 0, '0', 100000, 3, 0, 'Strawberry Ave Xero'),
	(6, 0, '0', 100000, 3, 0, 'Popular Street Ron'),
	(7, 0, '0', 100000, 3, 0, 'Capital Blvd Ron'),
	(8, 0, '0', 100000, 3, 0, 'Mirror Park LTD'),
	(9, 0, '0', 100000, 3, 0, 'Clinton Ave Globe Oil'),
	(10, 0, '0', 100000, 3, 0, 'North Rockford Ron'),
	(11, 0, '0', 100000, 3, 0, 'Great Ocean Xero'),
	(12, 0, '0', 100000, 3, 0, 'Paleto Blvd Xero'),
	(13, 0, '0', 100000, 3, 0, 'Paleto Ron'),
	(14, 0, '0', 100000, 3, 0, 'Paleto Globe Oil'),
	(15, 0, '0', 100000, 3, 0, 'Grapeseed LTD'),
	(16, 0, '0', 100000, 3, 0, 'Sandy Shores Xero'),
	(17, 0, '0', 100000, 3, 0, 'Sandy Shores Globe Oil'),
	(18, 0, '0', 100000, 3, 0, 'Senora Freeway Xero'),
	(19, 0, '0', 100000, 3, 0, 'Harmony Globe Oil'),
	(20, 0, '0', 100000, 3, 0, 'Route 68 Globe Oil'),
	(21, 0, '0', 100000, 3, 0, 'Route 68 Workshop Globe O'),
	(22, 0, '0', 100000, 3, 0, 'Route 68 Xero'),
	(23, 0, '0', 100000, 3, 0, 'Route 68 Ron'),
	(24, 0, '0', 100000, 3, 0, 'Rex\'s Diner Globe Oil'),
	(25, 0, '0', 100000, 3, 0, 'Palmino Freeway Ron'),
	(26, 0, '0', 100000, 3, 0, 'North Rockford LTD'),
	(27, 0, '0', 100000, 3, 0, 'Alta Street Globe Oil');

-- Dumping structure for table projectphoenix.gloveboxitems
CREATE TABLE IF NOT EXISTS `gloveboxitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.gloveboxitems: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.houselocations
CREATE TABLE IF NOT EXISTS `houselocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(1) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(4) DEFAULT NULL,
  `garage` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.houselocations: ~1 rows (approximately)
INSERT INTO `houselocations` (`id`, `name`, `label`, `coords`, `owned`, `price`, `tier`, `garage`) VALUES
	(1, 'union rd1', 'Union Rd 1', '{"enter":{"y":4968.58984375,"z":46.57161331176758,"h":322.95751953125,"x":2456.934326171875},"cam":{"yaw":-10.0,"y":4968.58984375,"z":46.57161331176758,"h":322.95751953125,"x":2456.934326171875}}', 0, 56789, 7, '{"w":163.06951904296876,"z":45.36278915405273,"y":4960.802734375,"x":2449.740966796875}');

-- Dumping structure for table projectphoenix.house_plants
CREATE TABLE IF NOT EXISTS `house_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `building` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT 'stage-a',
  `sort` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `health` int(11) DEFAULT 100,
  `progress` int(11) DEFAULT 0,
  `coords` text DEFAULT NULL,
  `plantid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `building` (`building`),
  KEY `plantid` (`plantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.house_plants: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.lapraces
CREATE TABLE IF NOT EXISTS `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `raceid` (`raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.lapraces: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.management_funds
CREATE TABLE IF NOT EXISTS `management_funds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `amount` int(100) NOT NULL,
  `type` enum('boss','gang') NOT NULL DEFAULT 'boss',
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_name` (`job_name`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.management_funds: ~12 rows (approximately)
INSERT INTO `management_funds` (`id`, `job_name`, `amount`, `type`) VALUES
	(1, 'police', 0, 'boss'),
	(2, 'ambulance', 0, 'boss'),
	(3, 'realestate', 0, 'boss'),
	(4, 'taxi', 0, 'boss'),
	(5, 'cardealer', 0, 'boss'),
	(6, 'mechanic', 0, 'boss'),
	(7, 'lostmc', 0, 'gang'),
	(8, 'ballas', 0, 'gang'),
	(9, 'vagos', 0, 'gang'),
	(10, 'cartel', 0, 'gang'),
	(11, 'families', 0, 'gang'),
	(12, 'triads', 0, 'gang');

-- Dumping structure for table projectphoenix.management_outfits
CREATE TABLE IF NOT EXISTS `management_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `minrank` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT 'Cool Outfit',
  `gender` varchar(50) NOT NULL DEFAULT 'male',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.management_outfits: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_bolos
CREATE TABLE IF NOT EXISTS `mdt_bolos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `individual` varchar(50) DEFAULT NULL,
  `detail` text DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `gallery` text DEFAULT NULL,
  `officersinvolved` text DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) NOT NULL DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_bolos: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_bulletin
CREATE TABLE IF NOT EXISTS `mdt_bulletin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `desc` text NOT NULL,
  `author` varchar(50) NOT NULL,
  `time` varchar(20) NOT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_bulletin: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_clocking
CREATE TABLE IF NOT EXISTS `mdt_clocking` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL DEFAULT '',
  `firstname` varchar(255) NOT NULL DEFAULT '',
  `lastname` varchar(255) NOT NULL DEFAULT '',
  `clock_in_time` varchar(255) NOT NULL DEFAULT '',
  `clock_out_time` varchar(50) DEFAULT NULL,
  `total_time` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_clocking: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_convictions
CREATE TABLE IF NOT EXISTS `mdt_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(50) DEFAULT NULL,
  `linkedincident` int(11) NOT NULL DEFAULT 0,
  `warrant` varchar(50) DEFAULT NULL,
  `guilty` varchar(50) DEFAULT NULL,
  `processed` varchar(50) DEFAULT NULL,
  `associated` varchar(50) DEFAULT '0',
  `charges` text DEFAULT NULL,
  `fine` int(11) DEFAULT 0,
  `sentence` int(11) DEFAULT 0,
  `recfine` int(11) DEFAULT 0,
  `recsentence` int(11) DEFAULT 0,
  `time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_convictions: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_data
CREATE TABLE IF NOT EXISTS `mdt_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(20) NOT NULL,
  `information` mediumtext DEFAULT NULL,
  `tags` text NOT NULL,
  `gallery` text NOT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  `pfp` text DEFAULT NULL,
  `fingerprint` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_data: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_impound
CREATE TABLE IF NOT EXISTS `mdt_impound` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicleid` int(11) NOT NULL,
  `linkedreport` int(11) NOT NULL,
  `fee` int(11) DEFAULT NULL,
  `time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_impound: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_incidents
CREATE TABLE IF NOT EXISTS `mdt_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '0',
  `details` text NOT NULL,
  `tags` text NOT NULL,
  `officersinvolved` text NOT NULL,
  `civsinvolved` text NOT NULL,
  `evidence` text NOT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) NOT NULL DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_incidents: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_logs
CREATE TABLE IF NOT EXISTS `mdt_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_logs: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_reports
CREATE TABLE IF NOT EXISTS `mdt_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `officersinvolved` text DEFAULT NULL,
  `civsinvolved` text DEFAULT NULL,
  `gallery` text DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_reports: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_vehicleinfo
CREATE TABLE IF NOT EXISTS `mdt_vehicleinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) DEFAULT NULL,
  `information` text NOT NULL DEFAULT '',
  `stolen` tinyint(1) NOT NULL DEFAULT 0,
  `code5` tinyint(1) NOT NULL DEFAULT 0,
  `image` text NOT NULL DEFAULT '',
  `points` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_vehicleinfo: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.mdt_weaponinfo
CREATE TABLE IF NOT EXISTS `mdt_weaponinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `information` text NOT NULL DEFAULT '',
  `weapClass` varchar(50) DEFAULT NULL,
  `weapModel` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.mdt_weaponinfo: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.newspaper
CREATE TABLE IF NOT EXISTS `newspaper` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `story_type` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(5000) NOT NULL DEFAULT '',
  `body` varchar(5000) NOT NULL DEFAULT '',
  `date` varchar(50) DEFAULT '',
  `jailed_player` varchar(50) DEFAULT NULL,
  `jailed_time` varchar(50) DEFAULT NULL,
  `image` varchar(250) DEFAULT NULL,
  `publisher` varchar(250) NOT NULL DEFAULT 'Los Santos Newspaper',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.newspaper: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.occasion_vehicles
CREATE TABLE IF NOT EXISTS `occasion_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `occasionId` (`occasionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.occasion_vehicles: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.ox_doorlock
CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1661 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.ox_doorlock: ~829 rows (approximately)
INSERT INTO `ox_doorlock` (`id`, `name`, `data`) VALUES
	(830, '247 1', '{"maxDistance":2,"coords":{"x":27.81436920166015,"y":-1349.175048828125,"z":29.64303016662597},"model":1196685123,"doors":false,"groups":{"247":0},"heading":180,"state":0}'),
	(831, '247 2', '{"maxDistance":2,"coords":{"x":30.41496086120605,"y":-1349.175048828125,"z":29.64303016662597},"model":997554217,"doors":false,"groups":{"247":0},"heading":0,"state":0}'),
	(832, '247 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":24.2650203704834,"y":-1341.9100341796876,"z":29.6483097076416},"model":1266035946,"lockpick":false,"groups":{"247":0},"heading":0,"state":1}'),
	(833, '247 4', '{"maxDistance":2,"coords":{"x":375.3482971191406,"y":323.79681396484377,"z":103.71240234375},"model":1196685123,"doors":false,"groups":{"247":0},"heading":166,"state":0}'),
	(834, '247 5', '{"maxDistance":2,"coords":{"x":377.8703918457031,"y":323.16259765625,"z":103.71240234375},"model":997554217,"doors":false,"groups":{"247":0},"heading":346,"state":0}'),
	(835, '247 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":373.67779541015627,"y":331.7078857421875,"z":103.71769714355469},"model":1266035946,"lockpick":false,"groups":{"247":0},"heading":346,"state":1}'),
	(836, '247 7', '{"maxDistance":2,"coords":{"x":-3240.1220703125,"y":1003.1539916992188,"z":12.97671031951904},"model":1196685123,"doors":false,"groups":{"247":0},"heading":265,"state":0}'),
	(837, '247 8', '{"maxDistance":2,"coords":{"x":-3239.89892578125,"y":1005.7449951171875,"z":12.97671031951904},"model":997554217,"doors":false,"groups":{"247":0},"heading":85,"state":0}'),
	(838, '247 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-3247.6650390625,"y":1000.2410278320313,"z":12.98198986053466},"model":1266035946,"lockpick":false,"groups":{"247":0},"heading":85,"state":1}'),
	(839, '247 10', '{"maxDistance":2,"coords":{"x":-3038.212890625,"y":588.2858276367188,"z":8.05492782592773},"model":1196685123,"doors":false,"groups":{"247":0},"heading":288,"state":0}'),
	(840, '247 11', '{"coords":{"x":-3039.006103515625,"y":590.7625122070313,"z":8.05492782592773},"groups":{"247":0},"doors":false,"maxDistance":2,"model":997554217,"state":0,"heading":108}'),
	(841, '247 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-3044.049072265625,"y":582.6898193359375,"z":8.06020927429199},"model":1266035946,"lockpick":false,"groups":{"247":0},"heading":108,"state":1}'),
	(842, '247 13', '{"coords":{"x":2681.294921875,"y":3281.4208984375,"z":55.38714981079101},"groups":{"247":0},"doors":false,"maxDistance":2,"model":1196685123,"state":0,"heading":241}'),
	(843, '247 14', '{"coords":{"x":2682.56103515625,"y":3283.693115234375,"z":55.38714981079101},"groups":{"247":0},"doors":false,"maxDistance":2,"model":997554217,"state":0,"heading":61}'),
	(844, '247 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":2673.220947265625,"y":3281.85693359375,"z":55.39242935180664},"model":1266035946,"lockpick":false,"groups":{"247":0},"heading":61,"state":1}'),
	(845, '247 16', '{"coords":{"x":1963.91796875,"y":3740.069091796875,"z":32.48976135253906},"groups":{"247":0},"doors":false,"maxDistance":2,"model":1196685123,"state":0,"heading":210}'),
	(846, '247 17', '{"coords":{"x":1966.1700439453126,"y":3741.368896484375,"z":32.48976135253906},"groups":{"247":0},"doors":false,"maxDistance":2,"model":997554217,"state":1,"heading":30}'),
	(847, '247 18', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1957.2120361328126,"y":3744.5849609375,"z":32.49504089355469},"model":1266035946,"lockpick":false,"groups":{"247":0},"heading":30,"state":1}'),
	(848, '247 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1730.0260009765626,"y":6412.06787109375,"z":35.1832389831543},"model":1196685123,"lockpick":false,"groups":{"247":0},"heading":154,"state":1}'),
	(849, '247 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1732.35595703125,"y":6410.9140625,"z":35.1832389831543},"model":997554217,"lockpick":false,"groups":{"247":0},"heading":334,"state":1}'),
	(850, '247 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1730.071044921875,"y":6420.15380859375,"z":35.18851852416992},"model":1266035946,"lockpick":false,"groups":{"247":0},"heading":334,"state":1}'),
	(851, '247 22', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":2559.2060546875,"y":384.0841064453125,"z":108.76899719238281},"model":1196685123,"lockpick":false,"groups":{"247":0},"heading":268,"state":1}'),
	(852, '247 23', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":2559.30908203125,"y":386.6825866699219,"z":108.76899719238281},"model":997554217,"lockpick":false,"groups":{"247":0},"heading":88,"state":1}'),
	(853, '247 24', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":2551.804931640625,"y":380.82708740234377,"z":108.77429962158203},"model":1266035946,"lockpick":false,"groups":{"247":0},"heading":88,"state":1}'),
	(854, 'altruist 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1111.6300048828126,"y":4938.296875,"z":218.5258026123047},"model":825709191,"lockpick":false,"groups":{"altruist":0},"heading":340,"state":1}'),
	(855, 'altruist 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1102.260986328125,"y":4940.4140625,"z":218.5258026123047},"model":825709191,"lockpick":false,"groups":{"altruist":0},"heading":70,"state":1}'),
	(856, 'altruist 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1108.428955078125,"y":4939.94091796875,"z":218.51980590820313},"model":193467871,"lockpick":false,"groups":{"altruist":0},"heading":250,"state":1}'),
	(857, 'altruist 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1111.948974609375,"y":4939.740234375,"z":218.51980590820313},"model":193467871,"lockpick":false,"groups":{"altruist":0},"heading":70,"state":1}'),
	(858, 'altruist 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1109.154052734375,"y":4945.10107421875,"z":218.51980590820313},"model":193467871,"lockpick":false,"groups":{"altruist":0},"heading":340,"state":1}'),
	(859, 'altruist 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1100.6939697265626,"y":4946.94287109375,"z":218.51980590820313},"model":193467871,"lockpick":false,"groups":{"altruist":0},"heading":160,"state":1}'),
	(860, 'altruist 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1107.0250244140626,"y":4953.2529296875,"z":218.55409240722657},"model":-173806003,"lockpick":false,"groups":{"altruist":0},"heading":70,"state":1}'),
	(861, 'altruist 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1108.2139892578126,"y":4949.98681640625,"z":218.55409240722657},"model":409744349,"lockpick":false,"groups":{"altruist":0},"heading":70,"state":1}'),
	(862, 'ammunation 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":16.12787055969238,"y":-1114.60498046875,"z":29.94693946838379},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":160,"state":0}'),
	(863, 'ammunation 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":18.5720100402832,"y":-1115.4949951171876,"z":29.94693946838379},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":340,"state":0}'),
	(864, 'ammunation 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":7.14657020568847,"y":-1101.1259765625,"z":29.89739036560058},"model":44561767,"lockpick":false,"groups":{"Ammunation":0},"heading":340,"state":0}'),
	(865, 'ammunation 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":8.04443645477295,"y":-1098.6590576171876,"z":29.89739036560058},"model":44561767,"lockpick":false,"groups":{"Ammunation":0},"heading":340,"state":0}'),
	(866, 'ammunation 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":8.49085712432861,"y":-1094.3900146484376,"z":29.91464042663574},"model":44561767,"lockpick":false,"groups":{"Ammunation":0},"heading":340,"state":0}'),
	(867, 'ammunation 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":813.1779174804688,"y":-2148.27001953125,"z":29.7689208984375},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":0,"state":0}'),
	(868, 'ammunation 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":810.5767822265625,"y":-2148.27001953125,"z":29.7689208984375},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":180,"state":0}'),
	(869, 'ammunation 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":826.227783203125,"y":-2157.864990234375,"z":29.71937942504882},"model":44561767,"lockpick":false,"groups":{"Ammunation":0},"heading":180,"state":0}'),
	(870, 'ammunation 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":826.227783203125,"y":-2160.489990234375,"z":29.71937942504882},"model":44561767,"lockpick":false,"groups":{"Ammunation":0},"heading":180,"state":0}'),
	(871, 'ammunation 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":827.2681884765625,"y":-2164.654052734375,"z":29.73662948608398},"model":44561767,"lockpick":false,"groups":{"Ammunation":0},"heading":180,"state":0}'),
	(872, 'ammunation 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":244.73060607910157,"y":-44.0802116394043,"z":70.09095001220703},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":70,"state":0}'),
	(873, 'ammunation 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":243.84120178222657,"y":-46.52396011352539,"z":70.09095001220703},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":250,"state":0}'),
	(874, 'ammunation 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1112.072998046875,"y":2691.508056640625,"z":18.70404052734375},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":42,"state":0}'),
	(875, 'ammunation 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1114.010986328125,"y":2689.77294921875,"z":18.70404052734375},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":222,"state":0}'),
	(876, 'ammunation 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-3164.847900390625,"y":1081.3929443359376,"z":20.98863983154297},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":247,"state":0}'),
	(877, 'ammunation 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-3163.81494140625,"y":1083.779052734375,"z":20.98863983154297},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":67,"state":0}'),
	(878, 'ammunation 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-662.6419067382813,"y":-944.3220825195313,"z":21.97912979125976},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":0,"state":0}'),
	(879, 'ammunation 18', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-665.2424926757813,"y":-944.3220825195313,"z":21.97912979125976},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":180,"state":0}'),
	(880, 'ammunation 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":845.3695068359375,"y":-1024.54296875,"z":28.34474945068359},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":360,"state":0}'),
	(881, 'ammunation 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":842.7689208984375,"y":-1024.54296875,"z":28.34474945068359},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":180,"state":0}'),
	(882, 'ammunation 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":2568.303955078125,"y":303.352294921875,"z":108.88480377197266},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":180,"state":0}'),
	(883, 'ammunation 22', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":2570.905029296875,"y":303.352294921875,"z":108.88480377197266},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":360,"state":0}'),
	(884, 'ammunation 23', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1313.822998046875,"y":-389.1265869140625,"z":36.84571075439453},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":76,"state":0}'),
	(885, 'ammunation 24', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1314.4620361328126,"y":-391.6476135253906,"z":36.84569931030273},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":256,"state":0}'),
	(886, 'ammunation 25', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1699.9339599609376,"y":3753.422119140625,"z":34.85523986816406},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":47,"state":0}'),
	(887, 'ammunation 26', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1698.1739501953126,"y":3751.508056640625,"z":34.85523986816406},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":227,"state":0}'),
	(888, 'ammunation 27', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-326.1145935058594,"y":6075.27197265625,"z":31.60467910766601},"model":97297972,"lockpick":false,"groups":{"Ammunation":0},"heading":225,"state":0}'),
	(889, 'ammunation 28', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-324.27569580078127,"y":6077.11083984375,"z":31.60467910766601},"model":-8873588,"lockpick":false,"groups":{"Ammunation":0},"heading":45,"state":0}'),
	(890, 'arcade 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1652.2919921875,"y":-1082.43701171875,"z":12.15423965454101},"model":-1879168074,"lockpick":false,"groups":{"unemployed":0},"heading":50,"state":0}'),
	(891, 'arcade 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1656.0570068359376,"y":-1077.1259765625,"z":12.15338993072509},"model":-1977830166,"lockpick":false,"groups":{"unemployed":0},"heading":320,"state":0}'),
	(892, 'arcade 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1647.0660400390626,"y":-1064.2939453125,"z":11.183349609375},"model":855881614,"lockpick":false,"groups":{"unemployed":0},"heading":230,"state":0}'),
	(893, 'arcade 4', '{"maxDistance":1.0,"hideUi":false,"coords":{"x":-1645.68505859375,"y":-1068.1070556640626,"z":12.78339004516601},"model":-2611446,"lockpick":false,"groups":{"unemployed":0},"heading":230,"state":0}'),
	(894, 'arcade 5', '{"maxDistance":1.0,"hideUi":false,"coords":{"x":-1645.4749755859376,"y":-1070.39501953125,"z":12.78339004516601},"model":855881614,"lockpick":false,"groups":{"unemployed":0},"heading":140,"state":0}'),
	(895, 'aztecas 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":493.07550048828127,"y":-1541.8299560546876,"z":29.44705009460449},"model":903896222,"lockpick":false,"groups":{"aztecas":0},"heading":230,"state":1}'),
	(896, 'aztecas 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":486.01348876953127,"y":-1530.3929443359376,"z":29.44705009460449},"model":2103001488,"lockpick":false,"groups":{"aztecas":0},"heading":230,"state":1}'),
	(897, 'aztecas 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":488.58319091796877,"y":-1534.10302734375,"z":29.44644927978515},"model":-1168990172,"lockpick":false,"groups":{"aztecas":0},"heading":320,"state":1}'),
	(898, 'aztecas 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":491.2001953125,"y":-1533.0589599609376,"z":29.44644927978515},"model":-1168990172,"lockpick":false,"groups":{"aztecas":0},"heading":50,"state":1}'),
	(899, 'aztecas 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":490.944091796875,"y":-1531.2900390625,"z":29.44672966003418},"model":-1168990172,"lockpick":false,"groups":{"aztecas":0},"heading":320,"state":1}'),
	(900, 'aztecas 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":496.62078857421877,"y":-1530.5980224609376,"z":29.44705009460449},"model":-1168990172,"lockpick":false,"groups":{"aztecas":0},"heading":140,"state":1}'),
	(901, 'bahama 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1387.0360107421876,"y":-586.6932983398438,"z":30.44564056396484},"model":-224738884,"lockpick":false,"groups":{"bahama":0},"heading":33,"state":1}'),
	(902, 'bahama 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1389.136962890625,"y":-588.0576782226563,"z":30.44564056396484},"model":666905606,"lockpick":false,"groups":{"bahama":0},"heading":213,"state":1}'),
	(903, 'bahama 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1391.8690185546876,"y":-592.6160278320313,"z":30.445650100708},"model":134859901,"lockpick":false,"groups":{"bahama":0},"heading":123,"state":1}'),
	(904, 'bahama 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1390.448974609375,"y":-594.80322265625,"z":30.445650100708},"model":134859901,"lockpick":false,"groups":{"bahama":0},"heading":303,"state":1}'),
	(905, 'bahama 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1391.490966796875,"y":-601.4702758789063,"z":30.445650100708},"model":-1266440846,"lockpick":false,"groups":{"bahama":0},"heading":123,"state":1}'),
	(906, 'bahama 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1378.5860595703126,"y":-621.3176879882813,"z":30.445650100708},"model":-2102541881,"lockpick":false,"groups":{"bahama":0},"heading":123,"state":1}'),
	(907, 'bahama 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1377.677978515625,"y":-624.8817138671875,"z":30.445650100708},"model":-2102541881,"lockpick":false,"groups":{"bahama":0},"heading":33,"state":1}'),
	(908, 'bahama 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1373.760009765625,"y":-628.7487182617188,"z":30.445650100708},"model":134859901,"lockpick":false,"groups":{"bahama":0},"heading":303,"state":1}'),
	(909, 'ballas 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1.87361598014831,"y":-1808.8260498046876,"z":25.54070091247558},"model":-1351120742,"lockpick":false,"groups":{"ballas":0},"heading":50,"state":1}'),
	(910, 'ballas 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":0.20852370560169,"y":-1823.301025390625,"z":29.73542976379394},"model":-1052955611,"lockpick":false,"groups":{"ballas":0},"heading":50,"state":1}'),
	(911, 'ballas 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-6.94860982894897,"y":-1819.7349853515626,"z":29.34070014953613},"model":373216819,"lockpick":false,"groups":{"ballas":0},"heading":230,"state":1}'),
	(912, 'ballas 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-2.02733397483825,"y":-1819.23095703125,"z":29.34070014953613},"model":373216819,"lockpick":false,"groups":{"ballas":0},"heading":230,"state":1}'),
	(913, 'ballas 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":0.04164028167724,"y":-1816.758056640625,"z":29.34070014953613},"model":373216819,"lockpick":false,"groups":{"ballas":0},"heading":230,"state":1}'),
	(914, 'ballas 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":0.70339077711105,"y":-1814.73095703125,"z":29.34070014953613},"model":373216819,"lockpick":false,"groups":{"ballas":0},"heading":320,"state":1}'),
	(915, 'barber 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":132.5574951171875,"y":-1710.9949951171876,"z":29.44166946411132},"model":-1844444717,"lockpick":false,"groups":{"barber":0},"heading":140,"state":0}'),
	(916, 'barber 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1207.8740234375,"y":-470.0364990234375,"z":66.35810089111328},"model":-1844444717,"lockpick":false,"groups":{"barber":0},"heading":75,"state":0}'),
	(917, 'barber 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-280.7843933105469,"y":6232.78076171875,"z":31.84557914733886},"model":-1844444717,"lockpick":false,"groups":{"barber":0},"heading":45,"state":0}'),
	(918, 'barber 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1932.9510498046876,"y":3725.154052734375,"z":32.99449920654297},"model":-1844444717,"lockpick":false,"groups":{"barber":0},"heading":210,"state":0}'),
	(919, 'barber 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1287.85595703125,"y":-1115.741943359375,"z":7.14017105102539},"model":-1844444717,"lockpick":false,"groups":{"barber":0},"heading":90,"state":0}'),
	(920, 'barber 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-29.86952972412109,"y":-148.1580047607422,"z":57.22658157348633},"model":-1844444717,"lockpick":false,"groups":{"barber":0},"heading":340,"state":0}'),
	(921, 'beanmachine 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":128.21339416503907,"y":-1029.4549560546876,"z":29.26180076599121},"model":494354570,"lockpick":false,"groups":{"beanmachine":0},"heading":340,"state":1}'),
	(922, 'beanmachine 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":115.37570190429688,"y":-1037.655029296875,"z":29.34832000732422},"model":-747011272,"lockpick":false,"groups":{"beanmachine":0},"heading":70,"state":1}'),
	(923, 'beanmachine 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":114.56289672851563,"y":-1039.887939453125,"z":29.34832000732422},"model":-1182160879,"lockpick":false,"groups":{"beanmachine":0},"heading":250,"state":1}'),
	(924, 'bennys 1', '{"auto":true,"maxDistance":6.0,"hideUi":false,"coords":{"x":-230.81199645996095,"y":-1326.9990234375,"z":30.24859046936035},"model":-48831039,"lockpick":false,"groups":{"bennys":0},"heading":270,"state":0}'),
	(925, 'bennys 2', '{"auto":true,"maxDistance":6.0,"hideUi":false,"coords":{"x":-215.7353057861328,"y":-1313.2860107421876,"z":30.45401954650879},"model":-1453834687,"lockpick":false,"groups":{"bennys":0},"heading":180,"state":0}'),
	(926, 'bennys 3', '{"auto":true,"maxDistance":6.0,"hideUi":false,"coords":{"x":-207.76939392089845,"y":-1313.2860107421876,"z":30.45401954650879},"model":-1453834687,"lockpick":false,"groups":{"bennys":0},"heading":180,"state":0}'),
	(927, 'bennys 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-230.69920349121095,"y":-1315.14599609375,"z":31.45023918151855},"model":-147325430,"lockpick":false,"groups":{"bennys":0},"heading":270,"state":0}'),
	(928, 'bennys 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-226.0601043701172,"y":-1322.072021484375,"z":31.45023918151855},"model":-147325430,"lockpick":false,"groups":{"bennys":0},"heading":90,"state":0}'),
	(929, 'bennys 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-197.44639587402345,"y":-1322.071044921875,"z":31.46076011657715},"model":-147325430,"lockpick":false,"groups":{"bennys":0},"heading":90,"state":0}'),
	(930, 'bennys 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-197.44639587402345,"y":-1339.1419677734376,"z":31.46076011657715},"model":-147325430,"lockpick":false,"groups":{"bennys":0},"heading":90,"state":0}'),
	(931, 'binco 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1196.823974609375,"y":2703.23193359375,"z":38.38644027709961},"model":-1450680917,"lockpick":false,"groups":{"binco":0},"heading":180,"state":0}'),
	(932, 'binco 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1199.0999755859376,"y":2703.23193359375,"z":38.38644027709961},"model":-720292672,"lockpick":false,"groups":{"binco":0},"heading":0,"state":0}'),
	(933, 'binco 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":82.37061309814453,"y":-1390.4759521484376,"z":29.53996086120605},"model":-720292672,"lockpick":false,"groups":{"binco":0},"heading":90,"state":0}'),
	(934, 'binco 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":82.37061309814453,"y":-1392.751953125,"z":29.53996086120605},"model":-1450680917,"lockpick":false,"groups":{"binco":0},"heading":270,"state":0}'),
	(935, 'binco 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-818.77001953125,"y":-1079.5350341796876,"z":11.49193000793457},"model":-1450680917,"lockpick":false,"groups":{"binco":0},"heading":210,"state":0}'),
	(936, 'binco 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-816.7993774414063,"y":-1078.39697265625,"z":11.49193000793457},"model":-720292672,"lockpick":false,"groups":{"binco":0},"heading":30,"state":0}'),
	(937, 'binco 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":418.58221435546877,"y":-808.6732177734375,"z":29.65496063232422},"model":-720292672,"lockpick":false,"groups":{"binco":0},"heading":270,"state":0}'),
	(938, 'binco 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":418.58221435546877,"y":-806.3978271484375,"z":29.65496063232422},"model":-1450680917,"lockpick":false,"groups":{"binco":0},"heading":90,"state":0}'),
	(939, 'binco 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1686.9940185546876,"y":4821.7431640625,"z":42.2269287109375},"model":-1450680917,"lockpick":false,"groups":{"binco":0},"heading":98,"state":0}'),
	(940, 'binco 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1687.2919921875,"y":4819.48681640625,"z":42.2269287109375},"model":-720292672,"lockpick":false,"groups":{"binco":0},"heading":278,"state":0}'),
	(941, 'binco 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1.71715199947357,"y":6515.90576171875,"z":32.04167175292969},"model":-720292672,"lockpick":false,"groups":{"binco":0},"heading":223,"state":0}'),
	(942, 'binco 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-0.04871224984526,"y":6517.453125,"z":32.04167175292969},"model":-1450680917,"lockpick":false,"groups":{"binco":0},"heading":43,"state":0}'),
	(943, 'binco 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1096.6689453125,"y":2705.4541015625,"z":19.27168083190918},"model":-1450680917,"lockpick":false,"groups":{"binco":0},"heading":222,"state":0}'),
	(944, 'binco 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1094.9739990234376,"y":2706.971923828125,"z":19.27168083190918},"model":-720292672,"lockpick":false,"groups":{"binco":0},"heading":42,"state":0}'),
	(945, 'bobcat 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":914.5590209960938,"y":-2123.137939453125,"z":31.39502906799316},"model":-2023754432,"lockpick":false,"groups":{"bobcat":0},"heading":85,"state":1}'),
	(946, 'bobcat 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":914.7855834960938,"y":-2120.547119140625,"z":31.39502906799316},"model":-2023754432,"lockpick":false,"groups":{"bobcat":0},"heading":265,"state":1}'),
	(947, 'bobcat 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":908.4404296875,"y":-2121.27587890625,"z":31.38098907470703},"model":-2023754432,"lockpick":false,"groups":{"bobcat":0},"heading":85,"state":1}'),
	(948, 'bobcat 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":904.68701171875,"y":-2122.27587890625,"z":31.380220413208},"model":1438783233,"lockpick":false,"groups":{"bobcat":0},"heading":85,"state":1}'),
	(949, 'bobcat 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":904.91357421875,"y":-2119.68603515625,"z":31.380220413208},"model":1438783233,"lockpick":false,"groups":{"bobcat":0},"heading":265,"state":1}'),
	(950, 'bobcat 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":877.82177734375,"y":-2121.991943359375,"z":31.38018035888672},"model":-311575617,"lockpick":false,"groups":{"bobcat":0},"heading":265,"state":1}'),
	(951, 'bobcat 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":889.914306640625,"y":-2107.781005859375,"z":30.23572921752929},"model":-1514454788,"lockpick":false,"groups":{"bobcat":0},"heading":175,"state":1}'),
	(952, 'bowling 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":758.52197265625,"y":-777.2520141601563,"z":26.64883041381836},"model":-626684119,"lockpick":false,"groups":{"bowling":0},"heading":270,"state":0}'),
	(953, 'bowling 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":755.56298828125,"y":-777.2520141601563,"z":26.48348999023437},"model":-626684119,"lockpick":false,"groups":{"bowling":0},"heading":270,"state":0}'),
	(954, 'bowling 3', '{"maxDistance":1.6,"hideUi":false,"coords":{"x":755.5689697265625,"y":-780.9235229492188,"z":26.48348999023437},"model":-626684119,"lockpick":false,"groups":{"bowling":0},"heading":90,"state":0}'),
	(955, 'bowling 4', '{"maxDistance":1.5,"hideUi":false,"coords":{"x":755.5689697265625,"y":-782.7789916992188,"z":26.48348999023437},"model":-2023754432,"lockpick":false,"groups":{"bowling":0},"heading":90,"state":0}'),
	(956, 'bowling 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":755.5689697265625,"y":-770.7398071289063,"z":26.48348999023437},"model":-626684119,"lockpick":false,"groups":{"bowling":0},"heading":270,"state":0}'),
	(957, 'burgershot 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1183.373046875,"y":-885.5643920898438,"z":13.90345954895019},"model":1724308471,"lockpick":false,"groups":{"burgershot":0},"heading":124,"state":1}'),
	(958, 'burgershot 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1184.7159423828126,"y":-883.5756225585938,"z":13.90345954895019},"model":-571782594,"lockpick":false,"groups":{"burgershot":0},"heading":304,"state":1}'),
	(959, 'burgershot 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1176.6090087890626,"y":-895.57568359375,"z":13.9044599533081},"model":1009568243,"lockpick":false,"groups":{"burgershot":0},"heading":124,"state":1}'),
	(960, 'burgershot 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1198.7769775390626,"y":-885.0333251953125,"z":13.90345954895019},"model":-571782594,"lockpick":false,"groups":{"burgershot":0},"heading":34,"state":1}'),
	(961, 'burgershot 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1196.7879638671876,"y":-883.6895141601563,"z":13.90345954895019},"model":1724308471,"lockpick":false,"groups":{"burgershot":0},"heading":214,"state":1}'),
	(962, 'burgershot 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1199.885986328125,"y":-903.0258178710938,"z":13.9044599533081},"model":1009568243,"lockpick":false,"groups":{"burgershot":0},"heading":304,"state":1}'),
	(963, 'burgershot 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1200.1949462890626,"y":-901.2343139648438,"z":13.9024600982666},"model":846116471,"lockpick":false,"groups":{"burgershot":0},"heading":34,"state":1}'),
	(964, 'burgershot 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1193.738037109375,"y":-900.0775146484375,"z":13.94933986663818},"model":1309514423,"lockpick":false,"groups":{"burgershot":0},"heading":304,"state":1}'),
	(965, 'burgershot 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1191.7149658203126,"y":-902.7606811523438,"z":13.9024600982666},"model":547885802,"lockpick":false,"groups":{"burgershot":0},"heading":124,"state":1}'),
	(966, 'burgershot 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1194.5439453125,"y":-905.5847778320313,"z":14.37329959869384},"model":-1905927556,"lockpick":false,"groups":{"burgershot":0},"heading":169,"state":1}'),
	(967, 'burgershot 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1182.5030517578126,"y":-899.5582275390625,"z":13.9024600982666},"model":547885802,"lockpick":false,"groups":{"burgershot":0},"heading":124,"state":1}'),
	(968, 'burgershot 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1183.2679443359376,"y":-897.0562744140625,"z":13.9024600982666},"model":846116471,"lockpick":false,"groups":{"burgershot":0},"heading":34,"state":1}'),
	(969, 'burgershot 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1185.81298828125,"y":-895.4785766601563,"z":13.9024600982666},"model":1618088565,"lockpick":false,"groups":{"burgershot":0},"heading":214,"state":1}'),
	(970, 'burgershot 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1185.4969482421876,"y":-894.5897827148438,"z":13.9024600982666},"model":1618088565,"lockpick":false,"groups":{"burgershot":0},"heading":124,"state":1}'),
	(971, 'burgershot 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1202.23095703125,"y":-892.0250854492188,"z":13.9024600982666},"model":846116471,"lockpick":false,"groups":{"burgershot":0},"heading":34,"state":1}'),
	(972, 'burgershot 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1201.3310546875,"y":-894.7255859375,"z":13.9024600982666},"model":846116471,"lockpick":false,"groups":{"burgershot":0},"heading":124,"state":1}'),
	(973, 'carmeet 1', '{"items":[{"name":"carmeet","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":950.7745971679688,"y":-1698.22705078125,"z":31.44470977783203},"model":-982531572,"lockpick":false,"state":0,"heading":85}'),
	(974, 'casino 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":958.1412963867188,"y":33.9781608581543,"z":72.4049072265625},"model":21324050,"lockpick":false,"groups":{"casino":0},"heading":328,"state":1}'),
	(975, 'casino 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":960.274169921875,"y":32.65346908569336,"z":72.4049072265625},"model":21324050,"lockpick":false,"groups":{"casino":0},"heading":148,"state":1}'),
	(976, 'casino 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1018.6920166015625,"y":67.17648315429688,"z":70.01009368896485},"model":680601509,"lockpick":false,"groups":{"casino":0},"heading":238,"state":1}'),
	(977, 'casino 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1017.6370239257813,"y":65.47772979736328,"z":70.01009368896485},"model":680601509,"lockpick":false,"groups":{"casino":0},"heading":58,"state":1}'),
	(978, 'casino 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1000.6079711914063,"y":61.37115097045898,"z":75.2100830078125},"model":-643593781,"lockpick":false,"groups":{"casino":0},"heading":328,"state":1}'),
	(979, 'casino 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1002.3070068359375,"y":60.31610107421875,"z":75.2100830078125},"model":-643593781,"lockpick":false,"groups":{"casino":0},"heading":148,"state":1}'),
	(980, 'catcafe 1', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-581.014404296875,"y":-1069.626953125,"z":22.48974990844726},"doors":[{"model":-69331849,"coords":{"x":-580.361083984375,"y":-1069.626953125,"z":22.48974990844726},"heading":0},{"model":526179188,"coords":{"x":-581.6677856445313,"y":-1069.626953125,"z":22.48974990844726},"heading":0}],"lockpick":false,"groups":{"unemployed":0},"state":1}'),
	(981, 'catcafe 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-587.3400268554688,"y":-1051.8990478515626,"z":22.41300964355468},"model":-1283712428,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(982, 'catcafe 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-590.1828002929688,"y":-1054.14794921875,"z":22.41300964355468},"model":-60871655,"lockpick":false,"groups":{"unemployed":0},"heading":180,"state":1}'),
	(983, 'catcafe 4', '{"auto":true,"maxDistance":6.0,"hideUi":false,"coords":{"x":-591.7698974609375,"y":-1066.9739990234376,"z":22.53749084472656},"model":-562476388,"lockpick":false,"groups":{"unemployed":0},"heading":270,"state":1}'),
	(984, 'catcafe 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-594.4122924804688,"y":-1049.76904296875,"z":22.49712944030761},"model":2089009131,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(985, 'catcafe 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-592.4738159179688,"y":-1056.0909423828126,"z":22.41300964355468},"model":-60871655,"lockpick":false,"groups":{"unemployed":0},"heading":0,"state":1}'),
	(986, 'catcafe 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-600.9008178710938,"y":-1055.1240234375,"z":22.6126708984375},"model":-1283712428,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(987, 'catcafe 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-600.9105834960938,"y":-1059.218017578125,"z":21.7214298248291},"model":522844070,"lockpick":false,"groups":{"unemployed":0},"heading":270,"state":1}'),
	(988, 'catcafe 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-570.62158203125,"y":-1053.2110595703126,"z":22.41300964355468},"model":1717323416,"lockpick":false,"groups":{"unemployed":0},"heading":270,"state":1}'),
	(989, 'catcafe 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-570.6235961914063,"y":-1055.2159423828126,"z":22.41300964355468},"model":1717323416,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(990, 'catcafe 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-571.792724609375,"y":-1057.387939453125,"z":26.76796913146972},"model":2089009131,"lockpick":false,"groups":{"unemployed":0},"heading":0,"state":1}'),
	(991, 'catcafe 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-575.0109252929688,"y":-1062.3809814453126,"z":26.76796913146972},"model":2089009131,"lockpick":false,"groups":{"unemployed":0},"heading":270,"state":1}'),
	(992, 'catcafe 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-575.0128173828125,"y":-1063.782958984375,"z":26.76796913146972},"model":2089009131,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(993, 'davispd 1', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":380.78009033203127,"y":-1593.44140625,"z":30.20128059387207},"doors":[{"model":1670919150,"coords":{"x":379.7842102050781,"y":-1592.60595703125,"z":30.20128059387207},"heading":140},{"model":618295057,"coords":{"x":381.7760009765625,"y":-1594.2769775390626,"z":30.20128059387207},"heading":140}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(994, 'davispd 2', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":370.51611328125,"y":-1615.035400390625,"z":30.20128059387207},"doors":[{"model":1670919150,"coords":{"x":371.5119934082031,"y":-1615.8709716796876,"z":30.20128059387207},"heading":320},{"model":618295057,"coords":{"x":369.52020263671877,"y":-1614.199951171875,"z":30.20128059387207},"heading":320}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(995, 'davispd 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":382.8243103027344,"y":-1599.0250244140626,"z":30.14451026916504},"model":-425870000,"lockpick":false,"groups":{"police":0},"heading":320,"state":1}'),
	(996, 'davispd 4', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":362.3793029785156,"y":-1593.4129638671876,"z":31.14456939697265},"doors":[{"model":-425870000,"coords":{"x":363.1488952636719,"y":-1592.4959716796876,"z":31.14456939697265},"heading":50},{"model":-425870000,"coords":{"x":361.6097106933594,"y":-1594.3299560546876,"z":31.14456939697265},"heading":230}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(997, 'davispd 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":358.3826904296875,"y":-1595.0009765625,"z":31.14456939697265},"model":-425870000,"lockpick":false,"groups":{"police":0},"heading":50,"state":1}'),
	(998, 'davispd 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":363.2424011230469,"y":-1589.208984375,"z":31.14456939697265},"model":-425870000,"lockpick":false,"groups":{"police":0},"heading":230,"state":1}'),
	(999, 'davispd 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":369.0669860839844,"y":-1605.68798828125,"z":29.94212913513183},"model":-674638964,"lockpick":false,"groups":{"police":0},"state":1,"heading":320,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1000, 'davispd 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":368.26690673828127,"y":-1605.0159912109376,"z":29.94212913513183},"model":-674638964,"lockpick":false,"groups":{"police":0},"state":1,"heading":140,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1001, 'davispd 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":384.4285888671875,"y":-1601.9599609375,"z":30.14451026916504},"model":-1335406364,"lockpick":false,"groups":{"police":0},"heading":50,"state":1}'),
	(1002, 'davispd 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":374.635986328125,"y":-1613.6300048828126,"z":30.14451026916504},"model":-1335406364,"lockpick":false,"groups":{"police":0},"heading":230,"state":1}'),
	(1003, 'davispd 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":379.17230224609377,"y":-1603.8260498046876,"z":25.54450988769531},"model":-1335406364,"lockpick":false,"groups":{"police":0},"heading":320,"state":1}'),
	(1004, 'davispd 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":375.5429992675781,"y":-1608.1510009765626,"z":25.54450988769531},"model":-1335406364,"lockpick":false,"groups":{"police":0},"heading":320,"state":1}'),
	(1005, 'davispd 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":371.95819091796877,"y":-1605.1429443359376,"z":25.54544067382812},"model":-728950481,"lockpick":false,"groups":{"police":0},"heading":140,"state":1}'),
	(1006, 'davispd 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":368.8940124511719,"y":-1602.572021484375,"z":25.54544067382812},"model":-1335406364,"lockpick":false,"groups":{"police":0},"heading":140,"state":1}'),
	(1007, 'davispd 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":375.0779113769531,"y":-1598.43505859375,"z":25.34305953979492},"model":-674638964,"lockpick":false,"groups":{"police":0},"state":1,"heading":140,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1008, 'davispd 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":375.87799072265627,"y":-1599.10595703125,"z":25.34305953979492},"model":-674638964,"lockpick":false,"groups":{"police":0},"state":1,"heading":320,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1009, 'davispd 17', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":369.6373596191406,"y":-1599.510498046875,"z":25.54544067382812},"doors":[{"model":-1335406364,"coords":{"x":368.864013671875,"y":-1600.4320068359376,"z":25.54544067382812},"heading":230},{"model":-1335406364,"coords":{"x":370.41070556640627,"y":-1598.5889892578126,"z":25.54544067382812},"heading":50}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1010, 'davispd 18', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":368.78070068359377,"y":-1595.08642578125,"z":25.5455093383789},"doors":[{"model":-425870000,"coords":{"x":367.8591003417969,"y":-1594.31298828125,"z":25.5455093383789},"heading":140},{"model":-425870000,"coords":{"x":369.7023010253906,"y":-1595.8599853515626,"z":25.5455093383789},"heading":320}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1011, 'davispd 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":367.1189880371094,"y":-1601.08203125,"z":25.54450988769531},"model":-1335406364,"lockpick":false,"groups":{"police":0},"heading":320,"state":1}'),
	(1012, 'davispd 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":363.8883972167969,"y":-1595.4720458984376,"z":25.54544067382812},"model":-1335406364,"lockpick":false,"groups":{"police":0},"heading":230,"state":1}'),
	(1013, 'davispd 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":361.006103515625,"y":-1595.9530029296876,"z":25.54544067382812},"model":-1335406364,"lockpick":false,"groups":{"police":0},"heading":320,"state":1}'),
	(1014, 'davispd 22', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":364.6354064941406,"y":-1591.6280517578126,"z":25.54544067382812},"model":-1335406364,"lockpick":false,"groups":{"police":0},"heading":320,"state":1}'),
	(1015, 'davispd 23', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":397.8851013183594,"y":-1607.385986328125,"z":28.34165954589843},"model":1286535678,"lockpick":false,"groups":{"police":0},"heading":140,"state":1}'),
	(1016, 'davispd 24', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":391.8601989746094,"y":-1636.0699462890626,"z":29.97438049316406},"model":-1156020871,"lockpick":false,"groups":{"police":0},"heading":50,"state":1}'),
	(1017, 'diner 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1595.5369873046876,"y":6451.93994140625,"z":25.01383018493652},"model":-1428884643,"lockpick":false,"groups":{"unemployed":0},"heading":245,"state":1}'),
	(1018, 'diner 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1581.06201171875,"y":6458.740234375,"z":25.01383018493652},"model":861832298,"lockpick":false,"groups":{"unemployed":0},"heading":245,"state":1}'),
	(1019, 'esbltd 1', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-52.96389770507812,"y":-1756.552001953125,"z":29.57094001770019},"doors":[{"model":2065277225,"coords":{"x":-51.96669006347656,"y":-1757.386962890625,"z":29.57094001770019},"heading":320},{"model":-868672903,"coords":{"x":-53.96110916137695,"y":-1755.717041015625,"z":29.57094001770019},"heading":140}],"lockpick":false,"groups":{"unemployed":0},"state":1}'),
	(1020, 'families 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-152.02439880371095,"y":-1622.64794921875,"z":33.83776092529297},"model":1381046002,"lockpick":false,"groups":{"families":0},"heading":233,"state":1}'),
	(1021, 'families 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-153.0364990234375,"y":-1618.81298828125,"z":33.83776092529297},"model":1543383628,"lockpick":false,"groups":{"families":0},"heading":160,"state":1}'),
	(1022, 'families 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-159.62139892578126,"y":-1614.512939453125,"z":33.83805084228515},"model":1543383628,"lockpick":false,"groups":{"families":0},"heading":250,"state":1}'),
	(1023, 'families 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-160.897705078125,"y":-1615.5660400390626,"z":33.83805084228515},"model":1543383628,"lockpick":false,"groups":{"families":0},"heading":70,"state":1}'),
	(1024, 'firedept 1', '{"auto":6.0,"maxDistance":4.0,"hideUi":false,"coords":{"x":1204.823974609375,"y":-1463.529052734375,"z":35.82929992675781},"model":1934132135,"lockpick":false,"groups":{"unemployed":0},"heading":180,"state":1}'),
	(1025, 'firedept 2', '{"auto":6.0,"maxDistance":4.0,"hideUi":false,"coords":{"x":1200.7490234375,"y":-1463.529052734375,"z":35.82929992675781},"model":1934132135,"lockpick":false,"groups":{"unemployed":0},"heading":180,"state":1}'),
	(1026, 'firedept 3', '{"auto":6.0,"maxDistance":4.0,"hideUi":false,"coords":{"x":1196.666015625,"y":-1463.529052734375,"z":35.82929992675781},"model":1934132135,"lockpick":false,"groups":{"unemployed":0},"heading":180,"state":1}'),
	(1027, 'firedept 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1185.0030517578126,"y":-1464.68603515625,"z":34.07891082763672},"model":-585526495,"lockpick":false,"groups":{"unemployed":0},"heading":0,"state":1}'),
	(1028, 'firedept 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1192.842041015625,"y":-1469.9930419921876,"z":33.85363006591797},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(1029, 'firedept 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1192.842041015625,"y":-1472.2960205078126,"z":33.85363006591797},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":270,"state":1}'),
	(1030, 'firedept 7', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":1200.73193359375,"y":-1477.1669921875,"z":35.01290893554687},"doors":[{"model":-1056920428,"coords":{"x":1201.7659912109376,"y":-1477.1669921875,"z":35.01290893554687},"heading":0},{"model":-1056920428,"coords":{"x":1199.697998046875,"y":-1477.1669921875,"z":35.01290893554687},"heading":180}],"lockpick":false,"groups":{"unemployed":0},"state":1}'),
	(1031, 'firedept 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1208.1600341796876,"y":-1479.2779541015626,"z":33.85363006591797},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(1032, 'firedept 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1209.8160400390626,"y":-1480.0579833984376,"z":33.85363006591797},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":0,"state":1}'),
	(1033, 'firedept 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1215.68603515625,"y":-1480.0579833984376,"z":33.85363006591797},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":0,"state":1}'),
	(1034, 'firedept 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1211.135009765625,"y":-1477.1669921875,"z":33.85363006591797},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":180,"state":1}'),
	(1035, 'firedept 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1216.991943359375,"y":-1477.1669921875,"z":33.85363006591797},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":180,"state":1}'),
	(1036, 'firedept 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1208.6590576171876,"y":-1473.364990234375,"z":33.85363006591797},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":270,"state":1}'),
	(1037, 'firedept 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1208.6590576171876,"y":-1470.0009765625,"z":33.85363006591797},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(1038, 'firedept 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1216.991943359375,"y":-1471.4549560546876,"z":33.85363006591797},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":180,"state":1}'),
	(1039, 'firedept 16', '{"auto":6.0,"maxDistance":4.0,"hideUi":false,"coords":{"x":215.21949768066407,"y":-1646.3409423828126,"z":30.77298927307129},"model":1934132135,"lockpick":false,"groups":{"unemployed":0},"heading":140,"state":1}'),
	(1040, 'firedept 17', '{"auto":6.0,"maxDistance":4.0,"hideUi":false,"coords":{"x":212.097900390625,"y":-1643.7220458984376,"z":30.77298927307129},"model":1934132135,"lockpick":false,"groups":{"unemployed":0},"heading":140,"state":1}'),
	(1041, 'firedept 18', '{"auto":6.0,"maxDistance":4.0,"hideUi":false,"coords":{"x":208.97059631347657,"y":-1641.0980224609376,"z":30.77298927307129},"model":1934132135,"lockpick":false,"groups":{"unemployed":0},"heading":140,"state":1}'),
	(1042, 'firedept 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":199.29200744628907,"y":-1634.487060546875,"z":29.02260017395019},"model":-585526495,"lockpick":false,"groups":{"unemployed":0},"heading":320,"state":1}'),
	(1043, 'firedept 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":201.885498046875,"y":-1643.5909423828126,"z":28.79733085632324},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":50,"state":1}'),
	(1044, 'firedept 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":200.40570068359376,"y":-1645.35498046875,"z":28.79733085632324},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":230,"state":1}'),
	(1045, 'firedept 22', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":203.3188018798828,"y":-1654.158447265625,"z":29.95660018920898},"doors":[{"model":-1056920428,"coords":{"x":204.11109924316407,"y":-1654.822998046875,"z":29.95660018920898},"heading":320},{"model":-1056920428,"coords":{"x":202.52650451660157,"y":-1653.4940185546876,"z":29.95660018920898},"heading":140}],"lockpick":false,"groups":{"unemployed":0},"state":1}'),
	(1046, 'firedept 23', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":207.6519012451172,"y":-1660.550048828125,"z":28.79733085632324},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":50,"state":1}'),
	(1047, 'firedept 24', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":208.418701171875,"y":-1662.2130126953126,"z":28.79733085632324},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":320,"state":1}'),
	(1048, 'firedept 25', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":212.9152069091797,"y":-1665.9859619140626,"z":28.79733085632324},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":320,"state":1}'),
	(1049, 'firedept 26', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":211.28750610351563,"y":-1660.844970703125,"z":28.79733085632324},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":140,"state":1}'),
	(1050, 'firedept 27', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":215.7747039794922,"y":-1664.6099853515626,"z":28.79733085632324},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":140,"state":1}'),
	(1051, 'firedept 28', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":211.83509826660157,"y":-1656.342041015625,"z":28.79733085632324},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":230,"state":1}'),
	(1052, 'firedept 29', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":213.99729919433595,"y":-1653.7640380859376,"z":28.79733085632324},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":50,"state":1}'),
	(1053, 'firedept 30', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":219.44659423828126,"y":-1660.2349853515626,"z":28.79733085632324},"model":-903733315,"lockpick":false,"groups":{"unemployed":0},"heading":140,"state":1}'),
	(1054, 'fleeca 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":313.95880126953127,"y":-275.59698486328127,"z":54.51572036743164},"model":-1152174184,"lockpick":false,"groups":{"fleeca":0},"heading":160,"state":0}'),
	(1055, 'fleeca 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":316.3922119140625,"y":-276.4891052246094,"z":54.51572036743164},"model":73386408,"lockpick":false,"groups":{"fleeca":0},"heading":160,"state":0}'),
	(1056, 'fleeca 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":309.6991882324219,"y":-280.3030090332031,"z":54.32192993164062},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":70,"state":1}'),
	(1057, 'fleeca 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":308.6896057128906,"y":-281.55841064453127,"z":54.32606887817383},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":250,"state":1}'),
	(1058, 'fleeca 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":312.3580017089844,"y":-282.7301025390625,"z":54.30364990234375},"model":2121050683,"lockpick":false,"groups":{"fleeca":0},"heading":250,"state":1}'),
	(1059, 'fleeca 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":314.643798828125,"y":-285.9400939941406,"z":54.47489929199219},"model":-1591004109,"lockpick":false,"groups":{"fleeca":0},"heading":160,"state":1}'),
	(1060, 'fleeca 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1176.4949951171876,"y":2703.613037109375,"z":38.43896102905273},"model":-1152174184,"lockpick":false,"groups":{"fleeca":0},"heading":0,"state":0}'),
	(1061, 'fleeca 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1173.9029541015626,"y":2703.613037109375,"z":38.43896102905273},"model":73386408,"lockpick":false,"groups":{"fleeca":0},"heading":0,"state":0}'),
	(1062, 'fleeca 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1178.8740234375,"y":2709.498046875,"z":38.24517059326172},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":270,"state":1}'),
	(1063, 'fleeca 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1179.3900146484376,"y":2711.02392578125,"z":38.24930953979492},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":90,"state":1}'),
	(1064, 'fleeca 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1175.5419921875,"y":2710.861083984375,"z":38.22689056396484},"model":2121050683,"lockpick":false,"groups":{"fleeca":0},"heading":90,"state":1}'),
	(1065, 'fleeca 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1172.291015625,"y":2713.087890625,"z":38.39815139770508},"model":-1591004109,"lockpick":false,"groups":{"fleeca":0},"heading":0,"state":1}'),
	(1066, 'fleeca 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":149.62989807128907,"y":-1037.23095703125,"z":29.7189998626709},"model":-1152174184,"lockpick":false,"groups":{"fleeca":0},"heading":160,"state":0}'),
	(1067, 'fleeca 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":152.06300354003907,"y":-1038.1240234375,"z":29.7189998626709},"model":73386408,"lockpick":false,"groups":{"fleeca":0},"heading":160,"state":0}'),
	(1068, 'fleeca 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":145.3686065673828,"y":-1041.93603515625,"z":29.52520942687988},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":70,"state":1}'),
	(1069, 'fleeca 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":144.3585968017578,"y":-1043.1910400390626,"z":29.52935028076172},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":250,"state":1}'),
	(1070, 'fleeca 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":148.02659606933595,"y":-1044.364013671875,"z":29.506929397583},"model":2121050683,"lockpick":false,"groups":{"fleeca":0},"heading":250,"state":1}'),
	(1071, 'fleeca 18', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":150.31129455566407,"y":-1047.574951171875,"z":29.67819023132324},"model":-1591004109,"lockpick":false,"groups":{"fleeca":0},"heading":160,"state":1}'),
	(1072, 'fleeca 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1215.385986328125,"y":-328.5238952636719,"z":38.13196182250976},"model":-1152174184,"lockpick":false,"groups":{"fleeca":0},"heading":207,"state":0}'),
	(1073, 'fleeca 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1213.073974609375,"y":-327.3528137207031,"z":38.13196182250976},"model":73386408,"lockpick":false,"groups":{"fleeca":0},"heading":207,"state":0}'),
	(1074, 'fleeca 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1214.8489990234376,"y":-334.84869384765627,"z":37.93817138671875},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":117,"state":1}'),
	(1075, 'fleeca 22', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1214.6199951171876,"y":-336.4432067871094,"z":37.94231033325195},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":297,"state":1}'),
	(1076, 'fleeca 23', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1211.260986328125,"y":-334.5596008300781,"z":37.91989135742187},"model":2121050683,"lockpick":false,"groups":{"fleeca":0},"heading":297,"state":1}'),
	(1077, 'fleeca 24', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1207.35400390625,"y":-335.07720947265627,"z":38.09114837646484},"model":-1591004109,"lockpick":false,"groups":{"fleeca":0},"heading":207,"state":1}'),
	(1078, 'fleeca 25', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-351.25970458984377,"y":-46.41262054443359,"z":49.38750076293945},"model":-1152174184,"lockpick":false,"groups":{"fleeca":0},"heading":161,"state":0}'),
	(1079, 'fleeca 26', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-348.8111877441406,"y":-47.26242065429687,"z":49.38750076293945},"model":73386408,"lockpick":false,"groups":{"fleeca":0},"heading":161,"state":0}'),
	(1080, 'fleeca 27', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-355.43701171875,"y":-51.19182968139648,"z":49.19371032714844},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":71,"state":1}'),
	(1081, 'fleeca 28', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-356.4247131347656,"y":-52.46456146240234,"z":49.19784927368164},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":251,"state":1}'),
	(1082, 'fleeca 29', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-352.73651123046877,"y":-53.57247924804687,"z":49.17543029785156},"model":2121050683,"lockpick":false,"groups":{"fleeca":0},"heading":251,"state":1}'),
	(1083, 'fleeca 30', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-350.3953857421875,"y":-56.74229049682617,"z":49.3466911315918},"model":-1591004109,"lockpick":false,"groups":{"fleeca":0},"heading":161,"state":1}'),
	(1084, 'fleeca 31', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-2965.821044921875,"y":481.6299133300781,"z":16.04801940917968},"model":-1152174184,"lockpick":false,"groups":{"fleeca":0},"heading":268,"state":0}'),
	(1085, 'fleeca 32', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-2965.7099609375,"y":484.21929931640627,"z":16.04801940917968},"model":73386408,"lockpick":false,"groups":{"fleeca":0},"heading":268,"state":0}'),
	(1086, 'fleeca 33', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-2960.0439453125,"y":479.00030517578127,"z":15.85422992706298},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":178,"state":1}'),
	(1087, 'fleeca 34', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-2958.541015625,"y":478.4195861816406,"z":15.85836029052734},"model":-147325430,"lockpick":false,"groups":{"fleeca":0},"heading":358,"state":1}'),
	(1088, 'fleeca 35', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-2958.5390625,"y":482.2705993652344,"z":15.83594989776611},"model":2121050683,"lockpick":false,"groups":{"fleeca":0},"heading":358,"state":1}'),
	(1089, 'fleeca 36', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-2956.174072265625,"y":485.423095703125,"z":16.00720024108886},"model":-1591004109,"lockpick":false,"groups":{"fleeca":0},"heading":268,"state":1}'),
	(1090, 'harmony 1', '{"auto":6.0,"maxDistance":4.0,"hideUi":false,"coords":{"x":1174.654052734375,"y":2645.221923828125,"z":38.63962173461914},"model":-822900180,"lockpick":false,"groups":{"mechanic":0},"heading":180,"state":1}'),
	(1091, 'harmony 2', '{"auto":6.0,"maxDistance":4.0,"hideUi":false,"coords":{"x":1182.3060302734376,"y":2645.23193359375,"z":38.63962173461914},"model":-822900180,"lockpick":false,"groups":{"mechanic":0},"heading":180,"state":1}'),
	(1092, 'harmony 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1187.2020263671876,"y":2644.949951171875,"z":38.55176162719726},"model":1335311341,"lockpick":false,"groups":{"mechanic":0},"heading":180,"state":1}'),
	(1093, 'haters 1', '{"items":[{"name":"keys_haters","remove":false}],"maxDistance":2.5,"hideUi":false,"coords":{"x":-1118.5760498046876,"y":-1440.656005859375,"z":4.28510618209838},"model":932235872,"lockpick":false,"state":1,"heading":125}'),
	(1094, 'haters 2', '{"items":[{"name":"keys_haters","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":-1128.949951171875,"y":-1439.9859619140626,"z":4.29096794128418},"model":396177650,"lockpick":false,"state":1,"heading":305}'),
	(1095, 'haters 3', '{"items":[{"name":"keys_haters","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":-1126.053955078125,"y":-1446.530029296875,"z":4.34477186203002},"model":779130623,"lockpick":false,"state":1,"heading":215}'),
	(1096, 'hayes 1', '{"maxDistance":3.0,"hideUi":false,"coords":{"x":-1434.156005859375,"y":-448.58599853515627,"z":36.05923843383789},"model":-634936098,"lockpick":false,"groups":{"mechanic":0},"heading":32,"state":1}'),
	(1097, 'hayes 2', '{"auto":true,"maxDistance":5.5,"hideUi":false,"coords":{"x":-1414.8680419921876,"y":-436.36761474609377,"z":34.77352142333984},"model":1715394473,"lockpick":false,"groups":{"mechanic":0},"heading":32,"state":1}'),
	(1098, 'hayes 3', '{"auto":true,"maxDistance":5.5,"hideUi":false,"coords":{"x":-1421.1180419921876,"y":-440.2720031738281,"z":34.77352142333984},"model":1715394473,"lockpick":false,"groups":{"mechanic":0},"heading":32,"state":1}'),
	(1099, 'hayes 4', '{"auto":true,"maxDistance":5.5,"hideUi":false,"coords":{"x":-1427.3260498046876,"y":-444.151611328125,"z":34.77352142333984},"model":1715394473,"lockpick":false,"groups":{"mechanic":0},"heading":32,"state":1}'),
	(1100, 'hayes 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1427.5260009765626,"y":-455.6803894042969,"z":36.0595588684082},"model":1289778077,"lockpick":false,"groups":{"mechanic":0},"heading":302,"state":1}'),
	(1101, 'hornys 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1243.0159912109376,"y":-366.59820556640627,"z":69.2342300415039},"model":-726346986,"lockpick":false,"groups":{"hornys":0},"heading":165,"state":1}'),
	(1102, 'hornys 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1240.4749755859376,"y":-365.9173889160156,"z":69.2342300415039},"model":501736823,"lockpick":false,"groups":{"hornys":0},"heading":345,"state":1}'),
	(1103, 'hornys 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1234.8599853515626,"y":-356.2759094238281,"z":69.2342300415039},"model":-726346986,"lockpick":false,"groups":{"hornys":0},"heading":75,"state":1}'),
	(1104, 'hornys 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1235.541015625,"y":-353.73419189453127,"z":69.2342300415039},"model":501736823,"lockpick":false,"groups":{"hornys":0},"heading":255,"state":1}'),
	(1105, 'hornys 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1242.637939453125,"y":-355.68011474609377,"z":69.22708129882813},"model":-1569472325,"lockpick":false,"groups":{"hornys":0},"heading":255,"state":1}'),
	(1106, 'hornys 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1242.4410400390626,"y":-353.73040771484377,"z":69.22708129882813},"model":1358044601,"lockpick":false,"groups":{"hornys":0},"heading":165,"state":1}'),
	(1107, 'hornys 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1241.0040283203126,"y":-350.7965087890625,"z":69.22708129882813},"model":2096461247,"lockpick":false,"groups":{"hornys":0},"heading":255,"state":1}'),
	(1108, 'hornys 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1246.7149658203126,"y":-353.6756896972656,"z":69.22708129882813},"model":1358044601,"lockpick":false,"groups":{"hornys":0},"heading":75,"state":1}'),
	(1109, 'hornys 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1247.0860595703126,"y":-355.6158142089844,"z":69.22708129882813},"model":-1265474312,"lockpick":false,"groups":{"hornys":0},"heading":345,"state":1}'),
	(1110, 'hornys 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1246.29296875,"y":-350.56890869140627,"z":69.22213745117188},"model":-147325430,"lockpick":false,"groups":{"hornys":0},"heading":165,"state":1}'),
	(1111, 'hornys 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1253.387939453125,"y":-358.3793029785156,"z":69.33180236816406},"model":1166189145,"lockpick":false,"groups":{"hornys":0},"heading":75,"state":1}'),
	(1112, 'hornys 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1253.2080078125,"y":-359.0505065917969,"z":69.33180236816406},"model":-1852392804,"lockpick":false,"groups":{"hornys":0},"heading":75,"state":1}'),
	(1113, 'hornys 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1250.7979736328126,"y":-359.26910400390627,"z":69.04773712158203},"model":1525954152,"lockpick":false,"groups":{"hornys":0},"heading":75,"state":1}'),
	(1114, 'hornys 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1249.4420166015626,"y":-358.9054870605469,"z":69.04773712158203},"model":1525954152,"lockpick":false,"groups":{"hornys":0},"heading":75,"state":1}'),
	(1115, 'hornys 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1248.1619873046876,"y":-358.56280517578127,"z":69.04773712158203},"model":1525954152,"lockpick":false,"groups":{"hornys":0},"heading":75,"state":1}'),
	(1116, 'hub 1', '{"auto":6.0,"maxDistance":6.0,"hideUi":false,"coords":{"x":-44.18840026855469,"y":-1043.553955078125,"z":27.80159950256347},"model":-427498890,"lockpick":false,"groups":{"mechanic":0},"heading":70,"state":1}'),
	(1117, 'hub 2', '{"auto":true,"maxDistance":10.0,"hideUi":false,"coords":{"x":-205.68280029296876,"y":-1310.6820068359376,"z":30.29571914672851},"model":-427498890,"lockpick":false,"groups":{"mechanic":0},"heading":0,"state":1}'),
	(1118, 'hub 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-187.0614013671875,"y":-1162.3480224609376,"z":23.82123947143554},"model":-952356348,"lockpick":false,"groups":{"mechanic":0},"heading":90,"state":1}'),
	(1119, 'hub 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-189.63600158691407,"y":-1167.884033203125,"z":23.82123947143554},"model":97297972,"lockpick":false,"groups":{"mechanic":0},"heading":180,"state":1}'),
	(1120, 'hub 5', '{"auto":true,"maxDistance":9.0,"hideUi":false,"coords":{"x":-164.12680053710938,"y":-1160.677978515625,"z":22.63863945007324},"model":1286535678,"lockpick":false,"groups":{"mechanic":0},"heading":180,"state":1}'),
	(1121, 'hub 6', '{"auto":true,"maxDistance":9.0,"hideUi":false,"coords":{"x":-225.07420349121095,"y":-1158.823974609375,"z":22.09534072875976},"model":1286535678,"lockpick":false,"groups":{"mechanic":0},"heading":180,"state":1}'),
	(1122, 'hub 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-55.95074081420898,"y":-1088.06494140625,"z":27.61301040649414},"model":1973010099,"lockpick":false,"groups":{"cardealer":0},"heading":250,"state":1}'),
	(1123, 'hub 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-48.12820053100586,"y":-1103.5,"z":27.61301040649414},"model":1973010099,"lockpick":false,"groups":{"cardealer":0},"heading":340,"state":1}'),
	(1124, 'hub 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-32.64266967773437,"y":-1108.5589599609376,"z":27.42458915710449},"model":2089009131,"lockpick":false,"groups":{"cardealer":0},"heading":250,"state":1}'),
	(1125, 'hub 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-30.42845916748047,"y":-1102.469970703125,"z":27.42458915710449},"model":2089009131,"lockpick":false,"groups":{"cardealer":0},"heading":70,"state":1}'),
	(1126, 'hub 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-27.62104988098144,"y":-1094.762939453125,"z":27.42458915710449},"model":2089009131,"lockpick":false,"groups":{"cardealer":0},"heading":250,"state":1}'),
	(1127, 'hub 12', '{"auto":true,"maxDistance":2.0,"hideUi":false,"coords":{"x":-21.51158905029297,"y":-1089.3990478515626,"z":28.11344909667968},"model":1010499530,"lockpick":false,"groups":{"cardealer":0},"heading":160,"state":1}'),
	(1128, 'import 1', '{"auto":6.0,"maxDistance":6.0,"hideUi":false,"coords":{"x":945.9343872070313,"y":-985.5709838867188,"z":41.16889953613281},"model":-983965772,"lockpick":false,"groups":{"mechanic":0},"heading":4,"state":1}'),
	(1129, 'import 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":948.52880859375,"y":-965.3519897460938,"z":39.64353942871094},"model":1289778077,"lockpick":false,"groups":{"mechanic":0},"heading":94,"state":1}'),
	(1130, 'import 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":955.3582153320313,"y":-972.4451904296875,"z":39.64791870117187},"model":-626684119,"lockpick":false,"groups":{"mechanic":0},"heading":184,"state":1}'),
	(1131, 'impound 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-187.0614013671875,"y":-1162.3480224609376,"z":23.82123947143554},"model":-952356348,"lockpick":false,"groups":{"mechanic":0},"heading":90,"state":0}'),
	(1132, 'impound 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-189.63600158691407,"y":-1167.884033203125,"z":23.82123947143554},"model":97297972,"lockpick":false,"groups":{"mechanic":0},"heading":180,"state":0}'),
	(1133, 'impound 3', '{"auto":true,"maxDistance":9.0,"hideUi":false,"coords":{"x":-164.12680053710938,"y":-1160.677978515625,"z":22.63863945007324},"model":1286535678,"lockpick":false,"groups":{"mechanic":0},"heading":180,"state":0}'),
	(1134, 'impound 4', '{"auto":true,"maxDistance":9.0,"hideUi":false,"coords":{"x":-225.07420349121095,"y":-1158.823974609375,"z":22.09534072875976},"model":1286535678,"lockpick":false,"groups":{"mechanic":0},"heading":180,"state":0}'),
	(1135, 'koi 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1040.7950439453126,"y":-1476.4530029296876,"z":5.7252869606018},"model":-1024356886,"lockpick":false,"groups":{"koi":0},"heading":35,"state":1}'),
	(1136, 'koi 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1039.155029296875,"y":-1475.3050537109376,"z":5.7252869606018},"model":-1871959836,"lockpick":false,"groups":{"koi":0},"heading":35,"state":1}'),
	(1137, 'koi 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1044.27197265625,"y":-1488.3509521484376,"z":2.93016099929809},"model":2062115805,"lockpick":false,"groups":{"koi":0},"heading":305,"state":1}'),
	(1138, 'koi 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1045.074951171875,"y":-1487.2039794921876,"z":2.93016099929809},"model":2062115805,"lockpick":false,"groups":{"koi":0},"heading":125,"state":1}'),
	(1139, 'koi 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1058.8680419921876,"y":-1444.20703125,"z":-1.26983499526977},"model":2062115805,"lockpick":false,"groups":{"koi":0},"heading":179,"state":1}'),
	(1140, 'koi 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1057.6429443359376,"y":-1440.06298828125,"z":-1.26983499526977},"model":2062115805,"lockpick":false,"groups":{"koi":0},"heading":269,"state":1}'),
	(1141, 'koi 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1061.458984375,"y":-1439.22705078125,"z":-1.26983499526977},"model":2062115805,"lockpick":false,"groups":{"koi":0},"heading":359,"state":1}'),
	(1142, 'koi 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1066.01904296875,"y":-1442.883056640625,"z":-1.26983499526977},"model":2062115805,"lockpick":false,"groups":{"koi":0},"heading":125,"state":1}'),
	(1143, 'koi 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1073.928955078125,"y":-1441.31298828125,"z":-1.18685102462768},"model":985955573,"lockpick":false,"groups":{"koi":0},"heading":35,"state":1}'),
	(1144, 'koi 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1071.261962890625,"y":-1448.1180419921876,"z":-1.24434602260589},"model":361693292,"lockpick":false,"groups":{"koi":0},"heading":35,"state":1}'),
	(1145, 'koi 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1069.60400390625,"y":-1446.95703125,"z":-1.24434602260589},"model":361693292,"lockpick":false,"groups":{"koi":0},"heading":215,"state":1}'),
	(1146, 'lamesapd 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":827.9520874023438,"y":-1288.7860107421876,"z":28.37117004394531},"model":277920071,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1147, 'lamesapd 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":827.9520874023438,"y":-1291.386962890625,"z":28.37117004394531},"model":-34368499,"lockpick":false,"groups":{"police":0},"heading":270,"state":1}'),
	(1148, 'lamesapd 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":840.08837890625,"y":-1280.9990234375,"z":28.37117004394531},"model":-1011300766,"lockpick":false,"groups":{"police":0},"heading":270,"state":1}'),
	(1149, 'lamesapd 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":840.0861206054688,"y":-1281.823974609375,"z":28.37117004394531},"model":-1189294593,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1150, 'lamesapd 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":849.9324951171875,"y":-1287.345947265625,"z":28.37117004394531},"model":-1983352576,"lockpick":false,"groups":{"police":0},"heading":180,"state":1}'),
	(1151, 'lamesapd 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":852.5330810546875,"y":-1287.345947265625,"z":28.37117004394531},"model":2076628221,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1152, 'lamesapd 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":856.5073852539063,"y":-1287.345947265625,"z":28.37117004394531},"model":-1983352576,"lockpick":false,"groups":{"police":0},"heading":180,"state":1}'),
	(1153, 'lamesapd 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":859.1082153320313,"y":-1287.345947265625,"z":28.37117004394531},"model":2076628221,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1154, 'lamesapd 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":858.864990234375,"y":-1291.385009765625,"z":28.37111091613769},"model":539497004,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1155, 'lamesapd 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":851.94970703125,"y":-1298.3890380859376,"z":28.37117004394531},"model":1861900850,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1156, 'lamesapd 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":834.2813720703125,"y":-1295.9859619140626,"z":28.37117004394531},"model":1162089799,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1157, 'lamesapd 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":835.9445190429688,"y":-1292.1929931640626,"z":27.78268051147461},"model":-147896569,"lockpick":false,"groups":{"police":0},"heading":270,"state":1}'),
	(1158, 'lamesapd 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":837.2611083984375,"y":-1309.5140380859376,"z":28.37111091613769},"model":1491736897,"lockpick":false,"groups":{"police":0},"heading":270,"state":1}'),
	(1159, 'lamesapd 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":846.36962890625,"y":-1310.0400390625,"z":28.37111091613769},"model":272264766,"lockpick":false,"groups":{"police":0},"heading":180,"state":1}'),
	(1160, 'lamesapd 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":854.7811279296875,"y":-1310.0400390625,"z":28.37111091613769},"model":-1213101062,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1161, 'lamesapd 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":855.7421875,"y":-1314.6080322265626,"z":28.37111091613769},"model":-1213101062,"lockpick":false,"groups":{"police":0},"heading":270,"state":1}'),
	(1162, 'lamesapd 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":856.5073852539063,"y":-1310.0379638671876,"z":28.37117004394531},"model":-375301406,"lockpick":false,"groups":{"police":0},"heading":180,"state":1}'),
	(1163, 'lamesapd 18', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":859.1082153320313,"y":-1310.0379638671876,"z":28.37117004394531},"model":-375301406,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1164, 'lamesapd 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":859.0076293945313,"y":-1320.125,"z":28.37111091613769},"model":-1339729155,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1165, 'lamesapd 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":829.6384887695313,"y":-1310.1280517578126,"z":28.37117004394531},"model":-1246730733,"lockpick":false,"groups":{"police":0},"heading":180,"state":1}'),
	(1166, 'lamesapd 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":816.9862060546875,"y":-1325.258056640625,"z":25.09328079223632},"model":-1372582968,"lockpick":false,"groups":{"police":0},"heading":269,"state":1}'),
	(1167, 'lost 1', '{"auto":true,"maxDistance":6.0,"hideUi":false,"coords":{"x":956.4542236328125,"y":-137.84080505371095,"z":73.57489776611328},"model":-930593859,"lockpick":false,"groups":{"lost":0},"heading":148,"state":1}'),
	(1168, 'lost 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":981.1505737304688,"y":-103.25520324707031,"z":74.99358367919922},"model":190770132,"lockpick":false,"groups":{"lost":0},"heading":43,"state":1}'),
	(1169, 'lost 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":959.3823852539063,"y":-120.45120239257813,"z":75.16158294677735},"model":1335311341,"lockpick":false,"groups":{"lost":0},"heading":43,"state":1}'),
	(1170, 'lost 4', '{"auto":6.0,"maxDistance":6.0,"hideUi":false,"coords":{"x":963.159423828125,"y":-117.3218002319336,"z":75.24942016601563},"model":-822900180,"lockpick":false,"groups":{"lost":0},"heading":43,"state":1}'),
	(1171, 'lost 5', '{"auto":6.0,"maxDistance":6.0,"hideUi":false,"coords":{"x":968.7536010742188,"y":-112.10220336914063,"z":75.24942016601563},"model":-822900180,"lockpick":false,"groups":{"lost":0},"heading":43,"state":1}'),
	(1172, 'lost 6', '{"auto":6.0,"maxDistance":6.0,"hideUi":false,"coords":{"x":982.3873901367188,"y":-125.37100219726563,"z":74.9931411743164},"model":-197537718,"lockpick":false,"groups":{"lost":0},"heading":239,"state":1}'),
	(1173, 'lostsc 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":99.63089752197266,"y":3615.9140625,"z":40.63957977294922},"model":190770132,"lockpick":false,"groups":{"lost":0},"heading":270,"state":1}'),
	(1174, 'lostsc 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":102.5613021850586,"y":3607.15087890625,"z":40.64392852783203},"model":747286790,"lockpick":false,"groups":{"lost":0},"heading":360,"state":1}'),
	(1175, 'lostsc 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":104.70330047607422,"y":3610.4580078125,"z":40.6409912109375},"model":747286790,"lockpick":false,"groups":{"lost":0},"heading":90,"state":1}'),
	(1176, 'lscustoms 1', '{"auto":6.0,"maxDistance":6.0,"hideUi":false,"coords":{"x":723.1160278320313,"y":-1088.83203125,"z":23.23200035095215},"model":270330101,"lockpick":false,"groups":{"mechanic":0},"heading":270,"state":1}'),
	(1177, 'marabunta 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1250.2159423828126,"y":-1583.801025390625,"z":54.73965072631836},"model":-955445187,"lockpick":false,"groups":{"marabunta":0},"heading":215,"state":1}'),
	(1178, 'marabunta 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1251.9720458984376,"y":-1569.282958984375,"z":58.93437957763672},"model":-658590816,"lockpick":false,"groups":{"marabunta":0},"heading":215,"state":1}'),
	(1179, 'marabunta 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1257.9549560546876,"y":-1574.5889892578126,"z":58.5396499633789},"model":-296755518,"lockpick":false,"groups":{"marabunta":0},"heading":35,"state":1}'),
	(1180, 'marabunta 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1253.072021484375,"y":-1573.7950439453126,"z":58.5396499633789},"model":-296755518,"lockpick":false,"groups":{"marabunta":0},"heading":35,"state":1}'),
	(1181, 'marabunta 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1250.4310302734376,"y":-1575.64404296875,"z":58.5396499633789},"model":-296755518,"lockpick":false,"groups":{"marabunta":0},"heading":35,"state":1}'),
	(1182, 'marabunta 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1249.2640380859376,"y":-1577.428955078125,"z":58.5396499633789},"model":-296755518,"lockpick":false,"groups":{"marabunta":0},"heading":125,"state":1}'),
	(1183, 'mazebank_arena 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-282.58758544921877,"y":-1924.7840576171876,"z":30.25301933288574},"model":-1911661372,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1184, 'mazebank_arena 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-284.42620849609377,"y":-1923.240966796875,"z":30.25301933288574},"model":160224187,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1185, 'mazebank_arena 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-286.5671081542969,"y":-1921.4439697265626,"z":30.25301933288574},"model":-1911661372,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1186, 'mazebank_arena 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-288.4057922363281,"y":-1919.9019775390626,"z":30.25301933288574},"model":160224187,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1187, 'mazebank_arena 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-299.59521484375,"y":-1928.97802734375,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1188, 'mazebank_arena 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-289.58160400390627,"y":-1937.3800048828126,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1189, 'mazebank_arena 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-283.4648132324219,"y":-1937.73095703125,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1190, 'mazebank_arena 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-285.0076904296875,"y":-1939.5699462890626,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1191, 'mazebank_arena 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-302.54638671875,"y":-1924.85302734375,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1192, 'mazebank_arena 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-301.0033874511719,"y":-1923.0140380859376,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1193, 'mazebank_arena 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-302.00079345703127,"y":-1920.22998046875,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1194, 'mazebank_arena 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-280.5498046875,"y":-1938.22998046875,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1195, 'mazebank_arena 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-288.1545104980469,"y":-1941.447998046875,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1196, 'mazebank_arena 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-289.9932861328125,"y":-1939.905029296875,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1197, 'mazebank_arena 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-302.01080322265627,"y":-1929.821044921875,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1198, 'mazebank_arena 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-303.849609375,"y":-1928.2779541015626,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1199, 'mazebank_arena 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-301.0022888183594,"y":-1923.012939453125,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1200, 'mazebank_arena 18', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-302.5451965332031,"y":-1924.85205078125,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1201, 'mazebank_arena 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-285.006591796875,"y":-1939.5679931640626,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1202, 'mazebank_arena 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-283.4635925292969,"y":-1937.72998046875,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1203, 'mazebank_arena 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-282.67181396484377,"y":-1946.0489501953126,"z":34.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1204, 'mazebank_arena 22', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-284.510498046875,"y":-1944.5059814453126,"z":34.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1205, 'mazebank_arena 23', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-307.49359130859377,"y":-1925.220947265625,"z":34.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1206, 'mazebank_arena 24', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-309.3323974609375,"y":-1923.677978515625,"z":34.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1207, 'mazebank_arena 25', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-307.49359130859377,"y":-1925.220947265625,"z":38.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1208, 'mazebank_arena 26', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-309.3323974609375,"y":-1923.677978515625,"z":38.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1209, 'mazebank_arena 27', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-282.67181396484377,"y":-1946.0489501953126,"z":38.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1210, 'mazebank_arena 28', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-284.510498046875,"y":-1944.5059814453126,"z":38.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1211, 'mazebank_arena 29', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-292.9879150390625,"y":-1940.344970703125,"z":38.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1212, 'mazebank_arena 30', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-301.9236145019531,"y":-1932.8470458984376,"z":38.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1213, 'mazebank_arena 31', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-307.49359130859377,"y":-1925.220947265625,"z":42.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1214, 'mazebank_arena 32', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-309.3323974609375,"y":-1923.677978515625,"z":42.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1215, 'mazebank_arena 33', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-282.67181396484377,"y":-1946.0489501953126,"z":42.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1216, 'mazebank_arena 34', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-284.510498046875,"y":-1944.5059814453126,"z":42.15301895141601},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1217, 'mazebank_arena 35', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-351.65960693359377,"y":-1904.279052734375,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1218, 'mazebank_arena 36', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-353.4984130859375,"y":-1902.7359619140626,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1219, 'mazebank_arena 37', '{"auto":true,"maxDistance":6.0,"hideUi":false,"coords":{"x":-386.86419677734377,"y":-1884.2469482421876,"z":21.68489074707031},"model":-1098702270,"lockpick":false,"groups":{"mba":0},"heading":210,"state":0}'),
	(1220, 'mazebank_arena 38', '{"auto":true,"maxDistance":6.0,"hideUi":false,"coords":{"x":-375.9490051269531,"y":-1878.93798828125,"z":21.6749095916748},"model":-1098702270,"lockpick":false,"groups":{"mba":0},"heading":201,"state":0}'),
	(1221, 'mazebank_arena 39', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-255.77439880371095,"y":-2027.6739501953126,"z":30.25301933288574},"model":-1911661372,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1222, 'mazebank_arena 40', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-254.23150634765626,"y":-2025.8349609375,"z":30.25301933288574},"model":160224187,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1223, 'mazebank_arena 41', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-270.07220458984377,"y":-2019.4420166015626,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1224, 'mazebank_arena 42', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-264.6426086425781,"y":-2012.970947265625,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1225, 'mazebank_arena 43', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-273.69989013671877,"y":-2020.967041015625,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1226, 'mazebank_arena 44', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-272.1570129394531,"y":-2019.1280517578126,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1227, 'mazebank_arena 45', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-265.3132019042969,"y":-2010.9720458984376,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1228, 'mazebank_arena 46', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-263.7702941894531,"y":-2009.133056640625,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1229, 'mazebank_arena 47', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-262.29730224609377,"y":-2008.9329833984376,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1230, 'mazebank_arena 48', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-260.45849609375,"y":-2010.4759521484376,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1231, 'mazebank_arena 49', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-271.80230712890627,"y":-2023.9949951171876,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1232, 'mazebank_arena 50', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-273.64111328125,"y":-2022.4520263671876,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1233, 'mazebank_arena 51', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-275.8454895019531,"y":-2020.60302734375,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1234, 'mazebank_arena 52', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-264.501708984375,"y":-2007.0830078125,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1235, 'mazebank_arena 53', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-260.45849609375,"y":-2010.4759521484376,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1236, 'mazebank_arena 54', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-262.29730224609377,"y":-2008.9329833984376,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1237, 'mazebank_arena 55', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-273.64111328125,"y":-2022.4520263671876,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1238, 'mazebank_arena 56', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-271.80230712890627,"y":-2023.9949951171876,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":140,"state":0}'),
	(1239, 'mazebank_arena 57', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-258.69061279296877,"y":-2014.5849609375,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1240, 'mazebank_arena 58', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-260.2333984375,"y":-2016.4239501953126,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1241, 'mazebank_arena 59', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-265.9057922363281,"y":-2023.1839599609376,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1242, 'mazebank_arena 60', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-267.4486083984375,"y":-2025.02197265625,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1243, 'mazebank_arena 61', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-279.6094970703125,"y":-2009.5870361328126,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1244, 'mazebank_arena 62', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-276.01031494140627,"y":-2005.2979736328126,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":320,"state":0}'),
	(1245, 'mazebank_arena 63', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-279.26849365234377,"y":-2007.781005859375,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1246, 'mazebank_arena 64', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-277.7257995605469,"y":-2005.9420166015626,"z":21.71077919006347},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1247, 'mazebank_arena 65', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-279.49700927734377,"y":-2007.5860595703126,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":50,"state":0}'),
	(1248, 'mazebank_arena 66', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-277.9541015625,"y":-2005.748046875,"z":30.25301933288574},"model":1722387194,"lockpick":false,"groups":{"mba":0},"heading":230,"state":0}'),
	(1249, 'mirrorpark1 1', '{"items":[{"name":"keys_mirror1_1","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":978.4755859375,"y":-716.1016235351563,"z":58.43925857543945},"model":-232187956,"lockpick":false,"state":0,"heading":132}'),
	(1250, 'mirrorpark1 2', '{"items":[{"name":"keys_mirror1_1","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":982.3516235351563,"y":-726.18359375,"z":58.14799880981445},"model":-2080370239,"lockpick":false,"state":0,"heading":222}'),
	(1251, 'mirrorpark1 3', '{"items":[{"name":"keys_mirror1_1","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":971.6005859375,"y":-726.4807739257813,"z":58.34379959106445},"model":12662004,"lockpick":false,"state":0,"heading":222}'),
	(1252, 'mirrorpark1 4', '{"items":[{"name":"keys_mirror1_2","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":1098.833984375,"y":-438.9997863769531,"z":68.00890350341797},"model":-232187956,"lockpick":false,"state":0,"heading":173}'),
	(1253, 'mirrorpark1 5', '{"items":[{"name":"keys_mirror1_2","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":1108.343994140625,"y":-444.12078857421877,"z":67.71765899658203},"model":-2080370239,"lockpick":false,"state":0,"heading":263}'),
	(1254, 'mirrorpark1 6', '{"items":[{"name":"keys_mirror1_2","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":1100.384033203125,"y":-451.35260009765627,"z":67.91343688964844},"model":12662004,"lockpick":false,"state":0,"heading":263}'),
	(1255, 'mirrorpark1 7', '{"items":[{"name":"keys_mirror1_3","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":1251.2340087890626,"y":-493.4761962890625,"z":70.1250991821289},"model":-232187956,"lockpick":false,"state":0,"heading":77}'),
	(1256, 'mirrorpark1 8', '{"items":[{"name":"keys_mirror1_3","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":1245.199951171875,"y":-502.4338073730469,"z":69.8338394165039},"model":-2080370239,"lockpick":false,"state":0,"heading":167}'),
	(1257, 'mirrorpark1 9', '{"items":[{"name":"keys_mirror1_3","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":1238.7900390625,"y":-493.7973937988281,"z":70.0296401977539},"model":12662004,"lockpick":false,"state":0,"heading":167}'),
	(1258, 'mirrorpark2 1', '{"items":[{"name":"keys_mirror2_1","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":943.4299926757813,"y":-652.609619140625,"z":58.72103881835937},"model":-1422530141,"lockpick":false,"state":0,"heading":130}'),
	(1259, 'mirrorpark2 2', '{"items":[{"name":"keys_mirror2_1","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":934.580810546875,"y":-651.85400390625,"z":58.52228164672851},"model":-672840959,"lockpick":false,"state":0,"heading":130}'),
	(1260, 'mirrorpark2 3', '{"items":[{"name":"keys_mirror2_2","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":945.1005859375,"y":-518.7495727539063,"z":60.91783905029297},"model":-1422530141,"lockpick":false,"state":0,"heading":210}'),
	(1261, 'mirrorpark2 4', '{"items":[{"name":"keys_mirror2_2","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":942.7999877929688,"y":-527.3278198242188,"z":60.71908187866211},"model":-672840959,"lockpick":false,"state":0,"heading":210}'),
	(1262, 'mirrorpark2 5', '{"items":[{"name":"keys_mirror2_3","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":1221.0579833984376,"y":-669.8225708007813,"z":63.7854995727539},"model":-1422530141,"lockpick":false,"state":0,"heading":283}'),
	(1263, 'mirrorpark2 6', '{"items":[{"name":"keys_mirror2_3","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":1228.5579833984376,"y":-674.5797729492188,"z":63.58673858642578},"model":-672840959,"lockpick":false,"state":0,"heading":283}'),
	(1264, 'mrpd 1', '{"maxDistance":2,"hideUi":false,"coords":{"x":434.744384765625,"y":-981.9168701171875,"z":30.81529998779297},"doors":[{"model":-1547307588,"coords":{"x":434.744384765625,"y":-983.078125,"z":30.81529998779297},"heading":90},{"model":-1547307588,"coords":{"x":434.744384765625,"y":-980.755615234375,"z":30.81529998779297},"heading":270}],"lockpick":true,"groups":{"police":0,"offpolice":0},"state":0}'),
	(1265, 'mrpd 2', '{"maxDistance":2,"hideUi":false,"coords":{"x":457.0474548339844,"y":-972.2542724609375,"z":30.81529998779297},"doors":[{"model":-1547307588,"coords":{"x":458.2087097167969,"y":-972.2542724609375,"z":30.81529998779297},"heading":180},{"model":-1547307588,"coords":{"x":455.8861999511719,"y":-972.2542724609375,"z":30.81529998779297},"heading":0}],"groups":{"police":0,"offpolice":0},"state":1}'),
	(1266, 'mrpd 3', '{"maxDistance":2,"hideUi":false,"coords":{"x":441.9005126953125,"y":-998.7462158203125,"z":30.81529998779297},"doors":[{"model":-1547307588,"coords":{"x":440.73919677734377,"y":-998.7462158203125,"z":30.81529998779297},"heading":0},{"model":-1547307588,"coords":{"x":443.0617980957031,"y":-998.7462158203125,"z":30.81529998779297},"heading":180}],"groups":{"police":0,"offpolice":0},"state":1}'),
	(1267, 'mrpd 4', '{"maxDistance":2,"hideUi":false,"coords":{"x":441.1300048828125,"y":-977.9299926757813,"z":30.82319068908691},"model":-1406685646,"groups":{"police":0},"heading":0,"state":1}'),
	(1268, 'mrpd 5', '{"maxDistance":2,"hideUi":false,"coords":{"x":440.5201110839844,"y":-986.2335205078125,"z":30.82319068908691},"model":-96679321,"groups":{"police":0,"offpolice":0},"heading":180,"state":1}'),
	(1269, 'mrpd 6', '{"maxDistance":2,"hideUi":false,"coords":{"x":464.1590881347656,"y":-974.6655883789063,"z":26.37070083618164},"model":1830360419,"groups":{"police":0,"offpolice":0},"heading":270,"state":1}'),
	(1270, 'mrpd 7', '{"maxDistance":2,"hideUi":false,"coords":{"x":464.1565856933594,"y":-997.50927734375,"z":26.37070083618164},"model":1830360419,"groups":{"police":0,"offpolice":0},"heading":90,"state":1}'),
	(1271, 'mrpd 8', '{"maxDistance":6,"auto":true,"state":1,"doors":false,"autolock":5,"heading":0,"groups":{"police":0,"offpolice":0},"unlockSound":"button-remote","doorRate":1.5,"lockSound":"button-remote","model":2130672747,"coords":{"x":431.4118957519531,"y":-1000.771728515625,"z":26.69660949707031}}'),
	(1272, 'mrpd 9', '{"maxDistance":6,"auto":true,"state":1,"doors":false,"autolock":5,"heading":0,"groups":{"police":0,"offpolice":0},"unlockSound":"button-remote","doorRate":1.5,"lockSound":"button-remote","model":2130672747,"coords":{"x":452.3005065917969,"y":-1000.771728515625,"z":26.69660949707031}}'),
	(1273, 'mrpd 10', '{"auto":true,"maxDistance":6,"hideUi":false,"coords":{"x":488.8948059082031,"y":-1017.2119750976563,"z":27.14934921264648},"model":-1603817716,"groups":{"police":0,"offpolice":0},"heading":90,"lockSound":"button-remote","state":1}'),
	(1274, 'mrpd 11', '{"maxDistance":2,"hideUi":false,"coords":{"x":468.5714416503906,"y":-1014.406005859375,"z":26.48381996154785},"doors":[{"model":-692649124,"coords":{"x":467.36859130859377,"y":-1014.406005859375,"z":26.48381996154785},"heading":0},{"model":-692649124,"coords":{"x":469.7742919921875,"y":-1014.406005859375,"z":26.48381996154785},"heading":180}],"groups":{"police":0,"offpolice":0},"state":1}'),
	(1275, 'mrpd 12', '{"maxDistance":2,"hideUi":false,"coords":{"x":475.9538879394531,"y":-1010.8189697265625,"z":26.40638923645019},"model":-1406685646,"groups":{"police":0},"heading":180,"state":1}'),
	(1276, 'mrpd 13', '{"maxDistance":2,"hideUi":false,"coords":{"x":476.6156921386719,"y":-1008.875,"z":26.48004913330078},"model":-53345114,"groups":{"police":0},"state":1,"heading":270,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1277, 'mrpd 14', '{"maxDistance":2,"hideUi":false,"coords":{"x":481.0083923339844,"y":-1004.1179809570313,"z":26.48004913330078},"model":-53345114,"groups":{"police":0},"state":1,"heading":180,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1278, 'mrpd 15', '{"maxDistance":2,"hideUi":false,"coords":{"x":477.91259765625,"y":-1012.1890258789063,"z":26.48004913330078},"model":-53345114,"groups":{"police":0},"state":1,"heading":0,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1279, 'mrpd 16', '{"maxDistance":2,"hideUi":false,"coords":{"x":480.9128112792969,"y":-1012.1890258789063,"z":26.48004913330078},"model":-53345114,"groups":{"police":0},"state":1,"heading":0,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1280, 'mrpd 17', '{"maxDistance":2,"hideUi":false,"coords":{"x":483.9126892089844,"y":-1012.1890258789063,"z":26.48004913330078},"model":-53345114,"groups":{"police":0},"state":1,"heading":0,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1281, 'mrpd 18', '{"maxDistance":2,"hideUi":false,"coords":{"x":486.9130859375,"y":-1012.1890258789063,"z":26.48004913330078},"model":-53345114,"groups":{"police":0},"state":1,"heading":0,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1282, 'mrpd 19', '{"maxDistance":2,"hideUi":false,"coords":{"x":484.1763916015625,"y":-1007.7340087890625,"z":26.48004913330078},"model":-53345114,"groups":{"police":0},"state":1,"heading":180,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1283, 'mrpd 20', '{"maxDistance":2,"hideUi":false,"coords":{"x":479.05999755859377,"y":-1003.1729736328125,"z":26.4064998626709},"model":-288803980,"groups":{"police":0},"heading":90,"state":1}'),
	(1284, 'mrpd 21', '{"maxDistance":2,"hideUi":false,"coords":{"x":482.6694030761719,"y":-983.98681640625,"z":26.40547943115234},"model":-1406685646,"groups":{"police":0},"heading":270,"state":1}'),
	(1285, 'mrpd 22', '{"maxDistance":2,"hideUi":false,"coords":{"x":482.67010498046877,"y":-987.5792236328125,"z":26.40547943115234},"model":-1406685646,"groups":{"police":0},"heading":270,"state":1}'),
	(1286, 'mrpd 23', '{"maxDistance":2,"hideUi":false,"coords":{"x":482.6698913574219,"y":-992.299072265625,"z":26.40547943115234},"model":-1406685646,"groups":{"police":0},"heading":270,"state":1}'),
	(1287, 'mrpd 24', '{"maxDistance":2,"hideUi":false,"coords":{"x":482.6702880859375,"y":-995.728515625,"z":26.40547943115234},"model":-1406685646,"groups":{"police":0},"heading":270,"state":1}'),
	(1288, 'mrpd 25', '{"maxDistance":2,"hideUi":false,"coords":{"x":475.8323059082031,"y":-990.48388671875,"z":26.40547943115234},"model":-692649124,"groups":{"police":0},"heading":135,"state":1}'),
	(1289, 'mrpd 26', '{"maxDistance":2,"hideUi":false,"coords":{"x":479.7507019042969,"y":-999.6290283203125,"z":30.78927040100097},"model":-692649124,"groups":{"police":0},"heading":90,"state":1}'),
	(1290, 'mrpd 27', '{"maxDistance":2,"hideUi":false,"coords":{"x":487.43780517578127,"y":-1000.1890258789063,"z":30.7869701385498},"model":-692649124,"groups":{"police":0},"heading":181,"state":1}'),
	(1291, 'mrpd 28', '{"maxDistance":2,"hideUi":false,"coords":{"x":486.81585693359377,"y":-1002.9019775390625,"z":30.7869701385498},"doors":[{"model":-692649124,"coords":{"x":485.6133117675781,"y":-1002.9019775390625,"z":30.7869701385498},"heading":0},{"model":-692649124,"coords":{"x":488.0184020996094,"y":-1002.9019775390625,"z":30.7869701385498},"heading":180}],"groups":{"police":0},"state":1}'),
	(1292, 'mrpd 29', '{"maxDistance":2,"hideUi":false,"coords":{"x":464.30859375,"y":-984.5283813476563,"z":43.771240234375},"model":-692649124,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1295, 'ottos 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":823.8389892578125,"y":-805.5819702148438,"z":27.39546012878418},"model":270330101,"lockpick":false,"groups":{"ottos":0},"heading":270,"state":1}'),
	(1296, 'ottos 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":823.8389892578125,"y":-812.9501953125,"z":27.39546012878418},"model":270330101,"lockpick":false,"groups":{"ottos":0},"heading":270,"state":1}'),
	(1297, 'ottos 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":823.839111328125,"y":-820.27099609375,"z":27.39546012878418},"model":270330101,"lockpick":false,"groups":{"ottos":0},"heading":270,"state":1}'),
	(1298, 'ottos 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":823.76123046875,"y":-828.9948120117188,"z":26.48237991333007},"model":-147325430,"lockpick":false,"groups":{"ottos":0},"heading":90,"state":1}'),
	(1299, 'ottos 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":830.619873046875,"y":-829.0283813476563,"z":26.48237991333007},"model":-147325430,"lockpick":false,"groups":{"ottos":0},"heading":90,"state":1}'),
	(1300, 'ottos 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":829.9661865234375,"y":-824.6746826171875,"z":26.48237991333007},"model":-147325430,"lockpick":false,"groups":{"ottos":0},"heading":180,"state":1}'),
	(1301, 'ottos 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":837.653076171875,"y":-821.3134765625,"z":26.48237991333007},"model":-147325430,"lockpick":false,"groups":{"ottos":0},"heading":270,"state":1}'),
	(1302, 'ottos 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":840.5321044921875,"y":-820.5623779296875,"z":26.48237037658691},"model":263193286,"lockpick":false,"groups":{"ottos":0},"heading":0,"state":1}'),
	(1303, 'ottos 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":800.3914794921875,"y":-824.3546142578125,"z":26.48451995849609},"model":-147325430,"lockpick":false,"groups":{"ottos":0},"heading":0,"state":1}'),
	(1304, 'ottos 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":802.2042236328125,"y":-829.1265258789063,"z":26.48451995849609},"model":-147325430,"lockpick":false,"groups":{"ottos":0},"heading":180,"state":1}'),
	(1305, 'ottos 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":800.0900268554688,"y":-827.1212158203125,"z":26.48451995849609},"model":-147325430,"lockpick":false,"groups":{"ottos":0},"heading":270,"state":1}'),
	(1306, 'ottos 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":818.3853759765625,"y":-784.4561157226563,"z":26.32102966308593},"model":997554217,"lockpick":false,"groups":{"ottos":0},"heading":360,"state":1}'),
	(1307, 'ottos 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":815.784912109375,"y":-784.4500732421875,"z":26.32102966308593},"model":1196685123,"lockpick":false,"groups":{"ottos":0},"heading":180,"state":1}'),
	(1308, 'ottos 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":812.2520141601563,"y":-777.1773071289063,"z":26.32630920410156},"model":1266035946,"lockpick":false,"groups":{"ottos":0},"heading":360,"state":1}'),
	(1309, 'pacificbank 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":231.5030975341797,"y":216.51339721679688,"z":106.4303970336914},"model":1577691629,"lockpick":false,"groups":{"bank":0},"heading":115,"state":0}'),
	(1310, 'pacificbank 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":232.60069274902345,"y":214.15640258789063,"z":106.4303970336914},"model":726025323,"lockpick":false,"groups":{"bank":0},"heading":295,"state":0}'),
	(1311, 'pacificbank 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":267.3222961425781,"y":200.7541961669922,"z":106.44989776611328},"model":726025323,"lockpick":false,"groups":{"bank":0},"heading":340,"state":0}'),
	(1312, 'pacificbank 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":264.8785095214844,"y":201.64370727539063,"z":106.44989776611328},"model":1577691629,"lockpick":false,"groups":{"bank":0},"heading":160,"state":0}'),
	(1313, 'pacificbank 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":273.8970031738281,"y":234.58619689941407,"z":123.97480010986328},"model":1577691629,"lockpick":false,"groups":{"bank":0},"heading":340,"state":1}'),
	(1314, 'pacificbank 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":271.45330810546877,"y":235.47569274902345,"z":123.97480010986328},"model":726025323,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1315, 'pacificbank 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":244.77549743652345,"y":227.24789428710938,"z":106.74520111083985},"model":1352863520,"lockpick":false,"groups":{"bank":0},"heading":70,"state":1}'),
	(1316, 'pacificbank 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":244.03900146484376,"y":225.2241973876953,"z":106.74520111083985},"model":1352863520,"lockpick":false,"groups":{"bank":0},"heading":250,"state":1}'),
	(1317, 'pacificbank 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":272.7904968261719,"y":206.48049926757813,"z":106.3822021484375},"model":267980221,"lockpick":false,"groups":{"bank":0},"heading":340,"state":1}'),
	(1318, 'pacificbank 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":272.7904968261719,"y":206.48049926757813,"z":110.28050231933594},"model":267980221,"lockpick":false,"groups":{"bank":0},"heading":340,"state":1}'),
	(1319, 'pacificbank 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":277.5953063964844,"y":223.54159545898438,"z":110.2791976928711},"model":267980221,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1320, 'pacificbank 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":277.5953063964844,"y":223.54159545898438,"z":106.38040161132813},"model":267980221,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1321, 'pacificbank 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":256.6068115234375,"y":229.68960571289063,"z":106.37020111083985},"model":-2121568016,"lockpick":false,"groups":{"bank":0},"heading":70,"state":1}'),
	(1322, 'pacificbank 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":251.5198974609375,"y":215.71319580078126,"z":106.37020111083985},"model":-2121568016,"lockpick":false,"groups":{"bank":0},"heading":250,"state":1}'),
	(1323, 'pacificbank 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":270.230712890625,"y":221.26730346679688,"z":106.37020111083985},"model":-2121568016,"lockpick":false,"groups":{"bank":0},"heading":70,"state":1}'),
	(1324, 'pacificbank 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":267.3699951171875,"y":213.4080047607422,"z":106.37020111083985},"model":-2121568016,"lockpick":false,"groups":{"bank":0},"heading":250,"state":1}'),
	(1325, 'pacificbank 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":252.789794921875,"y":213.75999450683595,"z":106.3822021484375},"model":1721645826,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1326, 'pacificbank 18', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":262.18389892578127,"y":210.3408966064453,"z":106.3822021484375},"model":1721645826,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1327, 'pacificbank 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":252.789794921875,"y":213.75999450683595,"z":110.28050231933594},"model":1721645826,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1328, 'pacificbank 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":262.18389892578127,"y":210.3408966064453,"z":110.28050231933594},"model":1721645826,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1329, 'pacificbank 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":258.8164978027344,"y":230.37640380859376,"z":106.3822021484375},"model":1721645826,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1330, 'pacificbank 22', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":268.2106018066406,"y":226.95730590820313,"z":106.3822021484375},"model":1721645826,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1331, 'pacificbank 23', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":258.8164978027344,"y":230.37640380859376,"z":110.28050231933594},"model":1721645826,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1332, 'pacificbank 24', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":268.2106018066406,"y":226.95730590820313,"z":110.28050231933594},"model":1721645826,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1333, 'pacificbank 25', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":273.18389892578127,"y":216.86279296875,"z":110.28050231933594},"model":1109357065,"lockpick":false,"groups":{"bank":0},"heading":70,"state":1}'),
	(1334, 'pacificbank 26', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":272.47210693359377,"y":214.9073028564453,"z":110.28050231933594},"model":1109357065,"lockpick":false,"groups":{"bank":0},"heading":250,"state":1}'),
	(1335, 'pacificbank 27', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":270.10321044921877,"y":212.9228973388672,"z":97.31797790527344},"model":409280169,"lockpick":false,"groups":{"bank":0},"heading":340,"state":1}'),
	(1336, 'pacificbank 28', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":272.6422119140625,"y":219.89869689941407,"z":97.31797790527344},"model":409280169,"lockpick":false,"groups":{"bank":0},"heading":340,"state":1}'),
	(1337, 'pacificbank 29', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":265.77911376953127,"y":225.86680603027345,"z":97.31797790527344},"model":409280169,"lockpick":false,"groups":{"bank":0},"heading":70,"state":1}'),
	(1338, 'pacificbank 30', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":256.41241455078127,"y":229.27589416503907,"z":97.31797790527344},"model":409280169,"lockpick":false,"groups":{"bank":0},"heading":70,"state":1}'),
	(1339, 'pacificbank 31', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":251.64979553222657,"y":216.1905975341797,"z":97.31797790527344},"model":409280169,"lockpick":false,"groups":{"bank":0},"heading":250,"state":1}'),
	(1340, 'pacificbank 32', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":244.55799865722657,"y":216.8972930908203,"z":97.31797790527344},"model":409280169,"lockpick":false,"groups":{"bank":0},"heading":340,"state":1}'),
	(1341, 'pacificbank 33', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":250.56419372558595,"y":233.39939880371095,"z":97.31797790527344},"model":409280169,"lockpick":false,"groups":{"bank":0},"heading":340,"state":1}'),
	(1342, 'pacificbank 34', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":234.98570251464845,"y":228.06959533691407,"z":97.72184753417969},"model":961976194,"lockpick":false,"groups":{"bank":0},"heading":70,"state":1}'),
	(1343, 'pacificbank 35', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":229.8905029296875,"y":227.3419952392578,"z":97.32396697998047},"model":643152522,"lockpick":false,"groups":{"bank":0},"heading":340,"state":1}'),
	(1344, 'pacificbank 36', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":225.64630126953126,"y":228.8867950439453,"z":97.32396697998047},"model":643152522,"lockpick":false,"groups":{"bank":0},"heading":160,"state":1}'),
	(1345, 'paleto247 1', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":162.4945068359375,"y":6637.0126953125,"z":31.84888076782226},"doors":[{"model":997554217,"coords":{"x":163.41409301757813,"y":6636.0927734375,"z":31.84888076782226},"heading":315},{"model":1196685123,"coords":{"x":161.5749053955078,"y":6637.93310546875,"z":31.84888076782226},"heading":135}],"lockpick":false,"groups":{"unemployed":0},"state":0}'),
	(1346, 'paletobank 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-110.64230346679688,"y":6462.01318359375,"z":31.7933406829834},"model":2063730765,"lockpick":false,"groups":{"bank":0},"heading":135,"state":0}'),
	(1347, 'paletobank 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-116.51270294189453,"y":6478.9599609375,"z":31.78797912597656},"model":1248599813,"lockpick":false,"groups":{"bank":0},"heading":225,"state":0}'),
	(1348, 'paletobank 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-96.70865631103516,"y":6474.05712890625,"z":31.78797912597656},"model":1248599813,"lockpick":false,"groups":{"bank":0},"heading":135,"state":1}'),
	(1349, 'paletobank 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-92.23223114013672,"y":6468.9599609375,"z":31.78797912597656},"model":-147325430,"lockpick":false,"groups":{"bank":0},"heading":225,"state":1}'),
	(1350, 'paletobank 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-100.11229705810547,"y":6474.39208984375,"z":31.78797912597656},"model":-147325430,"lockpick":false,"groups":{"bank":0},"heading":315,"state":1}'),
	(1351, 'paletobank 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-111.0427017211914,"y":6475.328125,"z":31.78797912597656},"model":-56652918,"lockpick":false,"groups":{"bank":0},"heading":225,"state":1}'),
	(1352, 'paletobank 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-104.83709716796875,"y":6463.77392578125,"z":31.79335021972656},"model":2110946875,"lockpick":false,"groups":{"bank":0},"heading":225,"state":1}'),
	(1353, 'paletobank 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-100.62169647216797,"y":6467.98876953125,"z":31.79335021972656},"model":1754616769,"lockpick":false,"groups":{"bank":0},"heading":45,"state":1}'),
	(1354, 'paletobank 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-104.70570373535156,"y":6473.91796875,"z":31.78797912597656},"model":-368548260,"lockpick":false,"groups":{"bank":0},"heading":45,"state":1}'),
	(1355, 'paletobank 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-100.24189758300781,"y":6464.548828125,"z":31.88459968566894},"model":-2050208642,"lockpick":false,"groups":{"bank":0},"heading":225,"state":1}'),
	(1356, 'paletocamp 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1432.4200439453126,"y":6338.22021484375,"z":24.02297973632812},"model":1471868433,"lockpick":false,"groups":{"paleto":0},"heading":0,"state":1}'),
	(1357, 'paletocamp 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1424.427001953125,"y":6331.2978515625,"z":23.99482917785644},"model":1729989846,"lockpick":false,"groups":{"paleto":0},"heading":270,"state":1}'),
	(1358, 'paletocamp 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1424.427001953125,"y":6327.9921875,"z":23.99482917785644},"model":1729989846,"lockpick":false,"groups":{"paleto":0},"heading":270,"state":1}'),
	(1359, 'paletocamp 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1429.0870361328126,"y":6329.18798828125,"z":23.99482917785644},"model":1729989846,"lockpick":false,"groups":{"paleto":0},"heading":90,"state":1}'),
	(1360, 'paletoliquor 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-156.94650268554688,"y":6327.18798828125,"z":31.73090934753418},"model":-1212951353,"lockpick":false,"groups":{"unemployed":0},"heading":135,"state":0}'),
	(1361, 'paletoliquor 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-164.65240478515626,"y":6318.26904296875,"z":31.73678016662597},"model":1173348778,"lockpick":false,"groups":{"unemployed":0},"heading":315,"state":0}'),
	(1362, 'paletopd 1', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-437.87908935546877,"y":6013.654296875,"z":32.28850936889648},"doors":[{"model":965382714,"coords":{"x":-438.58648681640627,"y":6014.36181640625,"z":32.28850936889648},"heading":315},{"model":733214349,"coords":{"x":-437.17169189453127,"y":6012.94677734375,"z":32.28850936889648},"heading":135}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1363, 'paletopd 2', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-454.1942443847656,"y":5997.3447265625,"z":32.28850936889648},"doors":[{"model":965382714,"coords":{"x":-453.4867858886719,"y":5996.63720703125,"z":32.28850936889648},"heading":135},{"model":733214349,"coords":{"x":-454.9017028808594,"y":5998.0517578125,"z":32.28850936889648},"heading":315}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1364, 'paletopd 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-443.9599914550781,"y":6017.162109375,"z":32.28850936889648},"model":1362051455,"lockpick":false,"groups":{"police":0},"heading":225,"state":1}'),
	(1365, 'paletopd 4', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-447.36383056640627,"y":6004.16064453125,"z":32.28850936889648},"doors":[{"model":1857649811,"coords":{"x":-448.0712890625,"y":6004.8681640625,"z":32.28850936889648},"heading":315},{"model":1362051455,"coords":{"x":-446.6564025878906,"y":6003.453125,"z":32.28850936889648},"heading":135}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1366, 'paletopd 5', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-450.7172546386719,"y":6004.12744140625,"z":32.28850936889648},"doors":[{"model":1857649811,"coords":{"x":-450.0097961425781,"y":6004.8349609375,"z":32.28850936889648},"heading":225},{"model":1362051455,"coords":{"x":-451.4247131347656,"y":6003.419921875,"z":32.28850936889648},"heading":45}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1367, 'paletopd 6', '{"maxDistance":1.5,"hideUi":false,"coords":{"x":-450.7172546386719,"y":6004.12744140625,"z":36.99581909179687},"doors":[{"model":1362051455,"coords":{"x":-451.4247131347656,"y":6003.419921875,"z":36.99581909179687},"heading":45},{"model":1857649811,"coords":{"x":-450.0097961425781,"y":6004.8349609375,"z":36.99581909179687},"heading":225}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1368, 'paletopd 7', '{"maxDistance":1.5,"hideUi":false,"coords":{"x":-449.67840576171877,"y":5999.34521484375,"z":36.99581909179687},"model":1362051455,"lockpick":false,"groups":{"police":0},"heading":135,"state":1}'),
	(1369, 'paletopd 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-447.4444885253906,"y":6011.51220703125,"z":36.99581909179687},"model":1362051455,"lockpick":false,"groups":{"police":0},"heading":45,"state":1}'),
	(1370, 'paletopd 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-441.672607421875,"y":6009.14404296875,"z":36.99581909179687},"model":1362051455,"lockpick":false,"groups":{"police":0},"heading":315,"state":1}'),
	(1371, 'paletopd 10', '{"maxDistance":1.5,"hideUi":false,"coords":{"x":-444.79901123046877,"y":6003.3583984375,"z":37.31838989257812},"doors":[{"model":1127654798,"coords":{"x":-445.64569091796877,"y":6002.51123046875,"z":37.34019088745117},"heading":225},{"model":899779172,"coords":{"x":-443.9523010253906,"y":6004.205078125,"z":37.29658889770508},"heading":225}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1372, 'paletopd 11', '{"maxDistance":1.5,"hideUi":false,"coords":{"x":-447.7691650390625,"y":6000.3876953125,"z":37.31838989257812},"doors":[{"model":1127654798,"coords":{"x":-448.6158142089844,"y":5999.541015625,"z":37.34019088745117},"heading":225},{"model":899779172,"coords":{"x":-446.9224853515625,"y":6001.23388671875,"z":37.29658889770508},"heading":225}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1373, 'paletopd 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-437.1285095214844,"y":6004.658203125,"z":36.99581909179687},"model":1362051455,"lockpick":false,"groups":{"police":0},"heading":315,"state":1}'),
	(1374, 'paletopd 13', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-450.7172546386719,"y":6004.12744140625,"z":27.58120918273925},"doors":[{"model":1857649811,"coords":{"x":-450.0097961425781,"y":6004.8349609375,"z":27.58120918273925},"heading":225},{"model":1362051455,"coords":{"x":-451.4247131347656,"y":6003.419921875,"z":27.58120918273925},"heading":45}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1375, 'paletopd 14', '{"maxDistance":1.5,"hideUi":false,"coords":{"x":-449.5087890625,"y":5999.4677734375,"z":27.58120918273925},"model":1362051455,"lockpick":false,"groups":{"police":0},"heading":135,"state":1}'),
	(1376, 'paletopd 15', '{"maxDistance":1.5,"hideUi":false,"coords":{"x":-447.2913513183594,"y":6000.6923828125,"z":27.58120918273925},"doors":[{"model":1857649811,"coords":{"x":-447.9988098144531,"y":5999.98486328125,"z":27.58120918273925},"heading":45},{"model":1362051455,"coords":{"x":-446.5838928222656,"y":6001.39990234375,"z":27.58120918273925},"heading":225}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1377, 'paletopd 16', '{"maxDistance":1.0,"hideUi":false,"coords":{"x":-445.3536071777344,"y":5995.341796875,"z":27.58120918273925},"model":1362051455,"lockpick":false,"groups":{"police":0},"heading":315,"state":1}'),
	(1378, 'paletopd 17', '{"maxDistance":1.0,"hideUi":false,"coords":{"x":-446.4798889160156,"y":5996.46923828125,"z":27.58120918273925},"model":1362051455,"lockpick":false,"groups":{"police":0},"heading":135,"state":1}'),
	(1379, 'paletopd 18', '{"maxDistance":1.0,"hideUi":false,"coords":{"x":-443.0611877441406,"y":5999.8740234375,"z":27.58120918273925},"model":1362051455,"lockpick":false,"groups":{"police":0},"heading":135,"state":1}'),
	(1380, 'paletopd 19', '{"maxDistance":1.0,"hideUi":false,"coords":{"x":-441.94158935546877,"y":5998.75390625,"z":27.58120918273925},"model":1362051455,"lockpick":false,"groups":{"police":0},"heading":315,"state":1}'),
	(1381, 'paletopd 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-443.6405029296875,"y":6006.97314453125,"z":27.73100090026855},"model":-594854737,"lockpick":false,"groups":{"police":0},"state":1,"heading":315,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1382, 'paletopd 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-442.2432861328125,"y":6012.6201171875,"z":27.73100090026855},"model":-594854737,"lockpick":false,"groups":{"police":0},"state":1,"heading":45,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1383, 'paletopd 22', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-445.9457092285156,"y":6012.8798828125,"z":27.73100090026855},"model":-594854737,"lockpick":false,"groups":{"police":0},"state":1,"heading":135,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1384, 'paletopd 23', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-448.9159851074219,"y":6015.85107421875,"z":27.73100090026855},"model":-594854737,"lockpick":false,"groups":{"police":0},"state":1,"heading":135,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1385, 'paletopd 24', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-443.3901062011719,"y":6015.43603515625,"z":27.73100090026855},"model":-594854737,"lockpick":false,"groups":{"police":0},"state":1,"heading":135,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1386, 'paletopd 25', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-446.36041259765627,"y":6018.4072265625,"z":27.73100090026855},"model":-594854737,"lockpick":false,"groups":{"police":0},"state":1,"heading":135,"unlockSound":"metallic-creak","lockSound":"metal-locker"}'),
	(1387, 'paletopd 26', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-449.69140625,"y":6024.35498046875,"z":32.15740966796875},"model":-1156020871,"lockpick":false,"groups":{"police":0},"heading":135,"state":1}'),
	(1388, 'paletopd 27', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-453.58758544921877,"y":6028.26513671875,"z":30.35073089599609},"model":-470936668,"lockpick":false,"groups":{"police":0},"heading":45,"state":1}'),
	(1389, 'parkranger 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":387.7514953613281,"y":792.87109375,"z":187.84910583496095},"model":-117185009,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1390, 'parkranger 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":388.63128662109377,"y":799.6823120117188,"z":187.8262939453125},"model":-117185009,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1391, 'parkranger 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":383.40789794921877,"y":798.2910766601563,"z":187.61180114746095},"model":517369125,"lockpick":false,"groups":{"police":0},"heading":270,"state":1}'),
	(1392, 'parkranger 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":382.96160888671877,"y":796.8286743164063,"z":187.6116943359375},"model":517369125,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1393, 'parkranger 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":378.75830078125,"y":796.83642578125,"z":187.6123046875},"model":517369125,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1394, 'parkranger 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":380.2174072265625,"y":792.788330078125,"z":190.6414031982422},"model":-117185009,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1395, 'parkranger 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":384.3811950683594,"y":796.0927734375,"z":190.6396026611328},"model":1704212348,"lockpick":false,"groups":{"police":0},"heading":270,"state":1}'),
	(1396, 'pdm 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-55.95074081420898,"y":-1088.06494140625,"z":27.61301040649414},"model":1973010099,"lockpick":false,"groups":{"cardealer":0},"heading":250,"state":0}'),
	(1397, 'pdm 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-48.12820053100586,"y":-1103.5,"z":27.61301040649414},"model":1973010099,"lockpick":false,"groups":{"cardealer":0},"heading":340,"state":0}'),
	(1398, 'pdm 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-32.64266967773437,"y":-1108.5589599609376,"z":27.42458915710449},"model":2089009131,"lockpick":false,"groups":{"cardealer":0},"heading":250,"state":1}'),
	(1399, 'pdm 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-30.42845916748047,"y":-1102.469970703125,"z":27.42458915710449},"model":2089009131,"lockpick":false,"groups":{"cardealer":0},"heading":70,"state":1}'),
	(1400, 'pdm 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-27.62104988098144,"y":-1094.762939453125,"z":27.42458915710449},"model":2089009131,"lockpick":false,"groups":{"cardealer":0},"heading":250,"state":0}'),
	(1401, 'pdm 6', '{"auto":true,"maxDistance":2.0,"hideUi":false,"coords":{"x":-21.51158905029297,"y":-1089.3990478515626,"z":28.11344909667968},"model":1010499530,"lockpick":false,"groups":{"cardealer":0},"heading":160,"state":0}'),
	(1402, 'pearls 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1818.0260009765626,"y":-1193.6929931640626,"z":14.45958042144775},"model":-689707675,"lockpick":false,"groups":{"pearls":0},"heading":330,"state":1}'),
	(1403, 'pearls 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1816.0059814453126,"y":-1194.8590087890626,"z":14.45958042144775},"model":-1427501726,"lockpick":false,"groups":{"pearls":0},"heading":330,"state":1}'),
	(1404, 'pearls 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1825.3060302734376,"y":-1184.6490478515626,"z":14.45958042144775},"model":-689707675,"lockpick":false,"groups":{"pearls":0},"heading":330,"state":1}'),
	(1405, 'pearls 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1823.2860107421876,"y":-1185.81494140625,"z":14.45958042144775},"model":-1427501726,"lockpick":false,"groups":{"pearls":0},"heading":330,"state":1}'),
	(1406, 'pearls 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1834.7249755859376,"y":-1200.9639892578126,"z":14.45958042144775},"model":-1427501726,"lockpick":false,"groups":{"pearls":0},"heading":150,"state":1}'),
	(1407, 'pearls 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1832.7049560546876,"y":-1202.1300048828126,"z":14.45958042144775},"model":-689707675,"lockpick":false,"groups":{"pearls":0},"heading":150,"state":1}'),
	(1408, 'pearls 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1832.8590087890626,"y":-1182.35595703125,"z":14.45421028137207},"model":1792440391,"lockpick":false,"groups":{"pearls":0},"heading":240,"state":1}'),
	(1409, 'pearls 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1840.8990478515626,"y":-1196.282958984375,"z":14.45421028137207},"model":-1262354275,"lockpick":false,"groups":{"pearls":0},"heading":60,"state":1}'),
	(1410, 'pearls 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1845.698974609375,"y":-1191.344970703125,"z":14.45421028137207},"model":2009869895,"lockpick":false,"groups":{"pearls":0},"heading":330,"state":1}'),
	(1411, 'pearls 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1844.4949951171876,"y":-1185.31201171875,"z":14.45421028137207},"model":1045259123,"lockpick":false,"groups":{"pearls":0},"heading":330,"state":1}'),
	(1412, 'pearls 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1841.60205078125,"y":-1189.0419921875,"z":14.45421028137207},"model":2009869895,"lockpick":false,"groups":{"pearls":0},"heading":60,"state":1}'),
	(1413, 'pearls 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1847.237060546875,"y":-1190.0899658203126,"z":14.45909023284912},"model":-147325430,"lockpick":false,"groups":{"pearls":0},"heading":330,"state":1}'),
	(1414, 'pillbox 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":313.4800109863281,"y":-595.4583740234375,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":250,"state":0}'),
	(1415, 'pillbox 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":309.1337890625,"y":-597.7514038085938,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":160,"state":1}'),
	(1416, 'pillbox 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":307.1181945800781,"y":-569.5689697265625,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":340,"state":1}'),
	(1417, 'pillbox 4', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":313.2146911621094,"y":-571.7813720703125,"z":43.43392181396484},"doors":[{"model":-434783486,"coords":{"x":312.00518798828127,"y":-571.3411865234375,"z":43.43392181396484},"heading":340},{"model":-1700911976,"coords":{"x":314.4241943359375,"y":-572.2216186523438,"z":43.43392181396484},"heading":340}],"lockpick":false,"groups":{"ambulance":0},"state":1}'),
	(1418, 'pillbox 5', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":319.0520935058594,"y":-573.9061279296875,"z":43.43392181396484},"doors":[{"model":-434783486,"coords":{"x":317.84259033203127,"y":-573.4658203125,"z":43.43392181396484},"heading":340},{"model":-1700911976,"coords":{"x":320.2615966796875,"y":-574.3463745117188,"z":43.43392181396484},"heading":340}],"lockpick":false,"groups":{"ambulance":0},"state":1}'),
	(1419, 'pillbox 6', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":324.44708251953127,"y":-575.8696899414063,"z":43.43392181396484},"doors":[{"model":-434783486,"coords":{"x":323.23760986328127,"y":-575.4293823242188,"z":43.43392181396484},"heading":340},{"model":-1700911976,"coords":{"x":325.6565856933594,"y":-576.3099975585938,"z":43.43392181396484},"heading":340}],"lockpick":false,"groups":{"ambulance":0},"state":1}'),
	(1420, 'pillbox 7', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":317.27520751953127,"y":-578.7879638671875,"z":43.43392181396484},"doors":[{"model":-434783486,"coords":{"x":318.4845886230469,"y":-579.2282104492188,"z":43.43392181396484},"heading":160},{"model":-1700911976,"coords":{"x":316.0657958984375,"y":-578.3477783203125,"z":43.43392181396484},"heading":160}],"lockpick":false,"groups":{"ambulance":0},"state":1}'),
	(1421, 'pillbox 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":336.1628112792969,"y":-580.140380859375,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":340,"state":1}'),
	(1422, 'pillbox 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":340.78179931640627,"y":-581.8214111328125,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":340,"state":1}'),
	(1423, 'pillbox 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":346.77398681640627,"y":-584.0023803710938,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":340,"state":1}'),
	(1424, 'pillbox 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":336.86639404296877,"y":-592.5787963867188,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":340,"state":1}'),
	(1425, 'pillbox 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":357.4908142089844,"y":-579.610595703125,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":250,"state":1}'),
	(1426, 'pillbox 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":356.1252136230469,"y":-583.3624267578125,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":250,"state":1}'),
	(1427, 'pillbox 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":360.5033874511719,"y":-588.9995727539063,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":340,"state":1}'),
	(1428, 'pillbox 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":358.7265930175781,"y":-593.8814086914063,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":340,"state":1}'),
	(1429, 'pillbox 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":352.1995849609375,"y":-594.1478271484375,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":250,"state":1}'),
	(1430, 'pillbox 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":350.8340148925781,"y":-597.8997802734375,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":250,"state":1}'),
	(1431, 'pillbox 18', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":346.8854064941406,"y":-593.5999755859375,"z":43.43392181396484},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":70,"state":1}'),
	(1432, 'pillbox 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":348.5466003417969,"y":-585.1583862304688,"z":28.94709968566894},"model":854291622,"lockpick":false,"groups":{"ambulance":0},"heading":250,"state":1}'),
	(1433, 'pillbox 20', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":338.8865966796875,"y":-588.84375,"z":28.94709968566894},"doors":[{"model":-434783486,"coords":{"x":338.44659423828127,"y":-590.052978515625,"z":28.94709968566894},"heading":70},{"model":-1700911976,"coords":{"x":339.32659912109377,"y":-587.6345825195313,"z":28.94709968566894},"heading":70}],"lockpick":false,"groups":{"ambulance":0},"state":1}'),
	(1434, 'pillbox 21', '{"auto":true,"maxDistance":2.0,"hideUi":false,"coords":{"x":340.44830322265627,"y":-584.8294677734375,"z":27.79681968688965},"doors":[{"model":1674289593,"coords":{"x":340.7712097167969,"y":-583.9420166015625,"z":27.79681968688965},"heading":70},{"model":-1048421071,"coords":{"x":340.1253967285156,"y":-585.7169799804688,"z":27.79681968688965},"heading":70}],"lockpick":false,"groups":{"ambulance":0},"state":1}'),
	(1435, 'pillbox 22', '{"auto":true,"maxDistance":2.0,"hideUi":false,"coords":{"x":341.79730224609377,"y":-581.1220703125,"z":27.79681968688965},"doors":[{"model":1674289593,"coords":{"x":342.1202087402344,"y":-580.234619140625,"z":27.79681968688965},"heading":70},{"model":-1048421071,"coords":{"x":341.4743957519531,"y":-582.0095825195313,"z":27.79681968688965},"heading":70}],"lockpick":false,"groups":{"ambulance":0},"state":1}'),
	(1436, 'pillbox 23', '{"auto":6.0,"maxDistance":6.0,"hideUi":false,"coords":{"x":337.277587890625,"y":-564.4320068359375,"z":29.77529907226562},"model":-820650556,"lockpick":false,"groups":{"ambulance":0},"heading":160,"state":1}'),
	(1437, 'pillbox 24', '{"auto":6.0,"maxDistance":6.0,"hideUi":false,"coords":{"x":330.135009765625,"y":-561.8331909179688,"z":29.77529907226562},"model":-820650556,"lockpick":false,"groups":{"ambulance":0},"heading":160,"state":1}'),
	(1438, 'pillbox 25', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":319.8402099609375,"y":-560.460693359375,"z":28.94724082946777},"doors":[{"model":-1421582160,"coords":{"x":321.0148010253906,"y":-559.9127807617188,"z":28.94724082946777},"heading":25},{"model":1248599813,"coords":{"x":318.66558837890627,"y":-561.0086059570313,"z":28.94724082946777},"heading":205}],"lockpick":false,"groups":{"ambulance":0},"state":1}'),
	(1439, 'pinkcage 1', '{"items":[{"name":"pinkcage_room1","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":306.8489990234375,"y":-213.6743927001953,"z":54.37154006958008},"model":-1156992775,"lockpick":false,"state":1,"heading":69}'),
	(1440, 'pinkcage 2', '{"items":[{"name":"pinkcage_room2","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":310.6427917480469,"y":-203.79119873046876,"z":54.37157821655273},"model":-1156992775,"lockpick":false,"state":1,"heading":69}'),
	(1441, 'pinkcage 3', '{"items":[{"name":"pinkcage_room3","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":315.3926086425781,"y":-194.1746063232422,"z":54.37139892578125},"model":-1156992775,"lockpick":false,"state":1,"heading":339}'),
	(1442, 'pinkcage 4', '{"items":[{"name":"pinkcage_room4","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":343.6001892089844,"y":-209.21499633789063,"z":54.37163925170898},"model":-1156992775,"lockpick":false,"state":1,"heading":249}'),
	(1443, 'pinkcage 5', '{"items":[{"name":"pinkcage_room5","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":339.80621337890627,"y":-219.09779357910157,"z":54.3720817565918},"model":-1156992775,"lockpick":false,"state":1,"heading":249}'),
	(1444, 'pinkcage 6', '{"items":[{"name":"pinkcage_room6","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":347.3948059082031,"y":-199.33180236816407,"z":54.3720817565918},"model":-1156992775,"lockpick":false,"state":1,"heading":249}'),
	(1445, 'pinkcage 7', '{"items":[{"name":"pinkcage_room7","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":315.2510070800781,"y":-220.26719665527345,"z":58.1703987121582},"model":-1156992775,"lockpick":false,"state":1,"heading":159}'),
	(1446, 'pinkcage 8', '{"items":[{"name":"pinkcage_room8","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":306.8489990234375,"y":-213.6743927001953,"z":58.16915893554687},"model":-1156992775,"lockpick":false,"state":1,"heading":69}'),
	(1447, 'pinkcage 9', '{"items":[{"name":"pinkcage_room9","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":310.6431884765625,"y":-203.7904052734375,"z":58.16949844360351},"model":-1156992775,"lockpick":false,"state":1,"heading":69}'),
	(1448, 'pinkcage 10', '{"items":[{"name":"pinkcage_room10","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":315.3926086425781,"y":-194.1746063232422,"z":58.16973876953125},"model":-1156992775,"lockpick":false,"state":1,"heading":339}'),
	(1449, 'pinkcage 11', '{"items":[{"name":"pinkcage_room11","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":335.3399963378906,"y":-227.98179626464845,"z":58.16957855224609},"model":-1156992775,"lockpick":false,"state":1,"heading":159}'),
	(1450, 'pinkcage 12', '{"items":[{"name":"pinkcage_room12","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":339.80621337890627,"y":-219.09779357910157,"z":58.16852188110351},"model":-1156992775,"lockpick":false,"state":1,"heading":249}'),
	(1451, 'pinkcage 13', '{"items":[{"name":"pinkcage_room13","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":343.6001892089844,"y":-209.21499633789063,"z":58.16852188110351},"model":-1156992775,"lockpick":false,"state":1,"heading":249}'),
	(1452, 'pinkcage 14', '{"items":[{"name":"pinkcage_room14","remove":false}],"maxDistance":2.0,"hideUi":false,"coords":{"x":347.3948059082031,"y":-199.33180236816407,"z":58.16852188110351},"model":-1156992775,"lockpick":false,"state":1,"heading":249}'),
	(1453, 'pizzeria 1', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":794.251220703125,"y":-758.251708984375,"z":27.02701950073242},"doors":[{"model":-49173194,"coords":{"x":794.251220703125,"y":-759.4415283203125,"z":27.02701950073242},"heading":270},{"model":95403626,"coords":{"x":794.251220703125,"y":-757.0618286132813,"z":27.02701950073242},"heading":270}],"lockpick":false,"groups":{"unemployed":0},"state":1}'),
	(1454, 'pizzeria 2', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":804.4681396484375,"y":-747.92822265625,"z":27.02701950073242},"doors":[{"model":-49173194,"coords":{"x":803.2781982421875,"y":-747.92822265625,"z":27.02701950073242},"heading":180},{"model":95403626,"coords":{"x":805.6580200195313,"y":-747.92822265625,"z":27.02701950073242},"heading":180}],"lockpick":false,"groups":{"unemployed":0},"state":1}'),
	(1455, 'pizzeria 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":814.5675048828125,"y":-762.8239135742188,"z":27.04651069641113},"model":-420112688,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(1456, 'pizzeria 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":800.4030151367188,"y":-765.0847778320313,"z":26.93464088439941},"model":1984391163,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(1457, 'pizzeria 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":800.4144897460938,"y":-763.9932250976563,"z":26.93464088439941},"model":1984391163,"lockpick":false,"groups":{"unemployed":0},"heading":270,"state":1}'),
	(1458, 'pizzeria 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":810.4091796875,"y":-756.2733154296875,"z":26.93464088439941},"model":1984391163,"lockpick":false,"groups":{"unemployed":0},"heading":0,"state":1}'),
	(1459, 'pizzeria 7', '{"auto":true,"maxDistance":2.0,"hideUi":false,"coords":{"x":805.9268188476563,"y":-761.6630249023438,"z":26.04281044006347},"model":2136811971,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(1460, 'pizzeria 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":805.2612915039063,"y":-758.673828125,"z":25.79360961914062},"model":-357301147,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(1461, 'pizzeria 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":806.278076171875,"y":-765.8098754882813,"z":26.93464088439941},"model":1984391163,"lockpick":false,"groups":{"unemployed":0},"heading":180,"state":1}'),
	(1462, 'pizzeria 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":811.9174194335938,"y":-762.427978515625,"z":26.93464088439941},"model":1984391163,"lockpick":false,"groups":{"unemployed":0},"heading":90,"state":1}'),
	(1463, 'pizzeria 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":804.4857788085938,"y":-767.697509765625,"z":31.41847038269043},"model":1984391163,"lockpick":false,"groups":{"unemployed":0},"heading":270,"state":1}'),
	(1464, 'pizzeria 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":798.6846923828125,"y":-763.3289794921875,"z":31.41847038269043},"model":1984391163,"lockpick":false,"groups":{"unemployed":0},"heading":0,"state":1}'),
	(1465, 'pizzeria 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":797.4041748046875,"y":-758.2520751953125,"z":31.41847038269043},"model":1984391163,"lockpick":false,"groups":{"unemployed":0},"heading":180,"state":1}'),
	(1466, 'pizzeria 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":806.8858032226563,"y":-764.5673828125,"z":31.41847038269043},"model":1984391163,"lockpick":false,"groups":{"unemployed":0},"heading":270,"state":1}'),
	(1467, 'ponsonbys 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-157.1486053466797,"y":-306.4171142578125,"z":40.00812911987305},"model":-1922281023,"lockpick":false,"groups":{"ponsonbys":0},"heading":251,"state":1}'),
	(1468, 'ponsonbys 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-156.4593048095703,"y":-304.4153137207031,"z":40.00812911987305},"model":-1922281023,"lockpick":false,"groups":{"ponsonbys":0},"heading":71,"state":1}'),
	(1469, 'ponsonbys 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-716.6500244140625,"y":-155.41659545898438,"z":37.68999099731445},"model":-1922281023,"lockpick":false,"groups":{"ponsonbys":0},"heading":120,"state":1}'),
	(1470, 'ponsonbys 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-715.5913696289063,"y":-157.25010681152345,"z":37.68999099731445},"model":-1922281023,"lockpick":false,"groups":{"ponsonbys":0},"heading":300,"state":1}'),
	(1471, 'ponsonbys 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1454.77099609375,"y":-231.8157958984375,"z":50.07159042358398},"model":-1922281023,"lockpick":false,"groups":{"ponsonbys":0},"heading":48,"state":1}'),
	(1472, 'ponsonbys 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1456.18798828125,"y":-233.38900756835938,"z":50.07157897949219},"model":-1922281023,"lockpick":false,"groups":{"ponsonbys":0},"heading":228,"state":1}'),
	(1473, 'prison 1', '{"auto":true,"maxDistance":12,"hideUi":false,"coords":{"x":1844.9000244140626,"y":2604.800048828125,"z":44.59999847412109},"model":741314661,"lockpick":true,"groups":{"police":0},"state":1}'),
	(1474, 'prison 2', '{"auto":true,"maxDistance":12,"hideUi":false,"coords":{"x":1818.5,"y":2604.800048828125,"z":44.59999847412109},"model":741314661,"lockpick":true,"groups":{"police":0},"state":1}'),
	(1475, 'prison 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1845.3360595703126,"y":2585.347900390625,"z":46.08549880981445},"model":1373390714,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1476, 'prison 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1844.404052734375,"y":2576.9970703125,"z":46.03559875488281},"model":2024969025,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1477, 'prison 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1837.634033203125,"y":2576.991943359375,"z":46.03860092163086},"model":2024969025,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1478, 'prison 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1838.0899658203126,"y":2572.297119140625,"z":46.15969085693359},"model":-2051651622,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1479, 'prison 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1835.5279541015626,"y":2587.43994140625,"z":46.0371208190918},"model":-684929024,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1480, 'prison 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1837.741943359375,"y":2592.162109375,"z":46.03956985473633},"model":-684929024,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1481, 'prison 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1831.3399658203126,"y":2594.991943359375,"z":46.03791046142578},"model":-684929024,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1482, 'prison 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1838.616943359375,"y":2593.705078125,"z":46.03636169433594},"model":-684929024,"lockpick":false,"groups":{"police":0},"heading":270,"state":1}'),
	(1483, 'prison 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1827.98095703125,"y":2592.156982421875,"z":46.03718185424805},"model":-684929024,"lockpick":false,"groups":{"police":0},"heading":180,"state":1}'),
	(1484, 'prison 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1835.9019775390626,"y":2584.903076171875,"z":45.01689910888672},"model":673826957,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1485, 'prison 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1819.072998046875,"y":2594.873046875,"z":46.08694839477539},"model":1373390714,"lockpick":false,"groups":{"police":0},"heading":270,"state":1}'),
	(1486, 'prison 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1754.7960205078126,"y":2501.568115234375,"z":45.80966186523437},"model":1373390714,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1487, 'prison 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1758.6519775390626,"y":2492.658935546875,"z":45.8898811340332},"model":241550507,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1488, 'prison 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1768.5479736328126,"y":2498.410888671875,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1489, 'prison 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1765.4010009765626,"y":2496.593994140625,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1490, 'prison 18', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1762.2550048828126,"y":2494.778076171875,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1491, 'prison 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1755.9630126953126,"y":2491.14599609375,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1492, 'prison 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1752.8170166015626,"y":2489.330078125,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1493, 'prison 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1749.6710205078126,"y":2487.513916015625,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1494, 'prison 22', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1768.5469970703126,"y":2498.412109375,"z":49.84590911865234},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1495, 'prison 23', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1765.4010009765626,"y":2496.594970703125,"z":49.84590911865234},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1496, 'prison 24', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1762.2550048828126,"y":2494.779052734375,"z":49.84590911865234},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1497, 'prison 25', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1759.1090087890626,"y":2492.962890625,"z":49.84590911865234},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1498, 'prison 26', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1755.9630126953126,"y":2491.14599609375,"z":49.84590911865234},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1499, 'prison 27', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1752.8170166015626,"y":2489.3291015625,"z":49.84590911865234},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1500, 'prison 28', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1749.6710205078126,"y":2487.512939453125,"z":49.84590911865234},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1501, 'prison 29', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1758.0780029296876,"y":2475.39306640625,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1502, 'prison 30', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1761.2249755859376,"y":2477.2099609375,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1503, 'prison 31', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1764.3690185546876,"y":2479.02587890625,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1504, 'prison 32', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1767.5150146484376,"y":2480.843017578125,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1505, 'prison 33', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1770.6610107421876,"y":2482.658935546875,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1506, 'prison 34', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1773.8070068359376,"y":2484.47607421875,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1507, 'prison 35', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1776.9520263671876,"y":2486.2919921875,"z":45.8898811340332},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1508, 'prison 36', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1758.0780029296876,"y":2475.39111328125,"z":49.84635925292969},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1509, 'prison 37', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1761.2249755859376,"y":2477.208984375,"z":49.84635925292969},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1510, 'prison 38', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1764.3690185546876,"y":2479.02490234375,"z":49.84635925292969},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1511, 'prison 39', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1767.5150146484376,"y":2480.843017578125,"z":49.84635925292969},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1512, 'prison 40', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1770.6600341796876,"y":2482.658935546875,"z":49.84635925292969},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1513, 'prison 41', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1773.8070068359376,"y":2484.47705078125,"z":49.84635925292969},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1514, 'prison 42', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1776.9510498046876,"y":2486.29296875,"z":49.84635925292969},"model":913760512,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1515, 'prison 43', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1751.14697265625,"y":2481.177978515625,"z":45.8898811340332},"model":241550507,"lockpick":false,"groups":{"police":0},"heading":300,"state":1}'),
	(1516, 'prison 44', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1752.281005859375,"y":2479.248046875,"z":45.8898811340332},"model":241550507,"lockpick":false,"groups":{"police":0},"heading":120,"state":1}'),
	(1517, 'prison 45', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1772.93896484375,"y":2495.31298828125,"z":49.84006118774414},"model":241550507,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1518, 'prison 46', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1775.4139404296876,"y":2491.02490234375,"z":49.84006118774414},"model":241550507,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1519, 'prison 47', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1765.1180419921876,"y":2566.52392578125,"z":45.80284881591797},"model":1373390714,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1520, 'prison 48', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1772.81298828125,"y":2570.2958984375,"z":45.74467086791992},"model":2074175368,"lockpick":false,"groups":{"police":0},"heading":0,"state":1}'),
	(1521, 'prison 49', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":1765.175048828125,"y":2574.697998046875,"z":45.75300979614258},"doors":[{"model":-1624297821,"coords":{"x":1766.324951171875,"y":2574.697998046875,"z":45.75300979614258},"heading":0},{"model":-1624297821,"coords":{"x":1764.0250244140626,"y":2574.697998046875,"z":45.75300979614258},"heading":180}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1522, 'prison 50', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1767.322998046875,"y":2580.83203125,"z":45.74782943725586},"model":-1392981450,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1523, 'prison 51', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":1767.321044921875,"y":2583.45751953125,"z":45.75344848632812},"doors":[{"model":-1624297821,"coords":{"x":1767.321044921875,"y":2582.30810546875,"z":45.75344848632812},"heading":270},{"model":-1624297821,"coords":{"x":1767.321044921875,"y":2584.60693359375,"z":45.75344848632812},"heading":90}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1524, 'prison 52', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":1765.175537109375,"y":2589.56396484375,"z":45.75308990478515},"doors":[{"model":-1624297821,"coords":{"x":1766.324951171875,"y":2589.56396484375,"z":45.75308990478515},"heading":0},{"model":-1624297821,"coords":{"x":1764.0260009765626,"y":2589.56396484375,"z":45.75308990478515},"heading":180}],"lockpick":false,"groups":{"police":0},"state":1}'),
	(1525, 'prison 53', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1776.1949462890626,"y":2552.56298828125,"z":45.74740982055664},"model":1373390714,"lockpick":false,"groups":{"police":0},"heading":270,"state":1}'),
	(1526, 'prison 54', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1791.594970703125,"y":2551.4619140625,"z":45.75320053100586},"model":1373390714,"lockpick":false,"groups":{"police":0},"heading":90,"state":1}'),
	(1527, 'records 1', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-826.4025268554688,"y":-699.8389892578125,"z":28.49082946777343},"doors":[{"model":2001816392,"coords":{"x":-826.4025268554688,"y":-700.9301147460938,"z":28.49082946777343},"heading":270},{"model":2001816392,"coords":{"x":-826.4025268554688,"y":-698.747802734375,"z":28.49082946777343},"heading":90}],"lockpick":false,"groups":{"records":0},"state":1}'),
	(1528, 'records 2', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-826.4025268554688,"y":-696.9046020507813,"z":28.49082946777343},"doors":[{"model":2001816392,"coords":{"x":-826.4025268554688,"y":-697.994384765625,"z":28.49082946777343},"heading":270},{"model":2001816392,"coords":{"x":-826.4025268554688,"y":-695.8148193359375,"z":28.49082946777343},"heading":90}],"lockpick":false,"groups":{"records":0},"state":1}'),
	(1529, 'records 3', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-821.3134765625,"y":-703.1262817382813,"z":28.20560073852539},"doors":[{"model":75593271,"coords":{"x":-822.3142700195313,"y":-703.1262817382813,"z":28.20560073852539},"heading":0},{"model":1403720845,"coords":{"x":-820.3126220703125,"y":-703.1262817382813,"z":28.20560073852539},"heading":0}],"lockpick":false,"groups":{"records":0},"state":1}'),
	(1530, 'records 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-816.6038208007813,"y":-702.3438110351563,"z":28.20560073852539},"model":693644064,"lockpick":false,"groups":{"records":0},"heading":90,"state":1}'),
	(1531, 'records 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-816.6038208007813,"y":-694.3997802734375,"z":28.20560073852539},"model":693644064,"lockpick":false,"groups":{"records":0},"heading":270,"state":1}'),
	(1532, 'records 6', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-821.3134765625,"y":-715.6939697265625,"z":28.20560073852539},"doors":[{"model":75593271,"coords":{"x":-822.3142700195313,"y":-715.6939697265625,"z":28.20560073852539},"heading":0},{"model":1403720845,"coords":{"x":-820.3126220703125,"y":-715.6939697265625,"z":28.20560073852539},"heading":0}],"lockpick":false,"groups":{"records":0},"state":1}'),
	(1533, 'records 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-819.4990844726563,"y":-719.3162841796875,"z":28.20560073852539},"model":693644064,"lockpick":false,"groups":{"records":0},"heading":90,"state":1}'),
	(1534, 'records 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-819.4990844726563,"y":-728.5466918945313,"z":28.20560073852539},"model":693644064,"lockpick":false,"groups":{"records":0},"heading":90,"state":1}'),
	(1535, 'records 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-819.4990844726563,"y":-711.9124145507813,"z":28.20560073852539},"model":693644064,"lockpick":false,"groups":{"records":0},"heading":270,"state":1}'),
	(1536, 'records 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-819.4990844726563,"y":-711.9124145507813,"z":32.48664855957031},"model":693644064,"lockpick":false,"groups":{"records":0},"heading":270,"state":1}'),
	(1537, 'records 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-822.0344848632813,"y":-703.1276245117188,"z":32.48664855957031},"model":693644064,"lockpick":false,"groups":{"records":0},"heading":0,"state":1}'),
	(1538, 'records 12', '{"maxDistance":2.5,"hideUi":false,"coords":{"x":-823.14501953125,"y":-709.446533203125,"z":32.48659896850586},"doors":[{"model":1403720845,"coords":{"x":-823.14501953125,"y":-708.4456787109375,"z":32.48659896850586},"heading":90},{"model":75593271,"coords":{"x":-823.14501953125,"y":-710.4473266601563,"z":32.48659896850586},"heading":90}],"lockpick":false,"groups":{"records":0},"state":1}'),
	(1539, 'records 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-822.0344848632813,"y":-715.6934204101563,"z":32.48664855957031},"model":693644064,"lockpick":false,"groups":{"records":0},"heading":0,"state":1}'),
	(1540, 'records 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-818.7371215820313,"y":-724.0592041015625,"z":32.52227020263672},"model":390840000,"lockpick":false,"groups":{"records":0},"heading":90,"state":1}'),
	(1541, 'records 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-819.4990844726563,"y":-711.9124145507813,"z":23.92465019226074},"model":693644064,"lockpick":false,"groups":{"records":0},"heading":270,"state":1}'),
	(1542, 'records 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-823.1431274414063,"y":-711.9124145507813,"z":23.92465019226074},"model":-2023754432,"lockpick":false,"groups":{"records":0},"heading":270,"state":1}'),
	(1543, 'records 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-820.6585083007813,"y":-715.6948852539063,"z":23.93993949890136},"model":-2023754432,"lockpick":false,"groups":{"records":0},"heading":180,"state":1}'),
	(1544, 'records 18', '{"auto":6.0,"maxDistance":6.0,"hideUi":false,"coords":{"x":-816.2235717773438,"y":-740.1627197265625,"z":24.16523933410644},"model":-700626879,"lockpick":false,"groups":{"records":0},"heading":0,"state":1}'),
	(1545, 'records 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-819.0726928710938,"y":-721.4121704101563,"z":23.93993949890136},"model":-2023754432,"lockpick":false,"groups":{"records":0},"heading":90,"state":1}'),
	(1546, 'sandypd 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1835.126953125,"y":3673.41796875,"z":34.33900833129883},"model":-1501157055,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1547, 'sandypd 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1837.3780517578126,"y":3674.718017578125,"z":34.33900833129883},"model":-1501157055,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1548, 'sandypd 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1838.0059814453126,"y":3677.10400390625,"z":34.28223037719726},"model":1364638935,"lockpick":false,"groups":{"police":0},"heading":120,"state":1}'),
	(1549, 'sandypd 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1836.488037109375,"y":3681.427001953125,"z":34.28223037719726},"model":1364638935,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1550, 'sandypd 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1838.9649658203126,"y":3682.85693359375,"z":34.28223037719726},"model":-1264811159,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1551, 'sandypd 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1829.85302734375,"y":3673.7890625,"z":34.28223037719726},"model":-1264811159,"lockpick":false,"groups":{"police":0},"heading":300,"state":1}'),
	(1552, 'sandypd 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1830.6500244140626,"y":3676.56201171875,"z":34.28223037719726},"model":-1264811159,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1553, 'sandypd 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1827.072021484375,"y":3674.49609375,"z":34.28223037719726},"model":-1264811159,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1554, 'sandypd 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1829.384033203125,"y":3680.26708984375,"z":34.28223037719726},"model":-1264811159,"lockpick":false,"groups":{"police":0},"heading":120,"state":1}'),
	(1555, 'sandypd 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1812.3070068359376,"y":3672.72412109375,"z":34.28223037719726},"model":1364638935,"lockpick":false,"groups":{"police":0},"heading":300,"state":1}'),
	(1556, 'sandypd 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1814.1949462890626,"y":3669.452880859375,"z":34.28223037719726},"model":-1264811159,"lockpick":false,"groups":{"police":0},"heading":300,"state":1}'),
	(1557, 'sandypd 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1818.3170166015626,"y":3669.278076171875,"z":34.28223037719726},"model":1364638935,"lockpick":false,"groups":{"police":0},"heading":210,"state":1}'),
	(1558, 'sandypd 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1813.551025390625,"y":3675.054931640625,"z":34.39609146118164},"model":2010487154,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1559, 'sandypd 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1810.1309814453126,"y":3676.464111328125,"z":34.39609146118164},"model":2010487154,"lockpick":false,"groups":{"police":0},"heading":120,"state":1}'),
	(1560, 'sandypd 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1808.6290283203126,"y":3679.06494140625,"z":34.39609146118164},"model":2010487154,"lockpick":false,"groups":{"police":0},"heading":120,"state":1}'),
	(1561, 'sandypd 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1807.1309814453126,"y":3681.659912109375,"z":34.39609146118164},"model":2010487154,"lockpick":false,"groups":{"police":0},"heading":120,"state":1}'),
	(1562, 'sandypd 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1828.5269775390626,"y":3680.22900390625,"z":38.95244979858398},"model":-1264811159,"lockpick":false,"groups":{"police":0},"heading":300,"state":1}'),
	(1563, 'sandypd 18', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1831.22998046875,"y":3675.427978515625,"z":38.95244979858398},"model":-1626613696,"lockpick":false,"groups":{"police":0},"heading":120,"state":1}'),
	(1564, 'sandypd 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1828.428955078125,"y":3673.81201171875,"z":38.95244979858398},"model":-1626613696,"lockpick":false,"groups":{"police":0},"heading":120,"state":1}'),
	(1565, 'sandypd 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1823.863037109375,"y":3681.116943359375,"z":34.33900833129883},"model":-1501157055,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1566, 'sandypd 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1862.001953125,"y":3687.52197265625,"z":33.01514053344726},"model":1286535678,"lockpick":false,"groups":{"police":0},"heading":30,"state":1}'),
	(1567, 'studio 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":472.9541015625,"y":-103.77749633789063,"z":63.30768966674805},"model":-350302570,"lockpick":false,"groups":{"studio":0},"heading":160,"state":1}'),
	(1568, 'studio 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":475.156005859375,"y":-104.5779037475586,"z":63.30768966674805},"model":-104698915,"lockpick":false,"groups":{"studio":0},"heading":340,"state":1}'),
	(1569, 'studio 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":485.5347900390625,"y":-96.3494873046875,"z":63.31010055541992},"model":490866369,"lockpick":false,"groups":{"studio":0},"heading":340,"state":1}'),
	(1570, 'studio 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":487.789794921875,"y":-97.1702880859375,"z":63.31010055541992},"model":1364395251,"lockpick":false,"groups":{"studio":0},"heading":340,"state":1}'),
	(1571, 'suburban 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":127.83499908447266,"y":-211.77789306640626,"z":55.22748184204101},"model":1780022985,"lockpick":false,"groups":{"suburban":0},"heading":160,"state":1}'),
	(1572, 'suburban 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":617.2520751953125,"y":2750.971923828125,"z":42.75804138183594},"model":1780022985,"lockpick":false,"groups":{"suburban":0},"heading":4,"state":1}'),
	(1573, 'suburban 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1201.4749755859376,"y":-776.8890991210938,"z":17.99210929870605},"model":1780022985,"lockpick":false,"groups":{"suburban":0},"heading":307,"state":1}'),
	(1574, 'suburban 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-3167.73193359375,"y":1055.5830078125,"z":21.53314018249511},"model":1780022985,"lockpick":false,"groups":{"suburban":0},"heading":156,"state":1}'),
	(1575, 'tattoo 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":321.8063049316406,"y":178.35440063476563,"z":103.69879913330078},"model":543652229,"lockpick":false,"groups":{"tattoo":0},"heading":340,"state":0}'),
	(1576, 'tattoo 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":323.3778991699219,"y":183.9528045654297,"z":103.75689697265625},"model":1243635233,"lockpick":false,"groups":{"tattoo":0},"heading":250,"state":0}'),
	(1577, 'tattoo 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1321.281982421875,"y":-1650.592041015625,"z":52.38685989379883},"model":543652229,"lockpick":false,"groups":{"tattoo":0},"heading":219,"state":0}'),
	(1578, 'tattoo 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1325.279052734375,"y":-1654.81494140625,"z":52.44652938842773},"model":1243635233,"lockpick":false,"groups":{"tattoo":0},"heading":129,"state":0}'),
	(1579, 'tattoo 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1155.45703125,"y":-1424.0030517578126,"z":5.06672286987304},"model":543652229,"lockpick":false,"groups":{"tattoo":0},"heading":215,"state":0}'),
	(1580, 'tattoo 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-1151.77294921875,"y":-1428.5009765625,"z":5.1248288154602},"model":1243635233,"lockpick":false,"groups":{"tattoo":0},"heading":125,"state":0}'),
	(1581, 'tattoo 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-3167.782958984375,"y":1074.864013671875,"z":20.94142913818359},"model":543652229,"lockpick":false,"groups":{"tattoo":0},"heading":66,"state":0}'),
	(1582, 'tattoo 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-3173.27490234375,"y":1076.7769775390626,"z":20.99954032897949},"model":1243635233,"lockpick":false,"groups":{"tattoo":0},"heading":336,"state":0}'),
	(1583, 'tattoo 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1859.9439697265626,"y":3749.81103515625,"z":33.14017868041992},"model":1212467128,"lockpick":false,"groups":{"tattoo":0},"heading":120,"state":0}'),
	(1584, 'tattoo 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":1866.4439697265626,"y":3750.033935546875,"z":33.19829177856445},"model":1243635233,"lockpick":false,"groups":{"tattoo":0},"heading":210,"state":0}'),
	(1585, 'tattoo 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-289.21710205078127,"y":6199.076171875,"z":31.59542083740234},"model":1212467128,"lockpick":false,"groups":{"tattoo":0},"heading":315,"state":0}'),
	(1586, 'tattoo 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-295.4471130371094,"y":6197.2080078125,"z":31.65353012084961},"model":1243635233,"lockpick":false,"groups":{"tattoo":0},"heading":45,"state":0}'),
	(1587, 'townhall 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-544.5582885742188,"y":-202.77980041503907,"z":38.42063903808594},"model":660342567,"lockpick":false,"groups":{"townhall":0},"heading":30,"state":0}'),
	(1588, 'townhall 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-546.5197143554688,"y":-203.91189575195313,"z":38.42063903808594},"model":-1094765077,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1589, 'townhall 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-544.13818359375,"y":-190.68179321289063,"z":38.43664169311523},"model":-1940023190,"lockpick":false,"groups":{"townhall":0},"heading":120,"state":0}'),
	(1590, 'townhall 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-543.488525390625,"y":-191.80740356445313,"z":38.43664169311523},"model":-1940023190,"lockpick":false,"groups":{"townhall":0},"heading":300,"state":0}'),
	(1591, 'townhall 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-541.0228881835938,"y":-192.202392578125,"z":38.33399963378906},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1592, 'townhall 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-536.2000122070313,"y":-189.418701171875,"z":38.33399963378906},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1593, 'townhall 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-531.3375854492188,"y":-186.61219787597657,"z":38.33399963378906},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1594, 'townhall 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-538.4105224609375,"y":-185.58889770507813,"z":38.33399963378906},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1595, 'townhall 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-532.4227294921875,"y":-182.13290405273438,"z":38.33399963378906},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":30,"state":0}'),
	(1596, 'townhall 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-541.0100708007813,"y":-192.197998046875,"z":43.46984100341797},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1597, 'townhall 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-536.1873168945313,"y":-189.41419982910157,"z":43.46984100341797},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1598, 'townhall 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-538.3983764648438,"y":-185.58340454101563,"z":43.46984100341797},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1599, 'townhall 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-556.5889282226563,"y":-199.36880493164063,"z":38.43664169311523},"model":-1940023190,"lockpick":false,"groups":{"townhall":0},"heading":300,"state":0}'),
	(1600, 'townhall 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-557.2385864257813,"y":-198.24319458007813,"z":38.43664169311523},"model":-1940023190,"lockpick":false,"groups":{"townhall":0},"heading":120,"state":0}'),
	(1601, 'townhall 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-562.1282958984375,"y":-202.56610107421876,"z":38.43664169311523},"model":-1940023190,"lockpick":false,"groups":{"townhall":0},"heading":300,"state":0}'),
	(1602, 'townhall 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-562.7780151367188,"y":-201.4405059814453,"z":38.43664169311523},"model":-1940023190,"lockpick":false,"groups":{"townhall":0},"heading":120,"state":0}'),
	(1603, 'townhall 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-562.1256103515625,"y":-202.5644989013672,"z":43.57550048828125},"model":-1940023190,"lockpick":false,"groups":{"townhall":0},"heading":300,"state":0}'),
	(1604, 'townhall 18', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-562.7753295898438,"y":-201.43890380859376,"z":43.57550048828125},"model":-1940023190,"lockpick":false,"groups":{"townhall":0},"heading":120,"state":0}'),
	(1605, 'townhall 19', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-582.5042114257813,"y":-207.49830627441407,"z":38.32498931884765},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":120,"state":0}'),
	(1606, 'townhall 20', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-577.2459106445313,"y":-216.6083984375,"z":38.32498931884765},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":300,"state":0}'),
	(1607, 'townhall 21', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-574.5858154296875,"y":-216.9340057373047,"z":38.32498931884765},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1608, 'townhall 22', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-562.6887817382813,"y":-231.6887969970703,"z":34.37223815917969},"model":1762042010,"lockpick":false,"groups":{"townhall":0},"heading":120,"state":0}'),
	(1609, 'townhall 23', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-557.944091796875,"y":-233.11070251464845,"z":34.47710037231445},"model":918828907,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1610, 'townhall 24', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-560.5424194335938,"y":-234.6103057861328,"z":34.47710037231445},"model":918828907,"lockpick":false,"groups":{"townhall":0},"heading":210,"state":0}'),
	(1611, 'townhall 25', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-568.5510864257813,"y":-234.4239044189453,"z":34.35749816894531},"model":830788581,"lockpick":false,"groups":{"townhall":0},"heading":120,"state":0}'),
	(1612, 'townhall 26', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-567.4882202148438,"y":-236.2653045654297,"z":34.35749816894531},"model":297112647,"lockpick":false,"groups":{"townhall":0},"heading":300,"state":0}'),
	(1613, 'triads 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-637.3624267578125,"y":-1249.2330322265626,"z":11.94554996490478},"model":-636132164,"lockpick":false,"groups":{"triads":0},"heading":352,"state":1}'),
	(1614, 'triads 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-639.8225708007813,"y":-1248.9010009765626,"z":11.94554996490478},"model":1215119726,"lockpick":false,"groups":{"triads":0},"heading":172,"state":1}'),
	(1615, 'triads 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-643.1491088867188,"y":-1229.2640380859376,"z":11.68206977844238},"model":1215119726,"lockpick":false,"groups":{"triads":0},"heading":302,"state":1}'),
	(1616, 'triads 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-644.4763793945313,"y":-1227.166015625,"z":11.68206977844238},"model":-636132164,"lockpick":false,"groups":{"triads":0},"heading":122,"state":1}'),
	(1617, 'triads 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-643.3831176757813,"y":-1235.907958984375,"z":10.57057952880859},"model":-932312205,"lockpick":false,"groups":{"triads":0},"heading":302,"state":1}'),
	(1618, 'triads 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-644.3745727539063,"y":-1234.3409423828126,"z":10.57057952880859},"model":-932312205,"lockpick":false,"groups":{"triads":0},"heading":122,"state":1}'),
	(1619, 'triads 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-642.635498046875,"y":-1238.3990478515626,"z":11.74859046936035},"model":-1592535808,"lockpick":false,"groups":{"triads":0},"heading":32,"state":1}'),
	(1620, 'triads 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-650.94873046875,"y":-1233.1700439453126,"z":11.74859046936035},"model":-1592535808,"lockpick":false,"groups":{"triads":0},"heading":212,"state":1}'),
	(1621, 'triads 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":-649.8441162109375,"y":-1242.958984375,"z":11.74859046936035},"model":-1592535808,"lockpick":false,"groups":{"triads":0},"heading":212,"state":1}'),
	(1622, 'tunershop 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":154.9344940185547,"y":-3017.322998046875,"z":7.19067907333374},"model":-2023754432,"lockpick":false,"groups":{"mechanic":0},"heading":270,"state":1}'),
	(1623, 'tunershop 2', '{"auto":6.0,"maxDistance":10.0,"hideUi":false,"coords":{"x":154.8094940185547,"y":-3023.888916015625,"z":8.50333595275878},"model":-456733639,"lockpick":false,"groups":{"mechanic":0},"heading":90,"state":1}'),
	(1624, 'tunershop 3', '{"auto":6.0,"maxDistance":10.0,"hideUi":false,"coords":{"x":154.8094940185547,"y":-3034.051025390625,"z":8.50333595275878},"model":-456733639,"lockpick":false,"groups":{"mechanic":0},"heading":90,"state":1}'),
	(1625, 'tunershop 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":151.466796875,"y":-3011.705078125,"z":7.25836706161499},"model":-1229046235,"lockpick":false,"groups":{"mechanic":0},"heading":90,"state":1}'),
	(1626, 'upnatom 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":82.76136016845703,"y":274.9877014160156,"z":110.56690216064453},"model":-862896030,"lockpick":false,"groups":{"upnatom":0},"heading":340,"state":1}'),
	(1627, 'upnatom 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":80.4225082397461,"y":275.8388977050781,"z":110.56690216064453},"model":2050300835,"lockpick":false,"groups":{"upnatom":0},"heading":160,"state":1}'),
	(1628, 'upnatom 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":80.02654266357422,"y":290.1178894042969,"z":110.56690216064453},"model":2050300835,"lockpick":false,"groups":{"upnatom":0},"heading":70,"state":1}'),
	(1629, 'upnatom 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":79.17524719238281,"y":287.77911376953127,"z":110.56690216064453},"model":-862896030,"lockpick":false,"groups":{"upnatom":0},"heading":250,"state":1}'),
	(1630, 'upnatom 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":79.40216064453125,"y":282.0285949707031,"z":110.39440155029297},"model":1076268192,"lockpick":false,"groups":{"upnatom":0},"heading":115,"state":1}'),
	(1631, 'upnatom 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":89.02409362792969,"y":290.0517883300781,"z":109.71540069580078},"model":-93286271,"lockpick":false,"groups":{"upnatom":0},"heading":250,"state":1}'),
	(1632, 'upnatom 7', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":89.3266830444336,"y":290.8830871582031,"z":109.71540069580078},"model":-93286271,"lockpick":false,"groups":{"upnatom":0},"heading":70,"state":1}'),
	(1633, 'upnatom 8', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":95.23090362548828,"y":285.6846923828125,"z":110.8042984008789},"model":-290010556,"lockpick":false,"groups":{"upnatom":0},"heading":70,"state":1}'),
	(1634, 'upnatom 9', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":94.89002227783203,"y":284.7481994628906,"z":110.8042984008789},"model":-1521961119,"lockpick":false,"groups":{"upnatom":0},"heading":250,"state":1}'),
	(1635, 'upnatom 10', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":90.4150390625,"y":286.5531921386719,"z":110.18340301513672},"model":1172949613,"lockpick":false,"groups":{"upnatom":0},"heading":25,"state":1}'),
	(1636, 'upnatom 11', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":89.86062622070313,"y":287.7420959472656,"z":110.18340301513672},"model":1172949613,"lockpick":false,"groups":{"upnatom":0},"heading":25,"state":1}'),
	(1637, 'upnatom 12', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":89.31902313232422,"y":288.9035949707031,"z":110.18340301513672},"model":1172949613,"lockpick":false,"groups":{"upnatom":0},"heading":25,"state":1}'),
	(1638, 'upnatom 13', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":90.6850814819336,"y":293.25189208984377,"z":110.44290161132813},"model":-1158830573,"lockpick":false,"groups":{"upnatom":0},"heading":70,"state":1}'),
	(1639, 'upnatom 14', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":91.53746795654297,"y":296.16778564453127,"z":110.39440155029297},"model":1801511700,"lockpick":false,"groups":{"upnatom":0},"heading":70,"state":1}'),
	(1640, 'upnatom 15', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":87.54962921142578,"y":295.3215026855469,"z":110.39440155029297},"model":1801511700,"lockpick":false,"groups":{"upnatom":0},"heading":340,"state":1}'),
	(1641, 'upnatom 16', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":86.11734771728516,"y":298.1405944824219,"z":110.39440155029297},"model":1801511700,"lockpick":false,"groups":{"upnatom":0},"heading":70,"state":1}'),
	(1642, 'upnatom 17', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":91.0251235961914,"y":297.3128967285156,"z":110.34549713134766},"model":717680614,"lockpick":false,"groups":{"upnatom":0},"heading":340,"state":1}'),
	(1643, 'vagos 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":324.7153015136719,"y":-1991.0860595703126,"z":24.3629093170166},"model":2118614536,"lockpick":false,"groups":{"vagos":0},"heading":230,"state":1}'),
	(1644, 'vagos 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":336.74481201171877,"y":-1991.843994140625,"z":24.3629093170166},"model":2118614536,"lockpick":false,"groups":{"vagos":0},"heading":50,"state":1}'),
	(1645, 'vagos 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":334.6651916503906,"y":-1990.0810546875,"z":24.3571491241455},"model":1763005348,"lockpick":false,"groups":{"vagos":0},"heading":50,"state":1}'),
	(1646, 'vagos 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":336.78009033203127,"y":-1985.2740478515626,"z":24.3571491241455},"model":1763005348,"lockpick":false,"groups":{"vagos":0},"heading":140,"state":1}'),
	(1647, 'vagos 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":335.9012145996094,"y":-1984.5369873046876,"z":24.3571491241455},"model":1763005348,"lockpick":false,"groups":{"vagos":0},"heading":320,"state":1}'),
	(1648, 'vagos 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":325.7207946777344,"y":-1992.8179931640626,"z":24.3571491241455},"model":1763005348,"lockpick":false,"groups":{"vagos":0},"heading":140,"state":1}'),
	(1649, 'vu 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":127.94999694824219,"y":-1298.5059814453126,"z":29.41962051391601},"model":-1116041313,"lockpick":false,"groups":{"unicorn":0},"heading":30,"state":1}'),
	(1650, 'vu 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":128.07080078125,"y":-1279.345947265625,"z":29.43696022033691},"model":1695461688,"lockpick":false,"groups":{"unicorn":0},"heading":210,"state":1}'),
	(1651, 'vu 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":116.22779846191406,"y":-1294.592041015625,"z":29.43597984313965},"model":390840000,"lockpick":false,"groups":{"unicorn":0},"heading":300,"state":1}'),
	(1652, 'vu 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":113.41000366210938,"y":-1296.260009765625,"z":29.43597984313965},"model":390840000,"lockpick":false,"groups":{"unicorn":0},"heading":300,"state":1}'),
	(1653, 'vu 5', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":99.08306121826172,"y":-1293.68994140625,"z":29.44039916992187},"model":390840000,"lockpick":false,"groups":{"unicorn":0},"heading":30,"state":1}'),
	(1654, 'vu 6', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":96.09197998046875,"y":-1284.85400390625,"z":29.43877983093261},"model":1695461688,"lockpick":false,"groups":{"unicorn":0},"heading":210,"state":1}'),
	(1655, 'weedcamp 1', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":2196.781005859375,"y":5570.0830078125,"z":54.05622100830078},"model":819505495,"lockpick":false,"groups":{"weed":0},"heading":270,"state":1}'),
	(1656, 'weedcamp 2', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":2189.864990234375,"y":5578.076171875,"z":54.02807998657226},"model":363295477,"lockpick":false,"groups":{"weed":0},"heading":180,"state":1}'),
	(1657, 'weedcamp 3', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":2186.55810546875,"y":5578.076171875,"z":54.02807998657226},"model":363295477,"lockpick":false,"groups":{"weed":0},"heading":180,"state":1}'),
	(1658, 'weedcamp 4', '{"maxDistance":2.0,"hideUi":false,"coords":{"x":2187.75390625,"y":5573.4169921875,"z":54.02807998657226},"model":363295477,"lockpick":false,"groups":{"weed":0},"heading":360,"state":1}'),
	(1659, 'mrpd_30', '{"maxDistance":10,"state":1,"doors":false,"autolock":5,"heading":270,"groups":{"police":0},"unlockSound":"button-remote","lockSound":"button-remote","model":-1868050792,"coords":{"x":410.0257873535156,"y":-1020.1565551757813,"z":28.40199851989746}}'),
	(1660, 'mrpd_31', '{"maxDistance":10,"state":1,"doors":false,"autolock":5,"heading":270,"groups":{"police":0},"unlockSound":"button-remote","lockSound":"button-remote","model":-1635161509,"coords":{"x":410.0257873535156,"y":-1028.3189697265626,"z":28.41814613342285}}');

-- Dumping structure for table projectphoenix.paycheck_account
CREATE TABLE IF NOT EXISTS `paycheck_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `money` bigint(20) DEFAULT 0,
  PRIMARY KEY (`citizenid`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.paycheck_account: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.paycheck_logs
CREATE TABLE IF NOT EXISTS `paycheck_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `state` tinyint(1) DEFAULT 0,
  `amount` int(11) DEFAULT 0,
  `metadata` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.paycheck_logs: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.phone_chatrooms
CREATE TABLE IF NOT EXISTS `phone_chatrooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_code` varchar(10) NOT NULL,
  `room_name` varchar(15) NOT NULL,
  `room_owner_id` varchar(20) DEFAULT NULL,
  `room_owner_name` varchar(60) DEFAULT NULL,
  `room_members` text DEFAULT '{}',
  `room_pin` varchar(50) DEFAULT NULL,
  `unpaid_balance` decimal(10,2) DEFAULT 0.00,
  `is_pinned` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `room_code` (`room_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.phone_chatrooms: ~3 rows (approximately)
INSERT INTO `phone_chatrooms` (`id`, `room_code`, `room_name`, `room_owner_id`, `room_owner_name`, `room_members`, `room_pin`, `unpaid_balance`, `is_pinned`, `created`) VALUES
	(1, '411', '411', 'official', 'Government', '{}', NULL, 0.00, 1, '2023-06-04 18:15:16'),
	(2, 'lounge', 'The Lounge', 'official', 'Government', '{}', NULL, 0.00, 1, '2023-06-04 18:15:16'),
	(3, 'events', 'Events', 'official', 'Government', '{}', NULL, 0.00, 1, '2023-06-04 18:15:16');

-- Dumping structure for table projectphoenix.phone_chatroom_messages
CREATE TABLE IF NOT EXISTS `phone_chatroom_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int(10) unsigned DEFAULT NULL,
  `member_id` varchar(20) DEFAULT NULL,
  `member_name` varchar(50) DEFAULT NULL,
  `message` text NOT NULL,
  `is_pinned` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.phone_chatroom_messages: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.phone_gallery
CREATE TABLE IF NOT EXISTS `phone_gallery` (
  `citizenid` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.phone_gallery: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.phone_invoices
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.phone_invoices: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `messages` text DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.phone_messages: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.phone_note
CREATE TABLE IF NOT EXISTS `phone_note` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `text` text DEFAULT NULL,
  `lastupdate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.phone_note: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.phone_tweets
CREATE TABLE IF NOT EXISTS `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `firstName` varchar(25) DEFAULT NULL,
  `lastName` varchar(25) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `url` text DEFAULT NULL,
  `tweetId` varchar(25) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.phone_tweets: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.players
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text NOT NULL,
  `charinfo` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`citizenid`),
  KEY `id` (`id`),
  KEY `last_updated` (`last_updated`),
  KEY `license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.players: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.playerskins
CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table projectphoenix.playerskins: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.player_contacts
CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.player_contacts: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.player_houses
CREATE TABLE IF NOT EXISTS `player_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `house` (`house`),
  KEY `citizenid` (`citizenid`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.player_houses: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.player_jobs
CREATE TABLE IF NOT EXISTS `player_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jobname` varchar(50) DEFAULT NULL,
  `employees` text DEFAULT NULL,
  `maxEmployee` tinyint(11) DEFAULT 15,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.player_jobs: ~15 rows (approximately)
INSERT INTO `player_jobs` (`id`, `jobname`, `employees`, `maxEmployee`) VALUES
	(106, 'realestate', '[]', 15),
	(107, 'police', '[]', 15),
	(108, 'judge', '[]', 15),
	(109, 'reporter', '[]', 15),
	(110, 'tow', '[]', 15),
	(111, 'taxi', '[]', 15),
	(112, 'bus', '[]', 15),
	(113, 'garbage', '[]', 15),
	(114, 'ambulance', '[]', 15),
	(115, 'lawyer', '[]', 15),
	(116, 'cardealer', '[]', 15),
	(117, 'trucker', '[]', 15),
	(118, 'vineyard', '[]', 15),
	(119, 'mechanic', '[]', 15),
	(120, 'hotdog', '[]', 15);

-- Dumping structure for table projectphoenix.player_mails
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.player_mails: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.player_outfits
CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizenid_outfitname_model` (`citizenid`,`outfitname`,`model`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.player_outfits: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.player_outfit_codes
CREATE TABLE IF NOT EXISTS `player_outfit_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `outfitid` int(11) NOT NULL,
  `code` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_player_outfit_codes_player_outfits` (`outfitid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.player_outfit_codes: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.player_transactions
CREATE TABLE IF NOT EXISTS `player_transactions` (
  `id` varchar(50) NOT NULL,
  `isFrozen` int(11) DEFAULT 0,
  `transactions` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.player_transactions: ~1 rows (approximately)
INSERT INTO `player_transactions` (`id`, `isFrozen`, `transactions`) VALUES
	('RSF59658', 0, '[{"trans_id":"1ef78fc4-354a-4731-a801-44cb59e51ee8","title":"Personal Account / RSF59658","time":1685903649,"message":"hewllo","trans_type":"withdraw","receiver":"Law Enforcement","amount":50,"issuer":"Project Phoenix"}]');

-- Dumping structure for table projectphoenix.player_vehicles
CREATE TABLE IF NOT EXISTS `player_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  `balance` int(11) NOT NULL DEFAULT 0,
  `paymentamount` int(11) NOT NULL DEFAULT 0,
  `paymentsleft` int(11) NOT NULL DEFAULT 0,
  `financetime` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`),
  KEY `citizenid` (`citizenid`),
  KEY `license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.player_vehicles: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.player_warns
CREATE TABLE IF NOT EXISTS `player_warns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `senderIdentifier` varchar(50) DEFAULT NULL,
  `targetIdentifier` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `warnId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.player_warns: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.scenes
CREATE TABLE IF NOT EXISTS `scenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` varchar(50) DEFAULT NULL,
  `text` mediumtext DEFAULT NULL,
  `color` mediumtext DEFAULT NULL,
  `viewdistance` int(11) DEFAULT NULL,
  `expiration` int(11) DEFAULT NULL,
  `fontsize` decimal(10,1) DEFAULT NULL,
  `fontstyle` int(11) DEFAULT NULL,
  `coords` mediumtext DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `date_deletion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Dumping data for table projectphoenix.scenes: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.stashitems
CREATE TABLE IF NOT EXISTS `stashitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`stash`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.stashitems: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.trunkitems
CREATE TABLE IF NOT EXISTS `trunkitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.trunkitems: ~0 rows (approximately)

-- Dumping structure for table projectphoenix.vaults
CREATE TABLE IF NOT EXISTS `vaults` (
  `citizenid` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `storagename` varchar(255) NOT NULL,
  `storage_size` int(11) DEFAULT 400000,
  `holders` text DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storage_location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table projectphoenix.vaults: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
