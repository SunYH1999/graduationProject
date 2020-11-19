/*
 Navicat MySQL Data Transfer

 Source Server         : 公司mysql
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : 39.106.193.158
 Source Database       : job

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : utf-8

 Date: 12/11/2019 13:48:23 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `categories`
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `categories`
-- ----------------------------
BEGIN;
INSERT INTO `categories` VALUES ('005598b5c8c54477b4e4636041771f72', '销售员', '2019-10-18 07:16:33', '2019-10-18 07:16:33'), ('2217af0743c947d2a7b5e3ca0ceef1c0', '全栈工程师', '2019-10-18 07:16:52', '2019-10-18 07:16:52'), ('240a0601875a46fdb4ab35df1b95cb7e', '秘书', '2019-10-18 07:17:19', '2019-10-18 07:17:19'), ('6d1e2589836f4048b445ac49a91e111e', 'web前端', '2019-11-16 03:26:16', '2019-11-16 03:26:16'), ('733ce6cde8c04bb2bd5d302a53810c80', '教师', '2019-10-18 07:17:05', '2019-10-18 07:17:05'), ('8f0bb453f90f496e865bce36d4ea83ff', 'UI设计师', '2019-10-18 07:53:13', '2019-10-18 07:53:22'), ('b5c5a2b7469347b3af78248298d70197', '项目经理', '2019-10-18 07:53:47', '2019-10-18 07:53:47'), ('ed7d828327074f25a8661a2cedc7cefb', '技术总监', '2019-10-18 07:17:12', '2019-10-18 07:17:12');
COMMIT;

-- ----------------------------
--  Table structure for `companies`
-- ----------------------------
DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `capital` int(11) NOT NULL,
  `charge` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `identification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `userId` (`userId`) USING BTREE,
  CONSTRAINT `companies_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `companies`
-- ----------------------------
BEGIN;
INSERT INTO `companies` VALUES ('436668e87f5e44a2913c5cc68b62ce8f', 'QZROC公司', '山东省青岛市', '100022', 'roc', '000001', '1', '2019-10-18 07:19:27', '2019-11-16 03:25:44', '810452e9913647fa8a3b41fd579f710e'), ('d82736e403b34793beafa69971d1d56d', '大鹏科技', '山东青岛', '8000', '大鹏', '888888', '1', '2019-10-18 07:51:15', '2019-10-18 07:52:03', '18e5ac76901249bbada6e10ed3fe77cf');
COMMIT;

-- ----------------------------
--  Table structure for `jobings`
-- ----------------------------
DROP TABLE IF EXISTS `jobings`;
CREATE TABLE `jobings` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `jobId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `resumeId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `jobings_resumeId_jobId_unique` (`jobId`,`resumeId`) USING BTREE,
  KEY `resumeId` (`resumeId`) USING BTREE,
  CONSTRAINT `jobings_ibfk_1` FOREIGN KEY (`jobId`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jobings_ibfk_2` FOREIGN KEY (`resumeId`) REFERENCES `resumes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `jobings`
-- ----------------------------
BEGIN;
INSERT INTO `jobings` VALUES ('0866b46b1da64eae909499eedf250e5f', '0', '2019-10-18 07:59:59', '2019-10-18 07:59:59', 'cad72f78f97541edba813adcc19bd7dd', '85e5283ecabb44ec869a8a3ab759c41a'), ('89bcdf4d97a842e78dfcfcc3338fe148', '0', '2019-11-16 03:14:26', '2019-11-16 03:14:26', 'cad72f78f97541edba813adcc19bd7dd', '064bdba2836c4431b2884db6539da7ec'), ('c93b1bc442f6427398f4ad311f45b94b', '0', '2019-10-18 07:24:51', '2019-10-18 07:24:51', '3d0c8a54fe244cb9b0e78029b0cd1399', 'd5678695eda74914a953c8f043f120d0'), ('cc080289bb8a4b7ca4b684a14b89cac0', '0', '2019-11-23 06:43:32', '2019-11-23 06:43:32', 'b08a0cbd36d448f2994aaa26ae21f065', 'd5678695eda74914a953c8f043f120d0');
COMMIT;

-- ----------------------------
--  Table structure for `jobs`
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `workYear` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `salary` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `categoryId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `userId` (`userId`) USING BTREE,
  KEY `categoryId` (`categoryId`) USING BTREE,
  CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `jobs_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `jobs`
-- ----------------------------
BEGIN;
INSERT INTO `jobs` VALUES ('3d0c8a54fe244cb9b0e78029b0cd1399', '全栈工程师', '3年-5', '10-15', '10', '1、负责分布式平台上web产品的开发和维护；\n2、负责分布式管理平台的开发和维护，参与平台架构设计；\n3、负责系统多个子服务的设计、开发、重构及维护。', '1、具备全栈开发经验，包括网页前端、后端；\n2、熟悉Web前端技术，包括JQuery，React、CSS、Javascript、Responsive web等前端技术的一种或者几种；\n3、熟悉网站性能优化，技术体验优化，浏览器兼容性；\n4、熟悉PostgreSQL、MySQL或其它相关存储解决方案；\n5、具备良好的合作态度和团队精神，乐于学习，工作有激情，富有责任感。', '2019-10-18 07:22:01', '2019-11-27 13:13:49', '810452e9913647fa8a3b41fd579f710e', null), ('b08a0cbd36d448f2994aaa26ae21f065', 'PHP开发工程师', '3年', '10K', '10', '1635465', '465465', '2019-11-23 06:42:10', '2019-11-23 06:42:10', '810452e9913647fa8a3b41fd579f710e', null), ('cad72f78f97541edba813adcc19bd7dd', '大鹏科技-UI设计师', '3年以上', '15k', '10', '1、根据产品需求，对产品的整体美术风格、交互设计、界面结构、操作流程等做出设计；\n2、负责项目中各种交互界面、图标、LOGO、按钮等相关元素的设计与制作；\n3、辅助市场部做市场活动方案执行，同时能积极与开发和市场部进沟通，推进界面及交互设计的最终实现；\n4、负责软件界面的美术设计、创意工作和制作工作；\n5、根据各种相关软件的用户群，提出构思新颖、有高度吸引力的创意设计；\n6、对页面进行优化，使用户操作更趋于人性化；\n7、维护现有的应用产品。', '1、美术设计或计算机相关专业本科以上学历，一年以上互联网产品UI设计工作经验；\n2、精通Photoshop、illustrator、flash等常用设计工具；\n3、熟悉产品项目流程，熟悉设计规范，有自己独特的思维；\n4、具有良好的审美能力和手绘功底，有自己原创性；\n5、能积极的与产品，开发沟通，推进界面与交互设计的最终体现；\n6、有APP/WEB网站设计的项目案例，或有交互设计、UED经验者、做过交易线（支付环节）优先', '2019-10-18 07:56:04', '2019-10-18 07:56:04', '18e5ac76901249bbada6e10ed3fe77cf', null);
COMMIT;

-- ----------------------------
--  Table structure for `resumes`
-- ----------------------------
DROP TABLE IF EXISTS `resumes`;
CREATE TABLE `resumes` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` int(11) NOT NULL,
  `year` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `hope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `salary` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `work` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `workYear` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `education` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `personal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `userId` (`userId`) USING BTREE,
  CONSTRAINT `resumes_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `resumes`
-- ----------------------------
BEGIN;
INSERT INTO `resumes` VALUES ('064bdba2836c4431b2884db6539da7ec', '321', '1', '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2019-11-16 03:13:42', '2019-11-16 03:13:42', '8256b553c18a4d87a84e2c951c170738'), ('06f0de4eda3f4d2cb94fdb23f731bbd9', '321', '1', '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2019-11-16 03:13:40', '2019-11-16 03:13:40', '8256b553c18a4d87a84e2c951c170738'), ('20a211804db447eda019f73b4c16d93b', '321', '1', '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2019-11-16 03:13:42', '2019-11-16 03:13:42', '8256b553c18a4d87a84e2c951c170738'), ('52d5663c4b974f4abc1052348f7f12c1', '321', '1', '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2019-11-16 03:13:41', '2019-11-16 03:13:41', '8256b553c18a4d87a84e2c951c170738'), ('6e3b09b85bc34b1b8cdb0aeb10c7de74', '321', '1', '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2019-11-16 03:13:43', '2019-11-16 03:13:43', '8256b553c18a4d87a84e2c951c170738'), ('85e5283ecabb44ec869a8a3ab759c41a', '小UI', '0', '1995-10-10 00:00:00', '山东青岛', '17863253454', 'xiaoui@qzroc.com', 'UI设计师', '8000', '1.负责新蛋APP产品的迭代和优化； 2.设计输出新蛋网视觉规范及标注文件和切图文件提交给开发部 3.配合运营部设计输出新蛋网专题页面 4.设计输出新蛋网web页面；', '3年', '大学本科', '我具有较强的组织能力和社交能力，能很好地独立开展工作，并与其他人协手合作，发扬团队精神', '2019-10-18 07:59:52', '2019-10-18 07:59:52', '5803eaa37718453c9de66b89b0a16e83'), ('b34a3ba368744c48ba77e27c1badd918', '321', '1', '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2019-11-16 03:13:35', '2019-11-16 03:13:35', '8256b553c18a4d87a84e2c951c170738'), ('c4fb8b74dc064748939abf6c84cc8388', '321', '1', '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2019-11-16 03:13:42', '2019-11-16 03:13:42', '8256b553c18a4d87a84e2c951c170738'), ('d5678695eda74914a953c8f043f120d0', 'qiuzhizhe', '1', '1996-01-01 00:00:00', '山东青岛', '17863253454', 'qiuzhizhe@qzroc.com', '全栈工程师', '8000', '1、具备全栈开发经验，包括网页前端、后端； 2、熟悉Web前端技术，包括JQuery，React、CSS、Javascript、Responsive web等前端技术的一种或者几种；', '3年', '大学本科', '能熟练的操作电脑，对OFFICE系列的WORD.EXCEL有一定的了解及掌握：具备一定的法律常识，并能在实践中加以运用：有良好的语言表达能力以及凝聚力，同时具备一定的交际管理能力。做人诚信踏实，富有责任感，待人真诚，学习和适应能力强，能坦然面对工作中的压力和挑战', '2019-10-18 07:24:36', '2019-10-18 07:24:36', 'f2a8b2e5b25e424388d629dffb0d3879'), ('ea4efe354fb94fc680010667c5f82be4', 'qiuzhizhe', '1', '1996-01-01 00:00:00', '山东青岛', '17863253454', 'qiuzhizhe@qzroc.com', '全栈工程师', '8000', '1、具备全栈开发经验，包括网页前端、后端； 2、熟悉Web前端技术，包括JQuery，React、CSS、Javascript、Responsive web等前端技术的一种或者几种；', '3年', '大学本科', '能熟练的操作电脑，对OFFICE系列的WORD.EXCEL有一定的了解及掌握：具备一定的法律常识，并能在实践中加以运用：有良好的语言表达能力以及凝聚力，同时具备一定的交际管理能力。做人诚信踏实，富有责任感，待人真诚，学习和适应能力强，能坦然面对工作中的压力和挑战', '2019-10-18 07:24:40', '2019-10-18 07:24:40', 'f2a8b2e5b25e424388d629dffb0d3879'), ('ef6fa57bac37414f83bb636087f7a90b', '321', '1', '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2019-11-16 03:13:43', '2019-11-16 03:13:43', '8256b553c18a4d87a84e2c951c170738');
COMMIT;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` int(255) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `token` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `mobile` (`mobile`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1320b98f127d41d5ad899894f7fb0a85', 'yuq', '123456', '2', '2570304824@qq.com', '18685574391', '688ba0ab07fe4ebd8d023613b1d8163a', '2019-11-16 03:16:05', '2019-11-16 03:16:18'), ('13c8147125c344b38c5388be38a41f65', 'xiaoming', '123123', '1', '123456789@163.com', '17777777777', '2aad178d4d9b4b98865f57238cc4522c', '2019-11-18 01:03:24', '2019-11-18 01:03:39'), ('18e5ac76901249bbada6e10ed3fe77cf', '大鹏科技', '123123', '2', 'dpkj@qzroc.com', '18800000000', 'f2fa8effd41f4de79ae81cc9b05892ec', '2019-10-18 07:47:49', '2019-10-18 07:54:12'), ('524715faf2dd11e88eb2f2801f1b9fd1', 'admin', '123456', '3', 'admin@admin.com', '13111111111', '6692c02b057c4ada985dd239c0d73208', '2018-11-28 15:14:20', '2019-12-09 02:55:19'), ('5803eaa37718453c9de66b89b0a16e83', '小UI', '123123', '1', 'xiaoui@qzroc.com', '13012345678', 'c16c626af24b400288513a21396e63ae', '2019-10-18 07:56:54', '2019-10-18 07:57:17'), ('612f79c388134fc79f514c638fff2949', 'aa', '123123', '2', 'aa@163.com', '18812341234', 'eb42f068a9f34990a2ed48a2a94dab2d', '2019-11-12 14:43:34', '2019-11-12 14:43:46'), ('810452e9913647fa8a3b41fd579f710e', 'zhaopinzhe', '123123', '2', 'zhaopinzhe@qzroc.com', '18888888888', 'fdd896410791439f888805a5045e3614', '2019-10-18 07:18:23', '2019-12-09 02:55:52'), ('8256b553c18a4d87a84e2c951c170738', 'yu', '123456', '1', '2570304823@qq.com', '18685574390', '506fd2af61e34a15861dea1aa94493a0', '2019-11-16 03:12:16', '2019-11-16 04:06:26'), ('b30f785aaac24d88b317c6f3e0ff8842', '2016011226', '123456', '1', '123@q.com', '13712345678', '7692c39d77b942c3a85b1f0cd714b495', '2019-12-06 01:48:28', '2019-12-06 01:48:48'), ('c02ef0de8ea74a41b9f009a71a488aef', 'wade', '123123', '1', '874251402@qq.com', '18359139297', '5026457471c146fe808e09945df04bf4', '2019-11-06 02:17:51', '2019-11-06 14:42:51'), ('d93454bbdd0a4c6aa80e840454bf8a6d', '123123', '123123', '1', '239599886@qq.com', '18867613031', '221468415ac2421289ce5036cadba110', '2019-10-30 14:15:11', '2019-11-09 14:35:05'), ('f2a8b2e5b25e424388d629dffb0d3879', 'qiuzhizhe', '123123', '1', 'qiuzhizhe@qzroc.com', '17712341234', '7867e421ae8d4df49b395c98bf910ede', '2019-10-18 07:18:03', '2019-11-27 13:15:11');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
