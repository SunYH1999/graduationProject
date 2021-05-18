/*
 Navicat Premium Data Transfer

 Source Server         : job
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : job

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 18/05/2021 17:32:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categories
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
-- Records of categories
-- ----------------------------
BEGIN;
INSERT INTO `categories` VALUES ('005598b5c8c54477b4e4636041771f72', '销售', '2021-03-18 07:16:33', '2021-03-18 07:16:33');
INSERT INTO `categories` VALUES ('2217af0743c947d2a7b5e3ca0ceef1c0', '研发', '2021-03-18 07:16:52', '2021-03-18 07:16:52');
INSERT INTO `categories` VALUES ('240a0601875a46fdb4ab35df1b95cb7e', '行政', '2021-03-18 07:17:19', '2021-03-18 07:17:19');
INSERT INTO `categories` VALUES ('6d1e2589836f4048b445ac49a91e111e', '产品', '2021-03-16 03:26:16', '2021-03-16 03:26:16');
INSERT INTO `categories` VALUES ('733ce6cde8c04bb2bd5d302a53810c80', '教育', '2021-03-18 07:17:05', '2021-03-18 07:17:05');
INSERT INTO `categories` VALUES ('8f0bb453f90f496e865bce36d4ea83ff', '设计', '2021-03-18 07:53:13', '2021-03-18 07:53:22');
INSERT INTO `categories` VALUES ('b5c5a2b7469347b3af78248298d70197', '运营', '2021-03-18 07:53:47', '2021-03-18 07:53:47');
INSERT INTO `categories` VALUES ('e0f3c0844f104ae3a3ca03d10fc9e272', '测试', '2021-05-18 09:29:51', '2021-05-18 09:29:51');
INSERT INTO `categories` VALUES ('ed7d828327074f25a8661a2cedc7cefb', '金融', '2021-03-18 07:17:12', '2021-03-18 07:17:12');
COMMIT;

-- ----------------------------
-- Table structure for companies
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
-- Records of companies
-- ----------------------------
BEGIN;
INSERT INTO `companies` VALUES ('436668e87f5e44a2913c5cc68b62ce8f', 'QZROC公司', '山东省青岛市', 100022, 'roc', '000001', 1, '2021-03-18 07:19:27', '2021-03-16 03:25:44', '810452e9913647fa8a3b41fd579f710e');
INSERT INTO `companies` VALUES ('ce2cc67c096a4b97aecb27bf2826f3e9', '健康科技有限公司', '北京市朝阳区', 20000000, '小孙', '230121199901010000', 1, '2021-05-18 09:29:02', '2021-05-18 09:29:27', '3902a09dc17d4c97a82c96c2a36b03d6');
INSERT INTO `companies` VALUES ('d82736e403b34793beafa69971d1d56d', '大鹏科技', '山东青岛', 8000, '大鹏', '888888', 1, '2021-03-18 07:51:15', '2021-03-18 07:52:03', '18e5ac76901249bbada6e10ed3fe77cf');
COMMIT;

-- ----------------------------
-- Table structure for jobings
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
-- Records of jobings
-- ----------------------------
BEGIN;
INSERT INTO `jobings` VALUES ('0866b46b1da64eae909499eedf250e5f', 0, '2021-03-18 07:59:59', '2021-03-18 07:59:59', 'cad72f78f97541edba813adcc19bd7dd', '85e5283ecabb44ec869a8a3ab759c41a');
INSERT INTO `jobings` VALUES ('57e31056c47e46bb8bc2733772f3c8c0', 0, '2021-05-18 09:31:52', '2021-05-18 09:31:52', 'bd3d5659b3a647d0a9659d234b1d2c5b', 'd5678695eda74914a953c8f043f120d0');
INSERT INTO `jobings` VALUES ('89bcdf4d97a842e78dfcfcc3338fe148', 0, '2021-03-16 03:14:26', '2021-03-16 03:14:26', 'cad72f78f97541edba813adcc19bd7dd', '064bdba2836c4431b2884db6539da7ec');
INSERT INTO `jobings` VALUES ('c93b1bc442f6427398f4ad311f45b94b', 0, '2021-03-18 07:24:51', '2021-03-18 07:24:51', '3d0c8a54fe244cb9b0e78029b0cd1399', 'd5678695eda74914a953c8f043f120d0');
INSERT INTO `jobings` VALUES ('cc080289bb8a4b7ca4b684a14b89cac0', 0, '2021-03-23 06:43:32', '2021-03-23 06:43:32', 'b08a0cbd36d448f2994aaa26ae21f065', 'd5678695eda74914a953c8f043f120d0');
COMMIT;

-- ----------------------------
-- Table structure for jobs
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
-- Records of jobs
-- ----------------------------
BEGIN;
INSERT INTO `jobs` VALUES ('0e8bfc77d6a844cb93a4bad4cca27793', '测试开发工程师', '3', '18k', 2, '打算发发vs知道v', 'scasvgsav', '2021-05-18 09:19:34', '2021-05-18 09:19:57', '810452e9913647fa8a3b41fd579f710e', NULL);
INSERT INTO `jobs` VALUES ('2c87cb2461a24f28aa94f0889f7724a6', 'hrbp', '3', '15k', 2, '从撒粉v撒v', '是的vfsawfvs', '2021-05-18 09:24:55', '2021-05-18 09:24:55', '18e5ac76901249bbada6e10ed3fe77cf', NULL);
INSERT INTO `jobs` VALUES ('2e7d1d1af82c4b46a9e5c4ae497d855e', '用户运营', '3', '14k', 1, '擦撒长发短发擦', '萨法沙发上发呆为股份', '2021-05-18 09:16:34', '2021-05-18 09:20:04', '810452e9913647fa8a3b41fd579f710e', NULL);
INSERT INTO `jobs` VALUES ('3d0c8a54fe244cb9b0e78029b0cd1399', '全栈工程师', '3年-5', '10-15', 1, '1、负责分布式平台上web产品的开发和维护；\n2、负责分布式管理平台的开发和维护，参与平台架构设计；\n3、负责系统多个子服务的设计、开发、重构及维护。', '1、具备全栈开发经验，包括网页前端、后端；\n2、熟悉Web前端技术，包括JQuery，React、CSS、Javascript、Responsive web等前端技术的一种或者几种；\n3、熟悉网站性能优化，技术体验优化，浏览器兼容性；\n4、熟悉PostgreSQL、MySQL或其它相关存储解决方案；\n5、具备良好的合作态度和团队精神，乐于学习，工作有激情，富有责任感。', '2021-03-18 07:22:01', '2021-05-18 09:20:41', '810452e9913647fa8a3b41fd579f710e', NULL);
INSERT INTO `jobs` VALUES ('59c5e88f85fc472f9baa0944ec2a7207', '高级产品经理', '5', '50k', 1, '是的发vasfvasfvsda ', '的是vazdvazva', '2021-05-18 09:24:35', '2021-05-18 09:24:35', '18e5ac76901249bbada6e10ed3fe77cf', NULL);
INSERT INTO `jobs` VALUES ('5db4e3d28d9f4a7ab49a5168c8fdd9bf', '高级产品经理', '5', '25k', 1, '负责游戏线产品工作', '有游戏行业产品经验', '2021-05-18 09:16:03', '2021-05-18 09:20:11', '810452e9913647fa8a3b41fd579f710e', NULL);
INSERT INTO `jobs` VALUES ('6f2e980d048049fc9719e69839cb271e', 'ui设计师', '1', '10k', 2, '负责前端ui设计', '一个月内入职', '2021-05-18 09:14:31', '2021-05-18 09:20:32', '810452e9913647fa8a3b41fd579f710e', NULL);
INSERT INTO `jobs` VALUES ('6f6eee8024e549bf8fcef256f8ccd030', '游戏运营', '1', '12k', 3, '第三发啊是的v个发烧', '十多个发vasdvsabvdf', '2021-05-18 09:25:26', '2021-05-18 09:25:26', '18e5ac76901249bbada6e10ed3fe77cf', NULL);
INSERT INTO `jobs` VALUES ('972f6e8e48c743c589b038f029cadc6c', '财务经理', '3', '12k', 1, 'sadasdas', 'safdasdfas', '2021-05-18 09:15:00', '2021-05-18 09:20:08', '810452e9913647fa8a3b41fd579f710e', NULL);
INSERT INTO `jobs` VALUES ('9dda93aa525941cca31058669afb0463', '前端开发工程师', '3', '35k', 1, 'vue/react/nuxt', '撒电话卡速滑发了快睡觉', '2021-05-18 09:24:03', '2021-05-18 09:24:03', '18e5ac76901249bbada6e10ed3fe77cf', NULL);
INSERT INTO `jobs` VALUES ('a4c6889765cc403190a34a0e0cf034b5', '社群运营', '1', '8k', 5, '打算在床上的VS我发的VS啊', '撒长发打算发大雾', '2021-05-18 09:16:58', '2021-05-18 09:20:37', '810452e9913647fa8a3b41fd579f710e', NULL);
INSERT INTO `jobs` VALUES ('aa4cd883e8484426a63be90d61434dc5', 'go开发工程师', '3', '21k', 1, '是的粉v的撒粉噶舒服 ', '阿斯顿次发v擦', '2021-05-18 09:22:15', '2021-05-18 09:22:15', '810452e9913647fa8a3b41fd579f710e', NULL);
INSERT INTO `jobs` VALUES ('b067fac118da4a449a078dcae670578e', '用户运营', '3', '20k', 3, '的风向标指数得分最高不得善终', '树大根深在德国v', '2021-05-18 09:27:23', '2021-05-18 09:27:23', '18e5ac76901249bbada6e10ed3fe77cf', NULL);
INSERT INTO `jobs` VALUES ('b08a0cbd36d448f2994aaa26ae21f065', 'PHP开发工程师', '3年', '10K', 3, '1635465', '465465', '2021-03-23 06:42:10', '2021-05-18 09:20:21', '810452e9913647fa8a3b41fd579f710e', NULL);
INSERT INTO `jobs` VALUES ('bd3d5659b3a647d0a9659d234b1d2c5b', '新媒体运营', '1', '8k', 2, 'savfdvfsaf', '生生世世都给撒饿噶我', '2021-05-18 09:30:29', '2021-05-18 09:30:29', '3902a09dc17d4c97a82c96c2a36b03d6', NULL);
INSERT INTO `jobs` VALUES ('cad72f78f97541edba813adcc19bd7dd', '大鹏科技-UI设计师', '3年以上', '15k', 2, '1、根据产品需求，对产品的整体美术风格、交互设计、界面结构、操作流程等做出设计；\n2、负责项目中各种交互界面、图标、LOGO、按钮等相关元素的设计与制作；\n3、辅助市场部做市场活动方案执行，同时能积极与开发和市场部进沟通，推进界面及交互设计的最终实现；\n4、负责软件界面的美术设计、创意工作和制作工作；\n5、根据各种相关软件的用户群，提出构思新颖、有高度吸引力的创意设计；\n6、对页面进行优化，使用户操作更趋于人性化；\n7、维护现有的应用产品。', '1、美术设计或计算机相关专业本科以上学历，一年以上互联网产品UI设计工作经验；\n2、精通Photoshop、illustrator、flash等常用设计工具；\n3、熟悉产品项目流程，熟悉设计规范，有自己独特的思维；\n4、具有良好的审美能力和手绘功底，有自己原创性；\n5、能积极的与产品，开发沟通，推进界面与交互设计的最终体现；\n6、有APP/WEB网站设计的项目案例，或有交互设计、UED经验者、做过交易线（支付环节）优先', '2021-03-18 07:56:04', '2021-05-18 09:23:19', '18e5ac76901249bbada6e10ed3fe77cf', NULL);
INSERT INTO `jobs` VALUES ('e4415643d4b747268a64c9f2597f9281', '前端开发工程师', '1', '15k', 3, '阿生产法沙发上', '撒粉擦拭粉擦', '2021-05-18 09:21:07', '2021-05-18 09:21:07', '810452e9913647fa8a3b41fd579f710e', NULL);
INSERT INTO `jobs` VALUES ('fa6600d8382145329e66d8aa35b3d8ff', '高级php开发工程师', '5', '40K', 1, 'aaadsfsd', 'afdafasfca', '2021-05-18 09:00:51', '2021-05-18 09:20:27', '810452e9913647fa8a3b41fd579f710e', NULL);
COMMIT;

-- ----------------------------
-- Table structure for resumes
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
-- Records of resumes
-- ----------------------------
BEGIN;
INSERT INTO `resumes` VALUES ('064bdba2836c4431b2884db6539da7ec', '321', 1, '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2021-03-16 03:13:42', '2021-03-16 03:13:42', '8256b553c18a4d87a84e2c951c170738');
INSERT INTO `resumes` VALUES ('06f0de4eda3f4d2cb94fdb23f731bbd9', '321', 1, '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2021-03-16 03:13:40', '2021-03-16 03:13:40', '8256b553c18a4d87a84e2c951c170738');
INSERT INTO `resumes` VALUES ('20a211804db447eda019f73b4c16d93b', '321', 1, '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2021-03-16 03:13:42', '2021-03-16 03:13:42', '8256b553c18a4d87a84e2c951c170738');
INSERT INTO `resumes` VALUES ('52d5663c4b974f4abc1052348f7f12c1', '321', 1, '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2021-03-16 03:13:41', '2021-03-16 03:13:41', '8256b553c18a4d87a84e2c951c170738');
INSERT INTO `resumes` VALUES ('6e3b09b85bc34b1b8cdb0aeb10c7de74', '321', 1, '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2021-03-16 03:13:43', '2021-03-16 03:13:43', '8256b553c18a4d87a84e2c951c170738');
INSERT INTO `resumes` VALUES ('85e5283ecabb44ec869a8a3ab759c41a', '小UI', 0, '1995-10-10 00:00:00', '山东青岛', '17863253454', 'xiaoui@qzroc.com', 'UI设计师', '8000', '1.负责新蛋APP产品的迭代和优化； 2.设计输出新蛋网视觉规范及标注文件和切图文件提交给开发部 3.配合运营部设计输出新蛋网专题页面 4.设计输出新蛋网web页面；', '3年', '大学本科', '我具有较强的组织能力和社交能力，能很好地独立开展工作，并与其他人协手合作，发扬团队精神', '2021-03-18 07:59:52', '2021-03-18 07:59:52', '5803eaa37718453c9de66b89b0a16e83');
INSERT INTO `resumes` VALUES ('b34a3ba368744c48ba77e27c1badd918', '321', 1, '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2021-03-16 03:13:35', '2021-03-16 03:13:35', '8256b553c18a4d87a84e2c951c170738');
INSERT INTO `resumes` VALUES ('c4fb8b74dc064748939abf6c84cc8388', '321', 1, '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2021-03-16 03:13:42', '2021-03-16 03:13:42', '8256b553c18a4d87a84e2c951c170738');
INSERT INTO `resumes` VALUES ('d5678695eda74914a953c8f043f120d0', 'qiuzhizhe', 1, '1996-01-01 00:00:00', '山东青岛', '17863253454', 'qiuzhizhe@qzroc.com', '全栈工程师', '8000', '1、具备全栈开发经验，包括网页前端、后端； 2、熟悉Web前端技术，包括JQuery，React、CSS、Javascript、Responsive web等前端技术的一种或者几种；', '3年', '大学本科', '能熟练的操作电脑，对OFFICE系列的WORD.EXCEL有一定的了解及掌握：具备一定的法律常识，并能在实践中加以运用：有良好的语言表达能力以及凝聚力，同时具备一定的交际管理能力。做人诚信踏实，富有责任感，待人真诚，学习和适应能力强，能坦然面对工作中的压力和挑战', '2021-03-18 07:24:36', '2021-03-18 07:24:36', 'f2a8b2e5b25e424388d629dffb0d3879');
INSERT INTO `resumes` VALUES ('ea4efe354fb94fc680010667c5f82be4', 'qiuzhizhe', 1, '1996-01-01 00:00:00', '山东青岛', '17863253454', 'qiuzhizhe@qzroc.com', '全栈工程师', '8000', '1、具备全栈开发经验，包括网页前端、后端； 2、熟悉Web前端技术，包括JQuery，React、CSS、Javascript、Responsive web等前端技术的一种或者几种；', '3年', '大学本科', '能熟练的操作电脑，对OFFICE系列的WORD.EXCEL有一定的了解及掌握：具备一定的法律常识，并能在实践中加以运用：有良好的语言表达能力以及凝聚力，同时具备一定的交际管理能力。做人诚信踏实，富有责任感，待人真诚，学习和适应能力强，能坦然面对工作中的压力和挑战', '2021-03-18 07:24:40', '2021-03-18 07:24:40', 'f2a8b2e5b25e424388d629dffb0d3879');
INSERT INTO `resumes` VALUES ('ef6fa57bac37414f83bb636087f7a90b', '321', 1, '4214-01-01 00:00:00', '143214124', '17863253454', '4214', '564623', '8000', '45366346543', '42314', '436', '6346', '2021-03-16 03:13:43', '2021-03-16 03:13:43', '8256b553c18a4d87a84e2c951c170738');
COMMIT;

-- ----------------------------
-- Table structure for users
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
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1320b98f127d41d5ad899894f7fb0a85', 'yuq', '123456', 2, '2570304824@qq.com', '18685574391', '688ba0ab07fe4ebd8d023613b1d8163a', '2021-03-16 03:16:05', '2021-03-16 03:16:18');
INSERT INTO `users` VALUES ('13c8147125c344b38c5388be38a41f65', 'xiaoming', '123123', 1, '123456789@163.com', '17777777777', '2aad178d4d9b4b98865f57238cc4522c', '2021-03-18 01:03:24', '2021-03-18 01:03:39');
INSERT INTO `users` VALUES ('18e5ac76901249bbada6e10ed3fe77cf', '大鹏科技', '123123', 2, 'dpkj@qzroc.com', '18800000000', '0bc93ca3e97d4f7b92c23b6453d560ed', '2021-03-18 07:47:49', '2021-05-18 09:23:02');
INSERT INTO `users` VALUES ('3902a09dc17d4c97a82c96c2a36b03d6', 'jiankang', '123123', 2, 'jiankang@163.com', '18646517589', '1cdece562f414c739c847e3288eaf506', '2021-05-18 09:28:17', '2021-05-18 09:31:59');
INSERT INTO `users` VALUES ('524715faf2dd11e88eb2f2801f1b9fd1', 'admin', '123456', 3, 'admin@admin.com', '13111111111', 'b49553c2d3d74c5d9ad69f6d8ac9872b', '2021-03-09 15:14:20', '2021-05-18 09:29:15');
INSERT INTO `users` VALUES ('5803eaa37718453c9de66b89b0a16e83', '小UI', '123123', 1, 'xiaoui@qzroc.com', '13012345678', 'c16c626af24b400288513a21396e63ae', '2021-03-18 07:56:54', '2021-03-18 07:57:17');
INSERT INTO `users` VALUES ('612f79c388134fc79f514c638fff2949', 'aa', '123123', 2, 'aa@163.com', '18812341234', 'eb42f068a9f34990a2ed48a2a94dab2d', '2021-03-12 14:43:34', '2021-03-12 14:43:46');
INSERT INTO `users` VALUES ('810452e9913647fa8a3b41fd579f710e', 'zhaopinzhe', '123123', 2, 'zhaopinzhe@qzroc.com', '18888888888', '2c7a00637d6b4d37b77e6b9b0600d974', '2021-03-18 07:18:23', '2021-05-18 09:13:39');
INSERT INTO `users` VALUES ('8256b553c18a4d87a84e2c951c170738', 'yu', '123456', 1, '2570304823@qq.com', '18685574390', '506fd2af61e34a15861dea1aa94493a0', '2021-03-16 03:12:16', '2021-03-16 04:06:26');
INSERT INTO `users` VALUES ('b30f785aaac24d88b317c6f3e0ff8842', '2016011226', '123456', 1, '123@q.com', '13712345678', '7692c39d77b942c3a85b1f0cd714b495', '2021-04-06 01:48:28', '2021-04-06 01:48:48');
INSERT INTO `users` VALUES ('c02ef0de8ea74a41b9f009a71a488aef', 'wade', '123123', 1, '874251402@qq.com', '18359139297', '5026457471c146fe808e09945df04bf4', '2021-03-06 02:17:51', '2021-03-06 14:42:51');
INSERT INTO `users` VALUES ('d93454bbdd0a4c6aa80e840454bf8a6d', '123123', '123123', 1, '239599886@qq.com', '18867613031', '221468415ac2421289ce5036cadba110', '2021-03-30 14:15:11', '2021-03-09 14:35:05');
INSERT INTO `users` VALUES ('f2a8b2e5b25e424388d629dffb0d3879', 'qiuzhizhe', '123123', 1, 'qiuzhizhe@qzroc.com', '17712341234', '95494cbd813844f0a2516aa2df66180d', '2021-03-18 07:18:03', '2021-05-18 09:30:42');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
