CREATE TABLE IF NOT EXISTS `av_gangs` (
  `identifier` varchar(50) DEFAULT NULL,
  `playerName` varchar(50) DEFAULT NULL,
  `isBoss` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `photo` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;