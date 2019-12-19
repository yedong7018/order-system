/*
MySQL Backup
Database: order
Backup Time: 2019-12-19 19:51:33
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `order`.`address`;
DROP TABLE IF EXISTS `order`.`admin`;
DROP TABLE IF EXISTS `order`.`cartitem`;
DROP TABLE IF EXISTS `order`.`collection`;
DROP TABLE IF EXISTS `order`.`evaluation`;
DROP TABLE IF EXISTS `order`.`food`;
DROP TABLE IF EXISTS `order`.`foodtype`;
DROP TABLE IF EXISTS `order`.`orderitem`;
DROP TABLE IF EXISTS `order`.`orders`;
DROP TABLE IF EXISTS `order`.`user`;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '地址id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '姓名',
  `phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '手机号',
  `addr` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '详细地址',
  PRIMARY KEY (`id`),
  KEY `fk_a_u` (`uid`),
  CONSTRAINT `fk_a_u` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE TABLE `admin` (
  `admname` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '管理员账号',
  `admpassword` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '密码',
  PRIMARY KEY (`admname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE TABLE `cartitem` (
  `uid` int(11) NOT NULL COMMENT '用户id',
  `fid` int(11) NOT NULL COMMENT '菜品id',
  `count` int(11) NOT NULL COMMENT '菜品数量',
  `subtotal` decimal(10,2) NOT NULL COMMENT '小计',
  KEY `fk_ci_f` (`fid`),
  KEY `fk_ci_u` (`uid`),
  CONSTRAINT `fk_ci_f` FOREIGN KEY (`fid`) REFERENCES `food` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_ci_u` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE TABLE `collection` (
  `uid` int(11) NOT NULL COMMENT '用户id',
  `fid` int(11) NOT NULL COMMENT '菜品id',
  `addtime` datetime NOT NULL COMMENT '收藏时间',
  KEY `fk_fa_u` (`uid`),
  KEY `fk_fa_f` (`fid`),
  CONSTRAINT `fk_fa_f` FOREIGN KEY (`fid`) REFERENCES `food` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_fa_u` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE TABLE `evaluation` (
  `oid` varchar(16) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户id',
  `fid` int(11) NOT NULL COMMENT '菜品id',
  `rating` tinyint(4) NOT NULL COMMENT '评分',
  KEY `fk_e_f` (`fid`),
  KEY `fk_e_o` (`oid`),
  CONSTRAINT `fk_e_f` FOREIGN KEY (`fid`) REFERENCES `food` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_e_o` FOREIGN KEY (`oid`) REFERENCES `orders` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE TABLE `food` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜品id',
  `ftid` int(11) DEFAULT NULL COMMENT '分类id',
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '菜品名称',
  `image` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT '菜品图片路径',
  `price` decimal(10,2) NOT NULL COMMENT '菜品单价',
  `info` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '菜品说明',
  `sold` int(11) DEFAULT '0' COMMENT '月售',
  PRIMARY KEY (`id`),
  KEY `fk_f_ft` (`ftid`),
  CONSTRAINT `fk_f_ft` FOREIGN KEY (`ftid`) REFERENCES `foodtype` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE TABLE `foodtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE TABLE `orderitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单条目id',
  `oid` varchar(16) COLLATE utf8_unicode_ci NOT NULL COMMENT '订单id',
  `fid` int(11) NOT NULL COMMENT '菜品id',
  `count` int(11) NOT NULL COMMENT '菜品数量',
  `subtotal` decimal(10,2) NOT NULL COMMENT '订单条目小计',
  PRIMARY KEY (`id`),
  KEY `fk_oi_f` (`fid`),
  KEY `fk_oi_c` (`oid`),
  CONSTRAINT `fk_oi_c` FOREIGN KEY (`oid`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_oi_f` FOREIGN KEY (`fid`) REFERENCES `food` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE TABLE `orders` (
  `id` varchar(16) COLLATE utf8_unicode_ci NOT NULL COMMENT '订单号',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `time` datetime NOT NULL COMMENT '下单时间',
  `sendTime` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT '送达时间',
  `state` tinyint(4) NOT NULL COMMENT '订单状态（0已取消，1未付款，2待送达，3已完成，4已评价）',
  `total` decimal(10,2) NOT NULL COMMENT '合计',
  `payMethod` tinyint(4) NOT NULL COMMENT '支付方式（2微信，1支付宝，3到付）',
  `remark` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '收获人姓名',
  `phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '收获人手机号',
  `address` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '收货人详细地址',
  PRIMARY KEY (`id`),
  KEY `fk_o_u` (`uid`),
  CONSTRAINT `fk_o_u` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '密码',
  `phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '手机号码',
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '邮箱地址',
  `code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用于找回密码的验证码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_phone` (`phone`) USING BTREE,
  UNIQUE KEY `uk_email` (`email`) USING BTREE,
  UNIQUE KEY `uk_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
BEGIN;
LOCK TABLES `order`.`address` WRITE;
DELETE FROM `order`.`address`;
INSERT INTO `order`.`address` (`id`,`uid`,`name`,`phone`,`addr`) VALUES (18, 1, '海哥来了', '15802026894', '华山17-311'),(19, 1, 'xxhh', '15813366580', '华山17-311'),(33, 1, 'y1ao', '15813346894', '华山17-311'),(34, 1, '123', '15813365458', '华山17-401'),(35, 0, '123', '123', '123'),(37, 8, '123456', '15813365456', 'thgd'),(38, 8, '123', '15813365456', 'thgd'),(39, 8, '456', '15813365456', 'thgd'),(41, 12, 'hhh', '15813348542', 'xxxxxxxx'),(42, 1, 'test123', '13612345678', '花山区'),(43, 1, 'test', '13212345678', '华山区'),(44, 1, 'test', '13212345678', '华山'),(45, 1, '我就', '15823366611', '深圳5');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `order`.`admin` WRITE;
DELETE FROM `order`.`admin`;
INSERT INTO `order`.`admin` (`admname`,`admpassword`) VALUES ('5+X', '123'),('hoby', '123');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `order`.`cartitem` WRITE;
DELETE FROM `order`.`cartitem`;
INSERT INTO `order`.`cartitem` (`uid`,`fid`,`count`,`subtotal`) VALUES (8, 1, 1, 5.00),(11, 1, 4, 20.00);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `order`.`collection` WRITE;
DELETE FROM `order`.`collection`;
INSERT INTO `order`.`collection` (`uid`,`fid`,`addtime`) VALUES (8, 2, '2019-06-16 23:43:18'),(9, 1, '2019-06-29 19:59:59'),(10, 1, '2019-06-29 20:04:04'),(12, 1, '2019-06-29 20:32:10'),(1, 14, '2019-06-29 21:31:52');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `order`.`evaluation` WRITE;
DELETE FROM `order`.`evaluation`;
INSERT INTO `order`.`evaluation` (`oid`,`fid`,`rating`) VALUES ('89631080e5474b5', 1, 3),('89631080e5474b5', 20, 4),('89631080e5474b5', 5, 5),('4e5284226fd6458', 2, 4),('4e5284226fd6458', 4, 5),('4e5284226fd6458', 6, 3),('58ffffde01b24b3', 2, 5),('63aa4070bdde491', 5, 4),('63aa4070bdde491', 20, 5),('69284a7be0bc466', 20, 5);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `order`.`food` WRITE;
DELETE FROM `order`.`food`;
INSERT INTO `order`.`food` (`id`,`ftid`,`name`,`image`,`price`,`info`,`sold`) VALUES (1, 3, '红烧狮子头', '253b05.webp', 5.00, '狮子头呢', 21),(2, 9, '红烧鱼块', '898f6a.webp', 22.88, '红烧鱼块属于沪菜，后广泛流传至全国，成为一道老百姓饭桌上的家常菜。红烧鱼块一般以草鱼为原料制作，配上少许干辣椒，酱油烹饪，鲜香味美。', 19),(3, 10, '牛肉烩面', '3.webp', 26.00, '娜美同款，就问你敢恰吗', 6),(4, 10, '五香牛肉桂林米粉', 'f4bb60d1b0d143fd97d4490ba9a0cda3df1078e917353043642a4efed0514jpeg.webp', 18.00, '真香', 26),(5, 11, '小伙慢炖', 'a60129.webp', 16.80, '小伙熬出来的心血，可带劲了', 9),(6, 9, '重庆鸡公煲', 'f13bf8.webp', 13.60, '越吃越上瘾，怀疑下了药', 18),(7, 1, '咖喱鸡柳芝士焗饭', '11cd7d.webp', 14.50, '吃了这份超大的咖喱鸡柳芝士焗饭，吃完我竟然不觉得撑反而觉得刚刚好！请问我是不是要长身体了？', 3),(8, 1, '台湾卤肉饭', 'c848e8.webp', 11.20, '精选上等五花肉，台湾进口调料，最最最古早味的台湾美食，妈妈才有的味道! 主要原料：洋葱,蒜头,猪肉末', 7),(9, 10, '玉米鲜肉饺', '61da06.webp', 20.00, '大份18个 主要原料：猪肉', 0),(10, 10, '牛肉蛋炒米粉', '0d8b0f.webp', 11.00, '加辣请备注', 1),(11, 3, '手打牛筋丸', '253b05.webp', 5.50, '（4个）要单独装请备注', 4),(12, 7, '肉碎拉肠', '787931.webp', 9.90, '新鲜食材，现点现做，美味可口！', 3),(13, 7, '皮蛋瘦肉粥', '3989f4.webp', 8.00, '虽然有点贵，但是很好恰！', 0),(14, 9, '剁椒鱼腩饭', '898f6a.webp', 20.00, '海哥最爱！', 0),(15, 2, '绿豆糖水', '60e3c6.webp', 6.00, '我喝了，拉肚子了，有什么好说的', 3),(16, 1, '一只鸡', '20fcd0.webp', 16.88, '偷鸡的小伙汁你可别被我逮着', 1),(17, 1, '5+x', '15592315252211.webp', 0.05, '白给', 120),(18, 1, '巨无霸套餐', '0125fe.webp', 32.80, '巨无霸1份+薯格/大薯条/大玉+饮料可选', 1),(19, 12, '一品蒸饺', '7d5de2.webp', 6.00, '沙县大酒店招牌', 4),(20, 11, '山药玉米排骨汤', 'e607efdb61ed489cb02c0ecfc88707bf06ebab3dc2ac7dccd9c3dbbd591ecjpeg.webp', 22.66, '大补', 13);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `order`.`foodtype` WRITE;
DELETE FROM `order`.`foodtype`;
INSERT INTO `order`.`foodtype` (`id`,`name`) VALUES (12, '传统美食2'),(11, '养生补品'),(9, '地方菜'),(3, '小吃炸串'),(8, '川湘菜'),(6, '异国料理'),(1, '快餐便当'),(13, '水果蔬菜'),(5, '汉堡披萨'),(2, '甜品饮品'),(7, '粤菜'),(10, '面食'),(4, '香锅冒菜');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `order`.`orderitem` WRITE;
DELETE FROM `order`.`orderitem`;
INSERT INTO `order`.`orderitem` (`id`,`oid`,`fid`,`count`,`subtotal`) VALUES (68, '7e982082bfef45e', 19, 1, 6.00),(69, '9f739591f8d4451', 1, 1, 5.00),(70, '9f739591f8d4451', 20, 1, 22.66),(71, '9f739591f8d4451', 5, 1, 16.80),(72, '89631080e5474b5', 1, 1, 5.00),(73, '89631080e5474b5', 20, 1, 22.66),(74, '89631080e5474b5', 5, 1, 16.80),(75, '14185c0def574ed', 1, 1, 5.00),(76, '14185c0def574ed', 20, 1, 22.66),(77, '14185c0def574ed', 5, 1, 16.80),(78, '88a996a6d28c4be', 6, 5, 68.00),(79, '88a996a6d28c4be', 4, 7, 126.00),(80, '88a996a6d28c4be', 2, 7, 160.16),(81, '88a996a6d28c4be', 8, 1, 11.20),(82, '88a996a6d28c4be', 12, 1, 9.90),(83, '3594c9b518f9452', 1, 1, 5.00),(84, '3594c9b518f9452', 20, 1, 22.66),(85, '3594c9b518f9452', 5, 1, 16.80),(86, 'ef75bd966164409', 2, 3, 68.64),(87, '17f6cb559b5c4ed', 1, 1, 5.00),(88, '17f6cb559b5c4ed', 20, 1, 22.66),(89, '17f6cb559b5c4ed', 5, 1, 16.80),(90, 'c28197e74d8242c', 6, 1, 13.60),(91, '5f925a8628bf456', 8, 2, 22.40),(92, 'ef5ded7da39b4d5', 1, 1, 5.00),(93, 'ef5ded7da39b4d5', 20, 1, 22.66),(94, '4e5284226fd6458', 2, 1, 22.88),(95, '4e5284226fd6458', 4, 1, 18.00),(96, '4e5284226fd6458', 6, 1, 13.60),(97, 'b127ccd3f57e4a1', 4, 10, 180.00),(98, 'b127ccd3f57e4a1', 6, 1, 13.60),(99, 'b127ccd3f57e4a1', 8, 1, 11.20),(100, 'd1af5886450f490', 2, 1, 22.88),(101, '58ffffde01b24b3', 2, 1, 22.88),(102, '05c51b2163e5485', 6, 1, 13.60),(103, '05c51b2163e5485', 8, 2, 22.40),(104, '05c51b2163e5485', 7, 2, 29.00),(105, 'e7baee42b940401', 6, 1, 13.60),(106, 'e7baee42b940401', 4, 1, 18.00),(107, 'e7baee42b940401', 2, 1, 22.88),(108, '73874ec066c4491', 20, 1, 22.66),(109, '73874ec066c4491', 5, 2, 33.60),(110, '63aa4070bdde491', 5, 2, 33.60),(111, '63aa4070bdde491', 20, 2, 45.32),(112, '69284a7be0bc466', 20, 2, 45.32);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `order`.`orders` WRITE;
DELETE FROM `order`.`orders`;
INSERT INTO `order`.`orders` (`id`,`uid`,`time`,`sendTime`,`state`,`total`,`payMethod`,`remark`,`name`,`phone`,`address`) VALUES ('05c51b2163e5485', 1, '2019-06-29 21:50:05', '22:19', 3, 65.00, 1, '放楼下', 'test', '13212345678', '华山区'),('14185c0def574ed', 1, '2019-06-22 18:19:33', '尽快送达', 1, 44.46, 1, '', '海哥来了', '15802026894', '华山17-311'),('17f6cb559b5c4ed', 1, '2019-06-28 20:37:19', '尽快送达', 1, 44.46, 2, '', '海哥来了', '15802026894', '华山17-311'),('3594c9b518f9452', 1, '2019-06-28 19:27:07', '尽快送达', 1, 44.46, 1, '', '海哥来了', '15802026894', '华山17-311'),('4e5284226fd6458', 1, '2019-06-29 20:32:13', '尽快送达', 4, 54.48, 1, '', '海哥来了', '15802026894', '华山17-311'),('58ffffde01b24b3', 1, '2019-06-29 21:33:41', '23:45', 4, 22.88, 3, '', '海哥来了', '15802026894', '华山17-311'),('5f925a8628bf456', 9, '2019-06-29 19:59:15', '尽快送达', 1, 22.40, 1, '', 'undefined', 'undefined', 'undefined'),('63aa4070bdde491', 1, '2019-06-29 21:56:14', '22:30', 4, 78.92, 1, '放楼下', '123', '13312345678', '华山区'),('69284a7be0bc466', 1, '2019-06-29 21:57:16', '尽快送达', 4, 45.32, 3, '', '海哥来了', '15802026894', '华山17-311'),('73874ec066c4491', 1, '2019-06-29 21:53:34', '22:30', 3, 56.26, 1, '放楼下', 'test', '13212345678', '华山'),('7e982082bfef45e', 1, '2019-03-01 14:15:18', '尽快送达', 3, 6.00, 3, '多点辣', '海哥来了哦', '15802026894', '华山17-311'),('88a996a6d28c4be', 1, '2019-06-22 18:30:42', '尽快送达', 3, 375.26, 1, '', '海哥来了', '15802026894', '华山17-311'),('89631080e5474b5', 1, '2019-06-17 14:16:02', '尽快送达', 4, 44.46, 1, '', '海哥来了哦', '15802026894', '华山17-311'),('9f739591f8d4451', 1, '2019-06-17 14:15:34', '尽快送达', 3, 44.46, 1, '', '海哥来了哦', '15802026894', '华山17-311'),('b127ccd3f57e4a1', 1, '2019-06-29 21:29:18', '尽快送达', 1, 204.80, 1, '', '海哥来了', '15802026894', '华山17-311'),('c28197e74d8242c', 9, '2019-06-29 19:59:03', '尽快送达', 1, 13.60, 2, '', 'undefined', 'undefined', 'undefined'),('d1af5886450f490', 1, '2019-06-29 21:30:55', '尽快送达', 3, 22.88, 3, '', '海哥来了', '15802026894', '华山17-311'),('e7baee42b940401', 1, '2019-06-29 21:53:24', '尽快送达', 2, 54.48, 3, '', '海哥来了', '15802026894', '华山17-311'),('ef5ded7da39b4d5', 12, '2019-06-29 20:31:07', '尽快送达', 1, 27.66, 1, '', 'undefined', 'undefined', 'undefined'),('ef75bd966164409', 1, '2019-06-28 20:35:50', '尽快送达', 3, 68.64, 1, '', '海哥来了', '15802026894', '华山17-311');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `order`.`user` WRITE;
DELETE FROM `order`.`user`;
INSERT INTO `order`.`user` (`id`,`username`,`password`,`phone`,`email`,`code`) VALUES (0, 'test', '123', '13123456789', 'test@test.com', NULL),(1, 'hoby', '1234', '15813365456', '873546061@qq.com', NULL),(2, 'Ayao', '881998', '15813348541', '15813348541@163.com', NULL),(3, 'nimade', '123', '15811111111', 't@qq.com', NULL),(8, 'asd', '1234', '15813365458', 'asd@qq.com', NULL),(9, '555', '8888', '15813348543', '15813348543@163.com', NULL),(10, '111', '111', '15813348544', '1555545@163.com', NULL),(11, '为基础', '123', '15813348548', '756667187@qq.com', NULL),(12, 'ytt', '123456', '15813347548', '15813348571@163.com', NULL),(13, 'whai', '123', '15802026894', '1720912130@qq.com', NULL);
UNLOCK TABLES;
COMMIT;
