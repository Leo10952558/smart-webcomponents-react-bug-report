/*
 Navicat Premium Data Transfer

 Source Server         : Dragonet
 Source Server Type    : MySQL
 Source Server Version : 100425
 Source Host           : 127.0.0.1:3306
 Source Schema         : payment

 Target Server Type    : MySQL
 Target Server Version : 100425
 File Encoding         : 65001

 Date: 09/02/2023 20:57:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物件名',
  `is_house` tinyint(4) NOT NULL DEFAULT 0 COMMENT '住宅フラグ',
  `ended` tinyint(4) NOT NULL DEFAULT 0 COMMENT '終了フラグ',
  `contract_amount` int(11) NOT NULL DEFAULT 0 COMMENT '契約金額',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `created_user_id` int(11) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `updated_user_id` int(11) NULL DEFAULT NULL,
  `deleted` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_01`(`ended`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物件マスタ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of articles
-- ----------------------------
INSERT INTO `articles` VALUES (1, 'article1', 1, 0, 10000, '2023-01-29 02:08:12', 3, '2023-02-08 02:09:50', 3, NULL);
INSERT INTO `articles` VALUES (2, 'article2', 0, 0, 12500000, '2023-01-29 02:08:33', 3, '2023-01-29 02:08:33', 3, NULL);

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp(0) NOT NULL DEFAULT current_timestamp(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (6, '2023_01_10_164453_create_roles_table', 1);
INSERT INTO `migrations` VALUES (8, '2014_10_12_000000_create_users_table', 2);
INSERT INTO `migrations` VALUES (9, '2023_01_10_170129_create_user_roles_table', 3);
INSERT INTO `migrations` VALUES (10, '2023_01_11_210510_create_menus_table', 4);
INSERT INTO `migrations` VALUES (11, '2023_01_15_220053_create_construction_menus_table', 5);
INSERT INTO `migrations` VALUES (12, '2023_01_16_104128_create_system_logs_table', 6);
INSERT INTO `migrations` VALUES (13, '2023_01_16_114307_create_table_maps_table', 7);

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token`) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type`, `tokenable_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------
INSERT INTO `personal_access_tokens` VALUES (1, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '6a65f90fcb67e7cbdc6af09dfb23e5e99da7d06e45e399a3ff9a4d531d9b3944', '[\"*\"]', NULL, '2022-12-25 11:02:41', '2022-12-25 11:02:41');
INSERT INTO `personal_access_tokens` VALUES (2, 'App\\Models\\User', 4, 'Laravel Password Grant Client', '3942a7a416bb98620307fa83711bf611c4d891a79857cf560a766ab9a9b79d2c', '[\"*\"]', NULL, '2022-12-25 11:08:37', '2022-12-25 11:08:37');
INSERT INTO `personal_access_tokens` VALUES (3, 'App\\Models\\User', 1, 'Laravel Password Grant Client', '4f273f7d9f5aa00a814834f2302000b5d827b274cad567cfa2b7b1b750a49226', '[\"*\"]', NULL, '2022-12-26 11:24:08', '2022-12-26 11:24:08');
INSERT INTO `personal_access_tokens` VALUES (4, 'App\\Models\\User', 1, 'Laravel Password Grant Client', 'eecabd9affbfe897921d57be3ec850e8da7173a72281259b58106b81be2b770a', '[\"*\"]', NULL, '2022-12-26 11:24:23', '2022-12-26 11:24:23');
INSERT INTO `personal_access_tokens` VALUES (5, 'App\\Models\\User', 5, 'Laravel Password Grant Client', '09be904992d7d875c7f3c5d4902acb4d55bbca8900540236c84af245d42ddc83', '[\"*\"]', NULL, '2022-12-26 11:26:17', '2022-12-26 11:26:17');
INSERT INTO `personal_access_tokens` VALUES (6, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '7003906a52e8f4489eaddf0d5e6a6bfe2ff5865d84be65c461208fbdbe641f72', '[\"*\"]', NULL, '2022-12-26 11:32:46', '2022-12-26 11:32:46');
INSERT INTO `personal_access_tokens` VALUES (7, 'App\\Models\\User', 7, 'Laravel Password Grant Client', 'b6f921d3cfbd4b6484050788810a32aae04ec11bf1012e6c2e1ba667ede100e4', '[\"*\"]', NULL, '2022-12-26 11:37:07', '2022-12-26 11:37:07');
INSERT INTO `personal_access_tokens` VALUES (8, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '59c6614a02bbe45e51a0ea361e10e57da28d86dedaab126cb40eb0c3df52616e', '[\"*\"]', NULL, '2022-12-26 11:42:05', '2022-12-26 11:42:05');
INSERT INTO `personal_access_tokens` VALUES (9, 'App\\Models\\User', 7, 'Laravel Password Grant Client', 'f4e7fc5018ef8f7c51c452b9facc8613a056cf7ae986860c4eb1ecb1b9ead4e0', '[\"*\"]', NULL, '2022-12-26 11:42:15', '2022-12-26 11:42:15');
INSERT INTO `personal_access_tokens` VALUES (10, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '2ab9fcf64b648548c4d65f02f5e87d3b03522c7e996279b1c6907fde0b4fde83', '[\"*\"]', NULL, '2022-12-26 11:42:25', '2022-12-26 11:42:25');
INSERT INTO `personal_access_tokens` VALUES (11, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '657a497a240f3365577981bb16bc28a1a51313f068d2155a8ade3c74794b62e2', '[\"*\"]', NULL, '2022-12-26 11:49:52', '2022-12-26 11:49:52');
INSERT INTO `personal_access_tokens` VALUES (12, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '166ea846d2141de1fd273e7f618914c70c88740ebee00cd2fc848c7aa494b274', '[\"*\"]', NULL, '2022-12-27 12:32:32', '2022-12-27 12:32:32');
INSERT INTO `personal_access_tokens` VALUES (13, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '4acd74b41ab7ed692c19d30bfef3f13f7de26913b0b6f3c27c55ece4f659f53c', '[\"*\"]', NULL, '2022-12-28 06:19:34', '2022-12-28 06:19:34');
INSERT INTO `personal_access_tokens` VALUES (14, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '8befe0c59014975bb7da0eea8f0735c61703875f3233cb6b92fa35c851d94cc9', '[\"*\"]', NULL, '2022-12-28 19:32:07', '2022-12-28 19:32:07');
INSERT INTO `personal_access_tokens` VALUES (15, 'App\\Models\\User', 7, 'Laravel Password Grant Client', 'd5401a7487b1b3161671631b855ededc31ed23ec06be8d45078350c8ca43033d', '[\"*\"]', NULL, '2022-12-28 19:33:21', '2022-12-28 19:33:21');
INSERT INTO `personal_access_tokens` VALUES (16, 'App\\Models\\User', 7, 'Laravel Password Grant Client', 'e746da2047c1886fdfaef1672337954088c08db835a415ca046b5bc1789d8e34', '[\"*\"]', NULL, '2022-12-28 19:39:13', '2022-12-28 19:39:13');
INSERT INTO `personal_access_tokens` VALUES (17, 'App\\Models\\User', 7, 'Laravel Password Grant Client', 'd7b18d8d26e0dd6d494535c5bb7f9ef636c552e6cb263c98b545e3f0319ec224', '[\"*\"]', NULL, '2022-12-28 19:40:29', '2022-12-28 19:40:29');
INSERT INTO `personal_access_tokens` VALUES (18, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '0e6220ea2cc3f276a6788811cbcc4230d1897455dcb299ae5281b87dbcff0ae5', '[\"*\"]', NULL, '2022-12-28 19:51:16', '2022-12-28 19:51:16');
INSERT INTO `personal_access_tokens` VALUES (19, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '9ad5b78312d6853d2e44af9b62e5e6cad95b270ec357b48fc5bbedf28bded12c', '[\"*\"]', NULL, '2022-12-28 20:04:34', '2022-12-28 20:04:34');
INSERT INTO `personal_access_tokens` VALUES (20, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '898413f537f61f842d2878e53063e33c51ffa74649358ee3d2f18ec575b9cfd5', '[\"*\"]', NULL, '2022-12-28 20:04:45', '2022-12-28 20:04:45');
INSERT INTO `personal_access_tokens` VALUES (21, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '84e5cd3400642b5fd7e8a0af4ddd0de2f3e8ea668f9e62af2d68be7eaf6e1a92', '[\"*\"]', '2022-12-30 01:48:13', '2022-12-28 20:22:50', '2022-12-30 01:48:13');
INSERT INTO `personal_access_tokens` VALUES (22, 'App\\Models\\User', 7, 'Laravel Password Grant Client', 'a8a7faa88af6c91e6970d67c3711520bd5819477ad3c26ddd5c653eed2da7cb1', '[\"*\"]', NULL, '2022-12-28 20:29:40', '2022-12-28 20:29:40');
INSERT INTO `personal_access_tokens` VALUES (23, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '039190c7ebf94e1396764e6cf9d6cff0a8c8ea03b130a837072a1e7667b657b3', '[\"*\"]', NULL, '2022-12-28 20:40:36', '2022-12-28 20:40:36');
INSERT INTO `personal_access_tokens` VALUES (24, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '478a36e27b238a2aa2421b4e96be47d41322ac6d333a431ee6c2a475b630c228', '[\"*\"]', NULL, '2022-12-28 20:50:54', '2022-12-28 20:50:54');
INSERT INTO `personal_access_tokens` VALUES (25, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '1e75e518186a769e52fcd31c18328c57bf1acfbce1a5100b4c19ba71ee49604d', '[\"*\"]', '2022-12-28 21:36:11', '2022-12-28 21:34:38', '2022-12-28 21:36:11');
INSERT INTO `personal_access_tokens` VALUES (26, 'App\\Models\\User', 7, 'Laravel Password Grant Client', '58a099496ffd059b962b7e1e1b930f7372f044a830eb416c3fa5da5b44d8ea73', '[\"*\"]', '2022-12-28 21:45:46', '2022-12-28 21:35:55', '2022-12-28 21:45:46');
INSERT INTO `personal_access_tokens` VALUES (27, 'App\\Models\\User', 8, 'Laravel Password Grant Client', 'c7c202641fbdc0ce4efc01eea2da33aea0c48a9531dbd2af1177e3cb06d90f28', '[\"*\"]', NULL, '2022-12-28 21:40:08', '2022-12-28 21:40:08');
INSERT INTO `personal_access_tokens` VALUES (28, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '10a89286893d965c200cd0ec5fd83f208a60c7aec3fe780927d3f493dcbc6d64', '[\"*\"]', '2022-12-28 21:44:53', '2022-12-28 21:40:26', '2022-12-28 21:44:53');
INSERT INTO `personal_access_tokens` VALUES (29, 'App\\Models\\User', 9, 'Laravel Password Grant Client', 'd3422efcc968383dc42f95244350ec778b11aa716814f6b1de06bf9d27a0706c', '[\"*\"]', NULL, '2022-12-28 21:55:12', '2022-12-28 21:55:12');
INSERT INTO `personal_access_tokens` VALUES (30, 'App\\Models\\User', 9, 'Laravel Password Grant Client', '8b419b3ad5180ceb8692cc84ec77d29322983732ec40cfad12c7cfa32f689d71', '[\"*\"]', NULL, '2022-12-28 21:55:39', '2022-12-28 21:55:39');
INSERT INTO `personal_access_tokens` VALUES (31, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '7bd1613fb51d3d630a77a2cc7662fb3fbae4389f434fc219412007257409f019', '[\"*\"]', NULL, '2022-12-28 23:46:38', '2022-12-28 23:46:38');
INSERT INTO `personal_access_tokens` VALUES (32, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '6c6ba9cda643d569f9c04ca9f589f7c5ca5b05b110df54e5e33e3857bc5ea3b7', '[\"*\"]', NULL, '2022-12-28 23:51:23', '2022-12-28 23:51:23');
INSERT INTO `personal_access_tokens` VALUES (33, 'App\\Models\\User', 8, 'Laravel Password Grant Client', 'c7fb53b4ccd41f5fd9420fdc27a7c4cbc9ed73a6f95535f7c7e485ed7c465ed7', '[\"*\"]', NULL, '2022-12-30 00:30:52', '2022-12-30 00:30:52');
INSERT INTO `personal_access_tokens` VALUES (34, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '27a6e62a2eaf6b78f04e5125f892ba61b42e647851be30a7a33c0734db61c118', '[\"*\"]', NULL, '2022-12-30 00:46:29', '2022-12-30 00:46:29');
INSERT INTO `personal_access_tokens` VALUES (35, 'App\\Models\\User', 8, 'Laravel Password Grant Client', 'bb4faa2828bd2629ffbdf188f82671d84cb26fdbce07e04f718cde34bfb06ceb', '[\"*\"]', NULL, '2022-12-30 00:48:33', '2022-12-30 00:48:33');
INSERT INTO `personal_access_tokens` VALUES (36, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '4baa6ef25f0108b176d850061f2559b41b21017f4c2f90a1db4b5ae419135212', '[\"*\"]', NULL, '2022-12-30 00:56:26', '2022-12-30 00:56:26');
INSERT INTO `personal_access_tokens` VALUES (37, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '6aa24485bb438f7b86b0c61ab9e7ab96e9c6ab0f61d3d024c9d871e47b9480b6', '[\"*\"]', NULL, '2022-12-30 01:12:47', '2022-12-30 01:12:47');
INSERT INTO `personal_access_tokens` VALUES (38, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '3a085be4a96e129c497ee569744c35bdee5776c1e2c61d25f80cc835d0fd6e01', '[\"*\"]', NULL, '2022-12-30 01:14:37', '2022-12-30 01:14:37');
INSERT INTO `personal_access_tokens` VALUES (39, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '8b3c6267814aaf625d41a423ead418ca943f968609f1927b2824b52a084adef0', '[\"*\"]', NULL, '2022-12-30 01:16:35', '2022-12-30 01:16:35');
INSERT INTO `personal_access_tokens` VALUES (40, 'App\\Models\\User', 9, 'Laravel Password Grant Client', 'd2be5f61263c0303e02e5178d5177b4289b4a723562ae2d9bd010e4f765d60d0', '[\"*\"]', '2022-12-30 01:40:38', '2022-12-30 01:40:24', '2022-12-30 01:40:38');
INSERT INTO `personal_access_tokens` VALUES (41, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '5a2716c422242944ff59394efce7a9689275111f8a4d2c7ebad6f47a363a6e22', '[\"*\"]', '2022-12-30 12:59:18', '2022-12-30 01:40:53', '2022-12-30 12:59:18');
INSERT INTO `personal_access_tokens` VALUES (42, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '9693156b5f68399962067d685b4df4eef756bdab2a3e1ba8a14117c1d9257503', '[\"*\"]', NULL, '2022-12-30 01:55:06', '2022-12-30 01:55:06');
INSERT INTO `personal_access_tokens` VALUES (43, 'App\\Models\\User', 8, 'Laravel Password Grant Client', 'da96214ed60dd717a98fb96732a3468b956361980dbda870688ba4582b7a8e96', '[\"*\"]', NULL, '2022-12-30 01:58:36', '2022-12-30 01:58:36');
INSERT INTO `personal_access_tokens` VALUES (44, 'App\\Models\\User', 8, 'Laravel Password Grant Client', 'd761f1b3bbf0a6a80d990f6aa60aaaf9957d93dca03b6dd79e23b580cc569e0c', '[\"*\"]', NULL, '2022-12-30 01:59:08', '2022-12-30 01:59:08');
INSERT INTO `personal_access_tokens` VALUES (45, 'App\\Models\\User', 8, 'Laravel Password Grant Client', 'c5f0b3b991ddd271fcd26e470a8f419145e29d520fa7613329d7accc3eef9055', '[\"*\"]', NULL, '2022-12-30 02:00:03', '2022-12-30 02:00:03');
INSERT INTO `personal_access_tokens` VALUES (46, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '9a5f927b2b33fa20f93fa4f31922807012740537ddfb820d3f452e320e283c7c', '[\"*\"]', '2022-12-30 09:50:17', '2022-12-30 02:02:23', '2022-12-30 09:50:17');
INSERT INTO `personal_access_tokens` VALUES (47, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '59df7939425558b13da77ac2597f5b5081f20aa5e690656f672f5a5002dc5275', '[\"*\"]', '2022-12-30 02:48:23', '2022-12-30 02:42:51', '2022-12-30 02:48:23');
INSERT INTO `personal_access_tokens` VALUES (48, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '733365f98c9c60d973ab13686a2da4e24afed74327a72de3c8e2fb11bc55cb5c', '[\"*\"]', '2022-12-30 09:55:51', '2022-12-30 09:54:41', '2022-12-30 09:55:51');
INSERT INTO `personal_access_tokens` VALUES (49, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '6b4c7a2dd447e62750de126b5b8fdfaff9b285e63fb81dfbbead4063619912dd', '[\"*\"]', '2022-12-30 10:02:15', '2022-12-30 09:57:35', '2022-12-30 10:02:15');
INSERT INTO `personal_access_tokens` VALUES (50, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '5554de66d1795f5c776434e9acfe2316dbba47ae23023ad11d1399736a0dfb85', '[\"*\"]', '2022-12-30 10:03:33', '2022-12-30 10:02:41', '2022-12-30 10:03:33');
INSERT INTO `personal_access_tokens` VALUES (51, 'App\\Models\\User', 8, 'Laravel Password Grant Client', 'a2566513bd9940359b443fe018005749de12ff819bfacd02e8d3cf598e3bfc4b', '[\"*\"]', '2022-12-30 10:14:57', '2022-12-30 10:07:05', '2022-12-30 10:14:57');
INSERT INTO `personal_access_tokens` VALUES (52, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '3524d5124c91f7edc35de62ed46c28128d1628e7f7d0be0fd2e335126c26c46d', '[\"*\"]', '2022-12-30 10:18:14', '2022-12-30 10:16:00', '2022-12-30 10:18:14');
INSERT INTO `personal_access_tokens` VALUES (53, 'App\\Models\\User', 8, 'Laravel Password Grant Client', 'a1055fa5d75691b0646eccce837b2110bf06e1a63035d7fa64760b54ad8fde72', '[\"*\"]', '2022-12-30 10:21:23', '2022-12-30 10:18:44', '2022-12-30 10:21:23');
INSERT INTO `personal_access_tokens` VALUES (54, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '0428d7e29527b00da18aa2ab4a07a3b45790bf48c61b4acac8164d7342b7d14c', '[\"*\"]', '2023-01-04 03:58:21', '2022-12-30 10:22:05', '2023-01-04 03:58:21');
INSERT INTO `personal_access_tokens` VALUES (55, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '563a6f37597b192b88d16159b14cbc03ddf65c67ac15b2dde0d3d62109e9ac16', '[\"*\"]', '2022-12-30 13:03:37', '2022-12-30 12:59:03', '2022-12-30 13:03:37');
INSERT INTO `personal_access_tokens` VALUES (56, 'App\\Models\\User', 9, 'Laravel Password Grant Client', '6629d64b5b3a9639fd852dafa8a7c258ea72601a08b5d1c2992469a5e9596c7a', '[\"*\"]', '2023-01-09 06:59:38', '2023-01-04 07:23:02', '2023-01-09 06:59:38');
INSERT INTO `personal_access_tokens` VALUES (57, 'App\\Models\\User', 9, 'Laravel Password Grant Client', '797d5acf52faeb6bee091b9c6f772c1a22b6c32222fd3aeea6d067b034900ae8', '[\"*\"]', '2023-01-09 13:13:01', '2023-01-09 08:19:48', '2023-01-09 13:13:01');
INSERT INTO `personal_access_tokens` VALUES (58, 'App\\Models\\User', 9, 'Laravel Password Grant Client', '830341976be272291883014314f9e9482736b435851adc7b263b36a2ce1c17d1', '[\"*\"]', NULL, '2023-01-09 21:54:08', '2023-01-09 21:54:08');
INSERT INTO `personal_access_tokens` VALUES (59, 'App\\Models\\User', 9, 'Laravel Password Grant Client', 'b2011b24d01b8baba5ee6b4a1a43be4605227af263097606036eeb3f95142263', '[\"*\"]', '2023-01-10 09:25:16', '2023-01-09 22:18:32', '2023-01-10 09:25:16');
INSERT INTO `personal_access_tokens` VALUES (60, 'App\\Models\\User', 9, 'Laravel Password Grant Client', '04a0dc31eb754d22acbef55b9a06645ad75a3c54f7107098c133e4173d9e7064', '[\"*\"]', '2023-01-10 11:50:41', '2023-01-10 09:25:32', '2023-01-10 11:50:41');
INSERT INTO `personal_access_tokens` VALUES (61, 'App\\Models\\User', 8, 'Laravel Password Grant Client', '480576f00c62f92f53ae5ab512d40b4b7e6beb743b276a97596a6b2e98f59f3b', '[\"*\"]', NULL, '2023-01-10 12:16:45', '2023-01-10 12:16:45');
INSERT INTO `personal_access_tokens` VALUES (62, 'App\\Models\\User', 9, 'Laravel Password Grant Client', '689767ab4be5bc5d45db15fc18a8cac4ef2e9be1b65f4a0e35013f0927bb6ec7', '[\"*\"]', '2023-01-10 13:46:54', '2023-01-10 13:20:34', '2023-01-10 13:46:54');
INSERT INTO `personal_access_tokens` VALUES (63, 'App\\Models\\User', 1, 'Laravel Password Grant Client', 'f2ff309a50f9cc28e623f2fc011d19d982a917341d5db9725812e7dbd57158ae', '[\"*\"]', NULL, '2023-01-10 18:29:26', '2023-01-10 18:29:26');
INSERT INTO `personal_access_tokens` VALUES (64, 'App\\Models\\User', 1, 'Laravel Password Grant Client', '9acec925fd5cb1d819a90ac3a8eada14b4eef1a7a9605bcce9b83489ec05fdd5', '[\"*\"]', NULL, '2023-01-10 18:29:30', '2023-01-10 18:29:30');
INSERT INTO `personal_access_tokens` VALUES (65, 'App\\Models\\User', 1, 'Laravel Password Grant Client', '7288af966b1d21f46196e26c0cbb60cdc49d92703b85442646d9f36dc4189db7', '[\"*\"]', NULL, '2023-01-10 18:30:16', '2023-01-10 18:30:16');
INSERT INTO `personal_access_tokens` VALUES (66, 'App\\Models\\User', 1, 'Laravel Password Grant Client', 'ffc3043b5648ca5a102a2fae17455f5f718a60d393f41856a1b4ef04adf2aec0', '[\"*\"]', '2023-01-10 19:06:02', '2023-01-10 18:32:53', '2023-01-10 19:06:02');
INSERT INTO `personal_access_tokens` VALUES (67, 'App\\Models\\User', 2, 'Laravel Password Grant Client', 'b9555417b9b235a66cb6ac15c677c8ecd9a6a644c901a0922ca1c174574245b0', '[\"*\"]', NULL, '2023-01-10 19:14:17', '2023-01-10 19:14:17');
INSERT INTO `personal_access_tokens` VALUES (68, 'App\\Models\\User', 2, 'Laravel Password Grant Client', 'd033bf5261177e57dbe709f24bc23d8148c2c3485171555d09e53c2e46689f46', '[\"*\"]', NULL, '2023-01-10 19:14:26', '2023-01-10 19:14:26');
INSERT INTO `personal_access_tokens` VALUES (69, 'App\\Models\\User', 2, 'Laravel Password Grant Client', 'e66b27b4d40ddbce3d4a4cbdd2ee4a49ca4f4cd680c6a92cb124235777ddeb8e', '[\"*\"]', '2023-01-10 20:51:38', '2023-01-10 20:38:22', '2023-01-10 20:51:38');
INSERT INTO `personal_access_tokens` VALUES (70, 'App\\Models\\User', 2, 'Laravel Password Grant Client', '6b56df5466cc52a71f7dc203ee09b5ace86360b9dd3c3e1dee69a38ad7d628ef', '[\"*\"]', NULL, '2023-01-10 20:52:06', '2023-01-10 20:52:06');
INSERT INTO `personal_access_tokens` VALUES (71, 'App\\Models\\User', 2, 'Laravel Password Grant Client', '44ca83f172d82e87526e8f31eaa4bf95c4e0a39a7a529103431ce6beb44e511a', '[\"*\"]', NULL, '2023-01-10 20:52:43', '2023-01-10 20:52:43');
INSERT INTO `personal_access_tokens` VALUES (72, 'App\\Models\\User', 2, 'Laravel Password Grant Client', '0ef62c51ae7d0c4ec02a2f6282cbb9f4a7bd21b112b67258563cb7df8aa8a764', '[\"*\"]', '2023-01-10 23:39:38', '2023-01-10 20:52:53', '2023-01-10 23:39:38');
INSERT INTO `personal_access_tokens` VALUES (73, 'App\\Models\\User', 2, 'Laravel Password Grant Client', 'bd2775da7e4630e23d26cbbef7f497faab89884ca3cda5990f9022520b1f4c51', '[\"*\"]', '2023-01-16 08:55:32', '2023-01-11 05:05:20', '2023-01-16 08:55:32');
INSERT INTO `personal_access_tokens` VALUES (74, 'App\\Models\\User', 2, 'Laravel Password Grant Client', 'f8df969fcad7711f32634838f720365bf055ba86f612c127de3dcf11cb5fad8c', '[\"*\"]', '2023-01-11 07:34:48', '2023-01-11 05:05:26', '2023-01-11 07:34:48');
INSERT INTO `personal_access_tokens` VALUES (75, 'App\\Models\\User', 2, 'Laravel Password Grant Client', '179716cfa8ae7f62bf27c7b9c8a6bc2997d184f889af0172e6dbf2d9b5f27d66', '[\"*\"]', '2023-01-23 16:48:23', '2023-01-13 02:53:09', '2023-01-23 16:48:23');
INSERT INTO `personal_access_tokens` VALUES (76, 'App\\Models\\User', 2, 'Laravel Password Grant Client', '14c62a1f0d102299325c5ad9d29eecfb2e547bb1b919686924f09125fee2d1cd', '[\"*\"]', '2023-01-23 17:23:32', '2023-01-15 22:54:51', '2023-01-23 17:23:32');
INSERT INTO `personal_access_tokens` VALUES (77, 'App\\Models\\User', 2, 'Laravel Password Grant Client', 'aa7c17017b5a0609ccf70421dc0a6ddcb0c2a7594be36f31c56269f94f4f45a5', '[\"*\"]', '2023-01-16 09:01:27', '2023-01-16 08:58:42', '2023-01-16 09:01:27');
INSERT INTO `personal_access_tokens` VALUES (78, 'App\\Models\\User', 2, 'Laravel Password Grant Client', '1cc45524c037472305c43fb518e4b2e44b686880a87e8924f39191787c8f7fde', '[\"*\"]', '2023-01-19 09:53:02', '2023-01-16 09:03:51', '2023-01-19 09:53:02');
INSERT INTO `personal_access_tokens` VALUES (79, 'App\\Models\\User', 2, 'Laravel Password Grant Client', '3c6a66fa93844e290dac3354c82ab18897fcd6ca0a05b56074a461b776c6f9ac', '[\"*\"]', '2023-01-20 05:13:32', '2023-01-17 08:51:53', '2023-01-20 05:13:32');
INSERT INTO `personal_access_tokens` VALUES (80, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '8f80d454949a52af69588aaab4ae34eaa2d4f661c2a90e1d7b289a509c6f0d78', '[\"*\"]', NULL, '2023-01-23 17:29:11', '2023-01-23 17:29:11');
INSERT INTO `personal_access_tokens` VALUES (81, 'App\\Models\\User', 3, 'Laravel Password Grant Client', 'b596a7441acd6f2aae8e311ab08aef1a4de86708121c3ec2d0a33074ba3adc68', '[\"*\"]', '2023-02-05 09:52:38', '2023-01-23 17:29:19', '2023-02-05 09:52:38');
INSERT INTO `personal_access_tokens` VALUES (82, 'App\\Models\\User', 3, 'Laravel Password Grant Client', 'f3ae8069814174e2545628a85edc8cb9bc6de0c3e37e452f051f17d39c89286b', '[\"*\"]', '2023-01-23 22:47:15', '2023-01-23 17:31:46', '2023-01-23 22:47:15');
INSERT INTO `personal_access_tokens` VALUES (83, 'App\\Models\\User', 3, 'Laravel Password Grant Client', 'e5d90f4401ffcc56b720d8bbda4e82916f3c9d4a4b630b1695bf5da486f008ab', '[\"*\"]', '2023-01-29 02:26:07', '2023-01-26 10:25:07', '2023-01-29 02:26:07');
INSERT INTO `personal_access_tokens` VALUES (84, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '1ead91105c25e1bdf0ecd1e811e92eed1e6bab1f46468f5b12a391a40385d4a3', '[\"*\"]', '2023-01-29 02:28:34', '2023-01-29 02:24:39', '2023-01-29 02:28:34');
INSERT INTO `personal_access_tokens` VALUES (85, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '63d622fbc64d8827b601947c23e2e76ccc25b37f1b87c9785689470c1b349622', '[\"*\"]', '2023-01-30 01:51:33', '2023-01-30 01:51:11', '2023-01-30 01:51:33');
INSERT INTO `personal_access_tokens` VALUES (86, 'App\\Models\\User', 3, 'Laravel Password Grant Client', 'c99834cc1a469fa77b80f958022d6a8ce46d72843c99004a9745b91204453d09', '[\"*\"]', '2023-01-31 08:09:37', '2023-01-31 08:09:27', '2023-01-31 08:09:37');
INSERT INTO `personal_access_tokens` VALUES (87, 'App\\Models\\User', 4, 'Laravel Password Grant Client', '35ef9ebddeaa261c0ddafe898add072ea55705077555e423e2ec8db45e4af11b', '[\"*\"]', NULL, '2023-02-05 09:53:25', '2023-02-05 09:53:25');
INSERT INTO `personal_access_tokens` VALUES (88, 'App\\Models\\User', 3, 'Laravel Password Grant Client', 'bf92ca508dae419de3c901a6346cc88fd91bf2bf1725d4686772e1c3d2f254e4', '[\"*\"]', '2023-02-05 14:01:51', '2023-02-05 09:54:38', '2023-02-05 14:01:51');
INSERT INTO `personal_access_tokens` VALUES (89, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '326dda8fdb8cd5677969aa15f109ea2b21b70d6bf1eafd7dc3f29c8982d60955', '[\"*\"]', '2023-02-05 14:10:42', '2023-02-05 14:03:10', '2023-02-05 14:10:42');
INSERT INTO `personal_access_tokens` VALUES (90, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '13ccbc14e7c7d0650652aaea66176a4e28ec2e548ab6d0bc5843a25dc2f2dfa0', '[\"*\"]', '2023-02-05 14:11:44', '2023-02-05 14:11:42', '2023-02-05 14:11:44');
INSERT INTO `personal_access_tokens` VALUES (91, 'App\\Models\\User', 3, 'Laravel Password Grant Client', 'e76e3b48594403e0238b968af0b408ba89610181f7a26240636310f756bd1769', '[\"*\"]', '2023-02-05 14:14:59', '2023-02-05 14:14:57', '2023-02-05 14:14:59');
INSERT INTO `personal_access_tokens` VALUES (92, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '48c4f3de6603e67ce5bd62cf7f289fdc901740e510d34f4d8ad20cf1e11b093e', '[\"*\"]', '2023-02-05 14:15:45', '2023-02-05 14:15:43', '2023-02-05 14:15:45');
INSERT INTO `personal_access_tokens` VALUES (95, 'App\\Models\\User', 3, 'Laravel Password Grant Client', 'ac034d89ee42653b1a5f0920e4c1c533e8ebe670a4ab2161a5f8ffb67411182b', '[\"*\"]', '2023-02-05 15:35:13', '2023-02-05 14:43:20', '2023-02-05 15:35:13');
INSERT INTO `personal_access_tokens` VALUES (97, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '211f8e769e7022def6116273ea3d0cc8cb722c4fa7a96228661600622ec820f1', '[\"*\"]', '2023-02-06 00:34:55', '2023-02-05 15:40:05', '2023-02-06 00:34:55');
INSERT INTO `personal_access_tokens` VALUES (99, 'App\\Models\\User', 3, 'Laravel Password Grant Client', 'f171e738f3a7aecc7c35408eda67b46127aab109e4c292aab5af513c52268a7a', '[\"*\"]', '2023-02-08 02:25:41', '2023-02-08 02:22:25', '2023-02-08 02:25:41');
INSERT INTO `personal_access_tokens` VALUES (100, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '7bc190437338546c5c0001b18e765fa06d408e050ebc58d299a9c25d1a382bb6', '[\"*\"]', '2023-02-09 09:55:35', '2023-02-09 09:52:41', '2023-02-09 09:55:35');
INSERT INTO `personal_access_tokens` VALUES (101, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '8efb18c5036c4c2c32c4a2eb4eda13951195bff68abdbbf4d3afdae9573d0c78', '[\"*\"]', '2023-02-09 11:34:45', '2023-02-09 09:55:47', '2023-02-09 11:34:45');
INSERT INTO `personal_access_tokens` VALUES (102, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '7b114307d1c6ea0a487588110fcc7e407ea71d12a3c8f6b0e8cacb3caedb1881', '[\"*\"]', NULL, '2023-02-09 11:34:55', '2023-02-09 11:34:55');
INSERT INTO `personal_access_tokens` VALUES (103, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '9aa1c107ae44b0fdec87db8bd6aeff387c7afea9bb1174e143fa020d5f3b5524', '[\"*\"]', NULL, '2023-02-09 11:37:09', '2023-02-09 11:37:09');
INSERT INTO `personal_access_tokens` VALUES (104, 'App\\Models\\User', 3, 'Laravel Password Grant Client', 'e50f1759c5347928d96c53640cc49284069f77d4d2939e5d9801a3be1242e36c', '[\"*\"]', NULL, '2023-02-09 11:38:22', '2023-02-09 11:38:22');
INSERT INTO `personal_access_tokens` VALUES (105, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '68970ac73b99714615b2cbfd5467fcda2d78e9cfd6c837f2d681e89c91a7b5bd', '[\"*\"]', NULL, '2023-02-09 11:49:20', '2023-02-09 11:49:20');
INSERT INTO `personal_access_tokens` VALUES (106, 'App\\Models\\User', 3, 'Laravel Password Grant Client', '93fe5c82ef046dde52803b68255f799b62e63a60aa6fb212e38a93d941b43c5d', '[\"*\"]', '2023-02-09 11:53:13', '2023-02-09 11:50:34', '2023-02-09 11:53:13');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Admin', 'api', '2023-01-10 18:27:48', '2023-01-10 18:27:48');
INSERT INTO `roles` VALUES (2, 'User', 'api', '2023-01-10 18:27:48', '2023-01-10 18:27:48');

-- ----------------------------
-- Table structure for table_maps
-- ----------------------------
DROP TABLE IF EXISTS `table_maps`;
CREATE TABLE `table_maps`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of table_maps
-- ----------------------------
INSERT INTO `table_maps` VALUES (1, 'article', '2020-03-02 18:10:39', '2020-03-02 18:10:39');
INSERT INTO `table_maps` VALUES (2, 'budget', '2020-03-02 18:10:39', '2020-03-02 18:10:39');
INSERT INTO `table_maps` VALUES (3, 'company', '2020-03-02 18:10:39', '2020-03-02 18:10:39');
INSERT INTO `table_maps` VALUES (4, 'construction_menu', '2020-03-02 18:10:39', '2020-03-02 18:10:39');
INSERT INTO `table_maps` VALUES (5, 'menu', '2020-03-02 18:10:39', '2020-03-02 18:10:39');
INSERT INTO `table_maps` VALUES (6, 'payment', '2020-03-02 18:10:39', '2020-03-02 18:10:39');
INSERT INTO `table_maps` VALUES (7, 'seting', '2020-03-02 18:10:39', '2020-03-02 18:10:39');
INSERT INTO `table_maps` VALUES (8, 'transfer', '2020-03-02 18:10:39', '2020-03-02 18:10:39');
INSERT INTO `table_maps` VALUES (9, 'user', '2020-03-02 18:10:39', '2020-03-02 18:10:39');
INSERT INTO `table_maps` VALUES (10, 'construction', '2020-03-02 18:10:39', '2020-03-02 18:10:39');
INSERT INTO `table_maps` VALUES (11, 'excel_transfer', NULL, NULL);
INSERT INTO `table_maps` VALUES (12, 'excel_aggregates_all', NULL, NULL);
INSERT INTO `table_maps` VALUES (13, 'excel_aggregates_constructions', NULL, NULL);
INSERT INTO `table_maps` VALUES (14, 'excel_aggregates_constructions_month', NULL, NULL);
INSERT INTO `table_maps` VALUES (15, 'excel_zengin', NULL, NULL);

-- ----------------------------
-- Table structure for user_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_roles_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `user_roles_role_id_foreign`(`role_id`) USING BTREE,
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_roles
-- ----------------------------
INSERT INTO `user_roles` VALUES (2, 3, 1, NULL, NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp(0) NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `disabled` tinyint(4) NULL DEFAULT NULL,
  `disabled_at` timestamp(0) NULL DEFAULT NULL,
  `enabled_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (3, 'admin', 'admin', 'Admin00003', 'admin@gmail.com', NULL, NULL, '$2y$10$nA1Ma6wBDuSdi/MiR3sbTeY0sAQvz/zwnTr1I9d1wc/PKTtwvcVqq', 'ZUnNhJZjiY', 0, NULL, NULL, '2023-01-23 17:29:10', '2023-02-05 15:39:49', NULL);

SET FOREIGN_KEY_CHECKS = 1;
