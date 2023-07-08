CREATE TABLE `kevin_processing_plants` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `stage` varchar(50) DEFAULT 'stage_a',
    `seedname` varchar(50) DEFAULT NULL,
    `plantmodel` varchar(50) DEFAULT 'bkr_prop_weed_bud_01b',
    `gender` varchar(50) DEFAULT NULL,
    `food` int(11) DEFAULT 100,
    `water` int(11) DEFAULT 100,
    `health` int(11) DEFAULT 100,
    `progress` int(11) DEFAULT 0,
    `harvestable` BOOLEAN DEFAULT 0,
    `plantdead` BOOLEAN DEFAULT 0,
    `coords` mediumtext DEFAULT NULL,
    `soil` varchar(50) DEFAULT NULL,
    `zone` varchar(50) DEFAULT NULL,
    `last_updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

