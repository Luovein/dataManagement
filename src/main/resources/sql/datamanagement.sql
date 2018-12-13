/*
 Navicat Premium Data Transfer

 Source Server         : ManagerWeb
 Source Server Type    : MySQL
 Source Server Version : 50720
 Source Host           : localhost:3306
 Source Schema         : datamanagement

 Target Server Type    : MySQL
 Target Server Version : 50720
 File Encoding         : 65001

 Date: 13/12/2018 17:31:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_data_manage
-- ----------------------------
DROP TABLE IF EXISTS `t_data_manage`;
CREATE TABLE `t_data_manage`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `upload_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `view_count` int(255) NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `data_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `data_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_data_manage
-- ----------------------------
INSERT INTO `t_data_manage` VALUES (19, '1', '0:0:0:0:0:0:0:1', 'zhangsan', '2018-12-13 16:08:43', '2018-12-13 16:08:43', 1, 'D:\\worksoft\\apache-tomcat-9.0.0.M10\\wtpwebapps\\dataManagement\\uploadFile\\1544688523041', '2131321', '2313213111111', '');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `full_Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `class_Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `team_Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_Time` datetime(0) NULL DEFAULT NULL,
  `update_Time` datetime(0) NULL DEFAULT NULL,
  `manage_flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (3, 'zhangsan', '1', NULL, '1', '1', '1', '2018-12-12 14:46:56', '2018-12-12 14:46:56', '0');
INSERT INTO `t_user` VALUES (4, 'lisi', '1', '李四', '2班', '1111', '小组2', '2018-12-12 17:32:34', '2018-12-12 17:32:34', '0');
INSERT INTO `t_user` VALUES (5, 'wangwu', '1', '王五', '3班', '123213213221', '二组', '2018-12-12 17:33:08', '2018-12-12 17:33:08', '0');
INSERT INTO `t_user` VALUES (6, 'admin', '1', 'admin', '1', '1', '1', '2018-12-13 16:14:01', '2018-12-13 16:13:58', '1');

SET FOREIGN_KEY_CHECKS = 1;
