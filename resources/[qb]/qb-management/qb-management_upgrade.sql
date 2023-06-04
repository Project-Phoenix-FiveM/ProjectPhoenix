-- Use this if you are upgrading an existing DB/Server (this will copy your current bossmenu and gangmenu data to QB-Management jobs/gangs)
CREATE TABLE IF NOT EXISTS `management_funds` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`job_name` VARCHAR(50) NOT NULL,
`amount`  INT(100) NOT NULL,
`type` ENUM('boss','gang') NOT NULL DEFAULT 'boss',
PRIMARY KEY (`id`),
UNIQUE KEY `job_name` (`job_name`),
KEY `type` (`type`)
);

-- First we do boss menu (THIS WILL PULL YOUR CURRENT bossmenu DATA AND ADD IT TO THE NEWLY CREATED TABLE)
INSERT INTO `management_funds` (`job_name`, `amount`, `type`)
SELECT job_name, amount, 'boss' FROM bossmenu;


-- [[ You can remove all of this if you want, this is just to confirm everything moved over correctly ]]--
SET @totalbossmenu = (SELECT COUNT(*) FROM `bossmenu`);
SET @managemenu_boss = (SELECT COUNT(*) FROM `management_funds` WHERE type = 'boss');

SELECT CONCAT("TOTAL BOSS MENU: ", @totalbossmenu);
SELECT CONCAT("TOTAL MANAGE MENU: ", @managemenu_boss);

-- Check that all of boss menu moved;
DELIMITER $
BEGIN NOT ATOMIC
IF @totalbossmenu = @managemenu_boss THEN
	SELECT CONCAT("CONGRATS, BOSS FULLY MOVED [You can delete bossmenu if you desire]", " ");
ELSE
	SELECT CONCAT("UT OH, SOMETHING DID NOT WORK (BOSS) [Check what got moved and what didn't manually]", " ");
END IF;
END $
DELIMITER ;
-- [[ end confirming all of bossmenu moved correctly ]]--


-- Lastly we do the gang menu (THIS WILL PULL YOUR CURRENT gangmenu DATA AND ADD IT TO THE NEWLY CREATED TABLE)
INSERT INTO `management_funds` (`job_name`, `amount`, `type`)
SELECT job_name, amount, 'gang' FROM gangmenu;


-- [[ You can remove all of this if you want, this is just to confirm everything moved over correctly ]]--
SET @totalgangmenu = (SELECT COUNT(*) FROM `gangmenu`);
SET @managemenu_gang = (SELECT COUNT(*) FROM `management_funds` WHERE type = 'gang');

SELECT CONCAT("TOTAL GANG MENU: ", @totalgangmenu);
SELECT CONCAT("TOTAL MANAGE GANG MENU: ", @managemenu_gang);

-- Check that all of gang menu moved;
DELIMITER $
BEGIN NOT ATOMIC
IF @totalgangmenu = @managemenu_gang THEN
	SELECT CONCAT("CONGRATS, GANG FULLY MOVED [You can delete gangmenu if you desire]", " ");
ELSE
	SELECT CONCAT("UT OH, SOMETHING DID NOT WORK (GANG) [Check what got moved and what didn't manually]", " ");
END IF;
END $
DELIMITER ;
-- [[ end confirming all of gangmenu moved correctly ]]--


