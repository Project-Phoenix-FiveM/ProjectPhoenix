-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.4.0.6659
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
CREATE DATABASE IF NOT EXISTS `projectphoenix` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `projectphoenix`;

-- Dumping structure for table projectphoenix.av_restaurants
CREATE TABLE IF NOT EXISTS `av_restaurants` (
  `name` varchar(50) NOT NULL,
  `job` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table projectphoenix.av_restaurants: ~46 rows (approximately)
INSERT INTO `av_restaurants` (`name`, `job`, `type`, `data`) VALUES
	('beanmachine1237', 'beanmachine', 'duty', '{"job":"beanmachine","width":0.5,"event":"av_restaurant:duty","height":0.5,"type":"duty","distance":2,"name":"beanmachine1237","minZ":29.6,"heading":311.6,"maxZ":30.1,"coords":{"x":126.9927978515625,"y":-1034.5986328125,"z":29.57448196411132}}'),
	('beanmachine4463', 'beanmachine', 'rate', '{"job":"beanmachine","width":0.5,"event":"av_restaurant:rate","height":0.5,"type":"rate","distance":2,"name":"beanmachine4463","minZ":29.8,"heading":80.4,"maxZ":30.3,"coords":{"x":114.04424285888672,"y":-1041.9658203125,"z":29.7655029296875}}'),
	('beanmachine4558', 'beanmachine', 'washhands', '{"width":0.5,"distance":2,"height":0.5,"name":"beanmachine4558","heading":254.2,"coords":{"z":29.28353881835937,"y":-1039.2371826171876,"x":123.64994812011719},"job":"beanmachine","maxZ":29.8,"event":"av_restaurant:washhands","minZ":29.3,"type":"washhands"}'),
	('beanmachine5884', 'beanmachine', 'food', '{"job":"beanmachine","width":0.5,"event":"av_restaurant:food","height":0.5,"type":"food","distance":2,"name":"beanmachine5884","minZ":29.2,"heading":62.7,"maxZ":29.7,"coords":{"x":121.65714263916016,"y":-1038.488037109375,"z":29.22468948364257}}'),
	('beanmachine6283', 'beanmachine', 'drink', '{"job":"beanmachine","width":0.6,"event":"av_restaurant:drink","height":0.5,"type":"drink","distance":2,"name":"beanmachine6283","minZ":29.3,"heading":252.4,"maxZ":29.8,"coords":{"x":124.67068481445313,"y":-1036.890625,"z":29.2800235748291}}'),
	('beanmachine6351', 'beanmachine', 'stash', '{"job":"beanmachine","width":0.5,"event":"av_restaurant:stash","height":0.5,"type":"stash","distance":2,"name":"beanmachine6351","minZ":29.4,"heading":255.6,"maxZ":29.9,"coords":{"x":123.28610229492188,"y":-1040.6947021484376,"z":29.44094467163086}}'),
	('beanmachine6582', 'beanmachine', 'drink', '{"job":"beanmachine","width":0.7,"event":"av_restaurant:drink","height":0.5,"type":"drink","distance":2,"name":"beanmachine6582","minZ":29.3,"heading":251.0,"maxZ":29.8,"coords":{"x":122.9353256225586,"y":-1041.658447265625,"z":29.27565574645996}}'),
	('beanmachine7452', 'beanmachine', 'tray', '{"maxZ":29.7,"type":"tray","distance":2,"minZ":29.2,"height":0.5,"coords":{"x":120.52483367919922,"y":-1040.728271484375,"z":29.22468948364257},"event":"av_restaurant:tray","job":"beanmachine","name":"beanmachine7452","width":0.5,"heading":76.8}'),
	('beanmachine7657', 'beanmachine', 'drink', '{"maxZ":29.9,"type":"drink","distance":2,"minZ":29.4,"height":0.5,"coords":{"x":123.22050476074219,"y":-1042.6441650390626,"z":29.43660354614257},"event":"av_restaurant:drink","job":"beanmachine","name":"beanmachine7657","width":0.5,"heading":336.2}'),
	('beanmachine8254', 'beanmachine', 'tray', '{"maxZ":29.7,"type":"tray","distance":2,"minZ":29.2,"height":0.5,"coords":{"x":121.84768676757813,"y":-1037.0843505859376,"z":29.22468948364257},"event":"av_restaurant:tray","job":"beanmachine","name":"beanmachine8254","width":0.5,"heading":68.9}'),
	('beanmachine8293', 'beanmachine', 'cashier', '{"maxZ":30.0,"type":"cashier","distance":2,"minZ":29.5,"height":0.5,"coords":{"x":121.82423400878906,"y":-1036.509521484375,"z":29.48188209533691},"event":["av_restaurant:chargeCustomer","av_restaurant:pay"],"job":"beanmachine","name":"beanmachine8293","width":0.5,"heading":76.4}'),
	('beanmachine8340', 'beanmachine', 'boss', '{"maxZ":30.1,"type":"boss","distance":2,"minZ":29.6,"height":0.5,"coords":{"x":126.91265869140625,"y":-1035.8505859375,"z":29.63039970397949},"event":"av_restaurant:boss","job":"beanmachine","name":"beanmachine8340","width":0.5,"heading":357.3}'),
	('beanmachine8378', 'beanmachine', 'cashier', '{"maxZ":30.0,"type":"cashier","distance":2,"minZ":29.5,"height":0.5,"coords":{"x":120.75315856933594,"y":-1040.080322265625,"z":29.48388290405273},"event":["av_restaurant:chargeCustomer","av_restaurant:pay"],"job":"beanmachine","name":"beanmachine8378","width":0.5,"heading":90.0}'),
	('hornys1370', 'hornys', 'tray', '{"job":"hornys","width":0.5,"minZ":69.0,"distance":2,"height":0.5,"coords":{"x":1250.0599365234376,"y":-359.3716735839844,"z":68.9947280883789},"name":"hornys1370","event":"av_restaurant:tray","type":"tray","maxZ":69.5,"heading":164.5}'),
	('hornys2247', 'hornys', 'drink', '{"job":"hornys","width":0.5,"minZ":69.1,"distance":2,"height":0.5,"coords":{"x":1246.3564453125,"y":-356.97271728515627,"z":69.14746856689453},"name":"hornys2247","event":"av_restaurant:drink","type":"drink","maxZ":69.6,"heading":79.7}'),
	('hornys4034', 'hornys', 'boss', '{"job":"hornys","width":0.5,"minZ":69.0,"distance":2,"height":0.5,"coords":{"x":1239.552490234375,"y":-348.0252685546875,"z":68.982666015625},"name":"hornys4034","event":"av_restaurant:boss","type":"boss","maxZ":69.5,"heading":317.2}'),
	('hornys4056', 'hornys', 'stash', '{"job":"hornys","width":0.5,"minZ":69.1,"distance":2,"height":0.5,"coords":{"x":1245.8297119140626,"y":-354.8875427246094,"z":69.0965347290039},"name":"hornys4056","event":"av_restaurant:stash","type":"stash","maxZ":69.6,"heading":257.4}'),
	('hornys4527', 'hornys', 'food', '{"job":"hornys","width":0.5,"minZ":69.1,"distance":2,"height":0.5,"coords":{"x":1253.4749755859376,"y":-355.50543212890627,"z":69.07139587402344},"name":"hornys4527","event":"av_restaurant:food","type":"food","maxZ":69.6,"heading":259.4}'),
	('hornys5251', 'hornys', 'duty', '{"job":"hornys","width":0.5,"minZ":69.4,"distance":2,"height":0.5,"coords":{"x":1243.5352783203126,"y":-349.9078674316406,"z":69.35731506347656},"name":"hornys5251","event":"av_restaurant:duty","type":"duty","maxZ":69.9,"heading":358.4}'),
	('hornys5375', 'hornys', 'stash', '{"height":0.5,"maxZ":69.5,"heading":177.9,"distance":2,"minZ":69.0,"name":"hornys8049","type":"stash","width":0.5,"event":"av_restaurant:stash","job":"hornys","coords":{"z":69.04913330078125,"y":-356.6184387207031,"x":1251.95751953125}}'),
	('hornys5816', 'hornys', 'cashier', '{"job":"hornys","width":0.5,"minZ":69.1,"distance":3,"height":0.5,"coords":{"x":1253.38134765625,"y":-358.3126220703125,"z":69.09496307373047},"name":"hornys5816","event":["av_restaurant:chargeCustomer","av_restaurant:pay"],"type":"cashier","maxZ":69.6,"heading":273.3}'),
	('hornys5942', 'hornys', 'washhands', '{"job":"hornys","width":0.5,"minZ":69.0,"distance":2,"height":0.5,"coords":{"x":1251.0430908203126,"y":-352.44384765625,"z":68.96678161621094},"name":"hornys5942","event":"av_restaurant:washhands","type":"washhands","maxZ":69.5,"heading":86.4}'),
	('hornys6351', 'hornys', 'stash', '{"job":"hornys","width":0.5,"minZ":69.2,"distance":2,"height":0.5,"coords":{"x":1248.8353271484376,"y":-352.1917419433594,"z":69.20596313476563},"name":"hornys6351","event":"av_restaurant:stash","type":"stash","maxZ":69.7,"heading":343.2}'),
	('hornys7062', 'hornys', 'tray', '{"job":"hornys","width":0.5,"minZ":69.0,"distance":2,"height":0.5,"coords":{"x":1253.2691650390626,"y":-358.7377624511719,"z":69.02442932128906},"name":"hornys7062","event":"av_restaurant:tray","type":"tray","maxZ":69.5,"heading":263.9}'),
	('hornys7341', 'hornys', 'others', '{"name":"hornys7341","maxZ":69.5,"width":0.5,"heading":177.8,"minZ":69.0,"distance":2,"height":0.5,"type":"others","event":"av_restaurant:others","coords":{"x":1250.6702880859376,"z":69.04913330078125,"y":-355.9400634765625},"job":"hornys"}'),
	('hornys8049', 'hornys', 'stash', '{"height":0.5,"maxZ":69.8,"heading":342.6,"distance":2,"minZ":69.3,"name":"hornys8049","type":"stash","width":1.7,"event":"av_restaurant:stash","job":"hornys","coords":{"z":69.26061248779297,"y":-357.15863037109377,"x":1251.773681640625}}'),
	('hornys8181', 'hornys', 'cashier', '{"job":"hornys","width":0.5,"minZ":69.2,"distance":2,"height":0.5,"coords":{"x":1250.7552490234376,"y":-359.3903503417969,"z":69.16629791259766},"name":"hornys8181","event":["av_restaurant:chargeCustomer","av_restaurant:pay"],"type":"cashier","maxZ":69.7,"heading":221.7}'),
	('hornys8902', 'hornys', 'tray', '{"job":"hornys","width":0.5,"minZ":69.0,"distance":2,"height":0.5,"coords":{"x":1251.43603515625,"y":-359.7471923828125,"z":68.9947280883789},"name":"hornys8902","event":"av_restaurant:tray","type":"tray","maxZ":69.5,"heading":166.4}'),
	('hornys9206', 'hornys', 'cashier', '{"job":"hornys","width":0.5,"minZ":69.2,"distance":2,"height":0.5,"coords":{"x":1249.3837890625,"y":-359.0352478027344,"z":69.16971588134766},"name":"hornys9206","event":["av_restaurant:chargeCustomer","av_restaurant:pay"],"type":"cashier","maxZ":69.7,"heading":198.7}'),
	('hornys9227', 'hornys', 'cashier', '{"job":"hornys","width":0.5,"minZ":69.2,"distance":2,"height":0.5,"coords":{"x":1248.1741943359376,"y":-358.7179870605469,"z":69.17161560058594},"name":"hornys9227","event":["av_restaurant:chargeCustomer","av_restaurant:pay"],"type":"cashier","maxZ":69.7,"heading":164.2}'),
	('hornys9381', 'hornys', 'food', '{"job":"hornys","width":0.5,"minZ":69.1,"distance":2,"height":0.5,"coords":{"x":1254.1947021484376,"y":-352.8525390625,"z":69.07487487792969},"name":"hornys9381","event":"av_restaurant:food","type":"food","maxZ":69.6,"heading":271.6}'),
	('hornys9878', 'hornys', 'tray', '{"job":"hornys","width":0.5,"minZ":69.0,"distance":2,"height":0.5,"coords":{"x":1248.7757568359376,"y":-358.9684143066406,"z":68.9947280883789},"name":"hornys9878","event":"av_restaurant:tray","type":"tray","maxZ":69.5,"heading":157.3}'),
	('maldinis1747', 'maldinis', 'washhands', '{"name":"maldinis1747","maxZ":27.2,"width":0.5,"heading":175.0,"minZ":26.7,"distance":2,"height":0.5,"type":"washhands","event":"av_restaurant:washhands","coords":{"x":809.5032958984375,"z":26.69173622131347,"y":-765.2522583007813},"job":"maldinis"}'),
	('maldinis3753', 'maldinis', 'drink', '{"name":"maldinis3753","maxZ":27.2,"width":0.5,"heading":265.7,"minZ":26.7,"distance":2,"height":0.5,"type":"drink","event":"av_restaurant:drink","coords":{"x":811.2979125976563,"z":26.69229698181152,"y":-764.3934936523438},"job":"maldinis"}'),
	('maldinis4056', 'maldinis', 'boss', '{"name":"maldinis4056","maxZ":31.6,"width":0.5,"heading":137.4,"minZ":31.1,"distance":2,"height":0.5,"type":"boss","event":"av_restaurant:boss","coords":{"x":797.1561279296875,"z":31.09637451171875,"y":-751.4625854492188},"job":"maldinis"}'),
	('maldinis4059', 'maldinis', 'stash', '{"name":"maldinis4059","maxZ":27.6,"width":0.5,"heading":97.9,"minZ":27.1,"distance":2,"height":0.5,"type":"stash","event":"av_restaurant:stash","coords":{"x":805.9454345703125,"z":27.10038757324218,"y":-761.6376342773438},"job":"maldinis"}'),
	('maldinis4262', 'maldinis', 'drink', '{"name":"maldinis4262","maxZ":27.5,"width":0.5,"heading":269.4,"minZ":27.0,"distance":2,"height":0.5,"type":"drink","event":"av_restaurant:drink","coords":{"x":814.1994018554688,"z":26.96577072143554,"y":-749.3516845703125},"job":"maldinis"}'),
	('maldinis4621', 'maldinis', 'others', '{"name":"maldinis4621","maxZ":27.7,"width":0.5,"heading":274.5,"minZ":27.2,"distance":2,"height":0.5,"type":"others","event":"av_restaurant:others","coords":{"x":813.3416748046875,"z":27.20621299743652,"y":-759.4125366210938},"job":"maldinis"}'),
	('maldinis5064', 'maldinis', 'food', '{"name":"maldinis5064","maxZ":27.4,"width":0.5,"heading":252.3,"minZ":26.9,"distance":2,"height":0.5,"type":"food","event":"av_restaurant:food","coords":{"x":808.2252197265625,"z":26.89111709594726,"y":-760.1249389648438},"job":"maldinis"}'),
	('maldinis5102', 'maldinis', 'stash', '{"name":"maldinis5102","maxZ":27.3,"width":0.5,"heading":14.6,"minZ":26.8,"distance":2,"height":0.5,"type":"stash","event":"av_restaurant:stash","coords":{"x":803.2852172851563,"z":26.76097297668457,"y":-757.0692138671875},"job":"maldinis"}'),
	('maldinis5900', 'maldinis', 'rate', '{"name":"maldinis5900","maxZ":27.5,"width":0.5,"heading":268.4,"minZ":27.0,"distance":2,"height":0.5,"type":"rate","event":"av_restaurant:rate","coords":{"x":810.7039184570313,"z":27.03169822692871,"y":-752.9462280273438},"job":"maldinis"}'),
	('maldinis6536', 'maldinis', 'washhands', '{"name":"maldinis6536","maxZ":27.2,"width":0.5,"heading":205.0,"minZ":26.7,"distance":2,"height":0.5,"type":"washhands","event":"av_restaurant:washhands","coords":{"x":813.1221923828125,"z":26.74670600891113,"y":-755.4466552734375},"job":"maldinis"}'),
	('maldinis7842', 'maldinis', 'stash', '{"name":"maldinis7842","maxZ":26.8,"width":0.5,"heading":256.6,"minZ":26.3,"distance":2,"height":0.5,"type":"stash","event":"av_restaurant:stash","coords":{"x":813.8169555664063,"z":26.31983757019043,"y":-750.0498657226563},"job":"maldinis"}'),
	('maldinis8250', 'maldinis', 'cashier', '{"name":"maldinis8250","maxZ":27.5,"width":0.5,"heading":105.0,"minZ":27.0,"distance":2,"height":0.5,"type":"cashier","event":["av_restaurant:chargeCustomer","av_restaurant:pay"],"coords":{"x":810.8490600585938,"z":27.03169822692871,"y":-750.7528076171875},"job":"maldinis"}'),
	('maldinis8737', 'maldinis', 'tray', '{"name":"maldinis8737","maxZ":27.5,"width":0.5,"heading":271.9,"minZ":27.0,"distance":2,"height":0.5,"type":"tray","event":"av_restaurant:tray","coords":{"x":810.8857421875,"z":27.03169822692871,"y":-751.4386596679688},"job":"maldinis"}'),
	('maldinis9344', 'maldinis', 'duty', '{"name":"maldinis9344","maxZ":27.6,"width":0.5,"heading":276.7,"minZ":27.1,"distance":2,"height":0.5,"type":"duty","event":"av_restaurant:duty","coords":{"x":813.78369140625,"z":27.09939002990722,"y":-751.1013793945313},"job":"maldinis"}');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
