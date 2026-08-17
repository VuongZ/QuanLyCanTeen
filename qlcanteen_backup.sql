-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 17, 2026 at 04:18 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qlcanteen`
--

-- --------------------------------------------------------

--
-- Table structure for table `bhxh_deduction_recovery`
--

DROP TABLE IF EXISTS `bhxh_deduction_recovery`;
CREATE TABLE IF NOT EXISTS `bhxh_deduction_recovery` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `source_contribution_id` int NOT NULL,
  `recovery_salary_id` int NOT NULL,
  `recovery_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `note` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_bhxh_recovery_contribution_salary` (`source_contribution_id`,`recovery_salary_id`),
  KEY `idx_bhxh_recovery_user` (`user_id`),
  KEY `idx_bhxh_recovery_salary` (`recovery_salary_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bhxh_employee_profile`
--

DROP TABLE IF EXISTS `bhxh_employee_profile`;
CREATE TABLE IF NOT EXISTS `bhxh_employee_profile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `social_insurance_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `insurance_salary_basis` decimal(15,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('PENDING','ACTIVE','SUSPENDED','STOPPED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `staff_confirmation_status` varchar(30) NOT NULL DEFAULT 'PENDING',
  `staff_confirmed_at` datetime DEFAULT NULL,
  `staff_confirmation_note` varchar(500) DEFAULT NULL,
  `note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_user_id` int DEFAULT NULL,
  `updated_by_user_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_bhxh_profile_user` (`user_id`),
  UNIQUE KEY `uq_bhxh_social_number` (`social_insurance_number`),
  KEY `idx_bhxh_profile_status` (`status`,`start_date`,`end_date`),
  KEY `idx_bhxh_profile_created_by` (`created_by_user_id`),
  KEY `idx_bhxh_profile_updated_by` (`updated_by_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bhxh_employee_profile`
--

INSERT INTO `bhxh_employee_profile` (`id`, `user_id`, `social_insurance_number`, `insurance_salary_basis`, `start_date`, `end_date`, `status`, `staff_confirmation_status`, `staff_confirmed_at`, `staff_confirmation_note`, `note`, `created_by_user_id`, `updated_by_user_id`, `created_at`, `updated_at`) VALUES
(1, 13, 'TEST0000000013', 5000000.00, '2026-02-08', NULL, 'ACTIVE', 'CONFIRMED', '2026-08-03 11:28:36', NULL, 'oke', 1, 1, '2026-08-02 05:45:13', '2026-08-03 06:41:19'),
(2, 2, 'TEST0000000015', 6000000.00, '2024-10-30', NULL, 'ACTIVE', 'CONFIRMED', '2026-08-03 11:31:33', NULL, NULL, 1, 1, '2026-08-03 04:31:00', '2026-08-03 06:41:19'),
(3, 14, 'TEST0000000014', 5000000.00, '2026-07-23', NULL, 'ACTIVE', 'CONFIRMED', '2026-08-06 03:57:15', NULL, NULL, 1, 1, '2026-08-05 19:48:40', '2026-08-05 20:57:34');

-- --------------------------------------------------------

--
-- Table structure for table `bhxh_monthly_contribution`
--

DROP TABLE IF EXISTS `bhxh_monthly_contribution`;
CREATE TABLE IF NOT EXISTS `bhxh_monthly_contribution` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `profile_id` int NOT NULL,
  `rate_config_id` int DEFAULT NULL,
  `month` tinyint NOT NULL,
  `year` smallint NOT NULL,
  `insurance_salary_basis` decimal(15,2) NOT NULL,
  `employee_rate` decimal(5,2) NOT NULL,
  `employer_rate` decimal(5,2) NOT NULL,
  `employee_amount` decimal(15,2) NOT NULL,
  `employee_deducted_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `employee_outstanding_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `deduction_status` enum('NONE','PARTIAL','FULL') NOT NULL DEFAULT 'NONE',
  `employer_amount` decimal(15,2) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `status` enum('DRAFT','CONFIRMED','PAID','CANCELLED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `confirmed_by_user_id` int DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `paid_by_user_id` int DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_bhxh_user_month_year` (`user_id`,`month`,`year`),
  KEY `idx_bhxh_contribution_period` (`year`,`month`,`status`),
  KEY `idx_bhxh_contribution_profile` (`profile_id`),
  KEY `idx_bhxh_contribution_rate` (`rate_config_id`),
  KEY `idx_bhxh_contribution_confirmed_by` (`confirmed_by_user_id`),
  KEY `idx_bhxh_contribution_paid_by` (`paid_by_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bhxh_monthly_contribution`
--

INSERT INTO `bhxh_monthly_contribution` (`id`, `user_id`, `profile_id`, `rate_config_id`, `month`, `year`, `insurance_salary_basis`, `employee_rate`, `employer_rate`, `employee_amount`, `employee_deducted_amount`, `employee_outstanding_amount`, `deduction_status`, `employer_amount`, `total_amount`, `status`, `confirmed_by_user_id`, `confirmed_at`, `paid_by_user_id`, `paid_at`, `note`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 1, 8, 2026, 6000000.00, 8.00, 17.50, 480000.00, 0.00, 480000.00, 'NONE', 1050000.00, 1530000.00, 'CONFIRMED', NULL, '2026-08-10 12:07:19', NULL, NULL, 'Đã khấu trừ 0 đồng trong kỳ 8/2026; doanh nghiệp ứng trước phần còn thiếu 480.000 đồng.', '2026-08-03 08:01:19', '2026-08-10 05:07:18'),
(2, 13, 1, 1, 8, 2026, 5000000.00, 8.00, 17.50, 400000.00, 400000.00, 0.00, 'FULL', 875000.00, 1275000.00, 'CONFIRMED', NULL, '2026-08-10 12:07:55', NULL, NULL, 'Đã khấu trừ đủ phần nhân viên đóng trong kỳ 8/2026.', '2026-08-03 08:01:19', '2026-08-10 05:07:55'),
(3, 2, 2, 1, 7, 2026, 6000000.00, 8.00, 17.50, 480000.00, 480000.00, 0.00, 'FULL', 1050000.00, 1530000.00, 'CONFIRMED', 1, '2026-08-03 15:03:13', NULL, NULL, NULL, '2026-08-03 08:03:06', '2026-08-05 21:26:13'),
(4, 13, 1, 1, 7, 2026, 5000000.00, 8.00, 17.50, 400000.00, 400000.00, 0.00, 'FULL', 875000.00, 1275000.00, 'CONFIRMED', 1, '2026-08-03 15:03:12', NULL, NULL, NULL, '2026-08-03 08:03:06', '2026-08-05 21:26:13'),
(5, 14, 3, 1, 8, 2026, 5000000.00, 8.00, 17.50, 400000.00, 400000.00, 0.00, 'FULL', 875000.00, 1275000.00, 'CONFIRMED', NULL, '2026-08-10 12:07:55', NULL, NULL, 'Đã khấu trừ đủ phần nhân viên đóng trong kỳ 8/2026.', '2026-08-10 05:07:55', '2026-08-10 05:07:55');

-- --------------------------------------------------------

--
-- Table structure for table `bhxh_rate_config`
--

DROP TABLE IF EXISTS `bhxh_rate_config`;
CREATE TABLE IF NOT EXISTS `bhxh_rate_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_rate` decimal(5,2) NOT NULL DEFAULT '8.00',
  `employer_rate` decimal(5,2) NOT NULL DEFAULT '17.50',
  `effective_from` date NOT NULL,
  `effective_to` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by_user_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_bhxh_rate_effective_from` (`effective_from`),
  KEY `idx_bhxh_rate_active` (`is_active`,`effective_from`,`effective_to`),
  KEY `idx_bhxh_rate_created_by` (`created_by_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bhxh_rate_config`
--

INSERT INTO `bhxh_rate_config` (`id`, `employee_rate`, `employer_rate`, `effective_from`, `effective_to`, `is_active`, `created_by_user_id`, `created_at`, `updated_at`) VALUES
(1, 8.00, 17.50, '2026-01-01', '2026-08-03', 0, NULL, '2026-08-02 02:55:36', '2026-08-03 04:18:53'),
(2, 8.00, 17.50, '2026-08-03', NULL, 1, 1, '2026-08-02 12:11:40', '2026-08-02 12:11:40');

-- --------------------------------------------------------

--
-- Table structure for table `ca_attendance`
--

DROP TABLE IF EXISTS `ca_attendance`;
CREATE TABLE IF NOT EXISTS `ca_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `schedule_id` int NOT NULL,
  `check_in_time` datetime DEFAULT NULL,
  `check_out_time` datetime DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Chưa chấm công',
  `salary_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_att_schedule` (`schedule_id`),
  KEY `fk_att_salary` (`salary_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_attendance`
--

INSERT INTO `ca_attendance` (`id`, `schedule_id`, `check_in_time`, `check_out_time`, `status`, `salary_id`) VALUES
(1, 2, '2026-05-06 15:14:56', '2026-05-06 15:15:01', 'Hoàn thành', NULL),
(2, 93, '2026-05-13 13:43:28', '2026-05-13 13:43:31', 'Hoàn thành', NULL),
(3, 98, '2026-05-13 13:43:44', '2026-05-13 13:43:46', 'Hoàn thành', NULL),
(4, 158, '2026-07-10 22:59:19', '2026-07-10 23:23:51', 'Đã CheckOut', 1),
(5, 147, '2026-07-15 17:32:49', '2026-07-16 14:49:54', 'Đã CheckOut', 1),
(6, 148, '2026-07-16 18:22:17', '2026-07-17 10:14:00', 'Đã CheckOut', 1),
(7, 149, '2026-07-18 01:56:31', '2026-07-18 23:59:00', 'AUTO_CHECKOUT_PENDING', NULL),
(8, 166, '2026-07-22 19:18:51', '2026-07-22 21:00:35', 'Đã CheckOut', 1),
(9, 167, '2026-07-28 10:43:54', '2026-07-28 16:59:00', 'Đã CheckOut', 1),
(10, 201, '2026-07-25 23:24:47', '2026-07-26 15:06:05', 'Đã CheckOut', 1),
(11, 199, '2026-07-27 14:02:26', '2026-07-27 16:03:26', 'Đã CheckOut', 1),
(12, 168, '2026-07-29 02:26:58', '2026-07-29 23:59:00', 'AUTO_CHECKOUT_PENDING', NULL),
(13, 243, '2026-08-03 09:24:21', '2026-08-03 10:00:00', 'AUTO_CHECKOUT_PENDING', NULL),
(14, 244, '2026-08-03 10:41:27', '2026-08-03 10:43:00', 'Đã CheckOut', 4),
(15, 245, '2026-08-03 11:12:56', '2026-08-03 16:30:00', 'Đã CheckOut', 4),
(16, 181, '2026-08-04 02:09:53', '2026-08-04 19:00:00', 'Đã CheckOut', 3),
(17, 180, '2026-08-04 02:10:21', '2026-08-04 19:00:00', 'Đã CheckOut', 5),
(18, 182, '2026-08-05 02:12:34', '2026-08-05 19:00:00', 'Đã CheckOut', 3),
(19, 183, '2026-08-05 02:12:38', '2026-08-05 16:00:00', 'Đã CheckOut', 5),
(20, 185, '2026-08-06 01:17:18', '2026-08-06 17:00:00', 'Đã CheckOut', 3),
(21, 184, '2026-08-06 01:17:22', '2026-08-06 17:00:00', 'Đã CheckOut', 5),
(22, 186, '2026-08-07 18:59:59', '2026-08-07 23:59:00', 'AUTO_CHECKOUT_PENDING', NULL),
(23, 187, '2026-08-07 19:00:03', '2026-08-07 23:59:00', 'AUTO_CHECKOUT_PENDING', NULL),
(24, 179, '2026-08-03 00:03:00', '2026-08-03 17:00:00', 'Đã CheckOut - Bổ sung', 3),
(25, 178, '2026-08-03 00:03:00', '2026-08-03 17:00:00', 'Đã CheckOut - Bổ sung', 5),
(26, 192, '2026-08-03 00:03:00', '2026-08-03 17:00:00', 'Đã CheckOut - Bổ sung', 6);

-- --------------------------------------------------------

--
-- Table structure for table `ca_branch_shift_config`
--

DROP TABLE IF EXISTS `ca_branch_shift_config`;
CREATE TABLE IF NOT EXISTS `ca_branch_shift_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shift_id` int NOT NULL,
  `day_of_week` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_staff` int DEFAULT '3',
  `row_version` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_config_shift` (`shift_id`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_branch_shift_config`
--

INSERT INTO `ca_branch_shift_config` (`id`, `shift_id`, `day_of_week`, `max_staff`, `row_version`) VALUES
(1, 1, 'Monday', 2, '2026-08-05 04:50:26'),
(2, 1, 'Tuesday', 3, '2026-05-23 06:38:17'),
(3, 2, 'Wednesday', 2, '2026-05-23 06:38:17'),
(4, 3, 'Wednesday', 3, '2026-05-23 06:38:17'),
(5, 1, 'Thursday', 3, '2026-05-23 06:38:17'),
(6, 2, 'Thursday', 2, '2026-05-23 06:38:17'),
(7, 3, 'Monday', 3, '2026-05-23 06:38:17'),
(8, 1, 'Wednesday', 3, '2026-05-23 06:38:17'),
(9, 2, 'Tuesday', 2, '2026-05-23 06:38:17'),
(10, 2, 'Monday', 2, '2026-05-23 06:38:17'),
(11, 3, 'Tuesday', 3, '2026-05-23 06:38:17'),
(12, 3, 'Thursday', 3, '2026-05-23 06:38:17'),
(13, 1, 'Friday', 3, '2026-05-23 06:38:17'),
(14, 2, 'Friday', 2, '2026-05-23 06:38:17'),
(15, 3, 'Friday', 3, '2026-05-23 06:38:17'),
(16, 1, 'Saturday', 0, '2026-05-23 06:38:17'),
(108, 17, 'Monday', 2, '2026-05-23 06:38:17'),
(109, 17, 'Tuesday', 2, '2026-05-23 06:38:17'),
(112, 17, 'Wednesday', 2, '2026-05-23 06:38:17'),
(114, 17, 'Thursday', 2, '2026-05-23 06:38:17'),
(115, 17, 'Friday', 2, '2026-05-23 06:38:17'),
(126, 18, 'Monday', 2, '2026-05-23 06:38:17'),
(127, 18, 'Tuesday', 2, '2026-05-23 06:38:17'),
(128, 18, 'Wednesday', 2, '2026-05-23 06:38:17'),
(129, 18, 'Thursday', 2, '2026-05-23 06:38:17'),
(130, 18, 'Friday', 2, '2026-05-23 06:38:17'),
(133, 22, 'Monday', 5, '2026-06-17 07:03:47'),
(134, 22, 'Tuesday', 5, '2026-06-17 07:03:47'),
(135, 22, 'Wednesday', 5, '2026-06-17 07:03:47'),
(136, 22, 'Thursday', 5, '2026-06-17 07:03:47'),
(137, 22, 'Friday', 5, '2026-06-17 07:03:47'),
(138, 22, 'Saturday', 5, '2026-06-17 07:03:47'),
(139, 22, 'Sunday', 5, '2026-06-17 07:03:47'),
(147, 1, 'Sunday', 0, '2026-06-24 17:07:28'),
(148, 2, 'Sunday', 0, '2026-06-24 17:07:34'),
(149, 2, 'Saturday', 0, '2026-06-24 17:07:34'),
(150, 3, 'Saturday', 0, '2026-06-24 17:07:40'),
(151, 3, 'Sunday', 0, '2026-06-24 17:07:40'),
(152, 24, 'Monday', 3, '2026-07-25 20:02:36'),
(153, 24, 'Tuesday', 3, '2026-07-25 20:02:36'),
(154, 24, 'Wednesday', 3, '2026-07-25 20:02:36'),
(155, 24, 'Thursday', 3, '2026-07-25 20:02:36'),
(156, 24, 'Friday', 3, '2026-07-25 20:02:36'),
(157, 24, 'Saturday', 3, '2026-07-25 20:02:36'),
(158, 24, 'Sunday', 3, '2026-07-25 20:02:36'),
(166, 26, 'Monday', 5, '2026-08-16 07:18:20'),
(167, 26, 'Tuesday', 5, '2026-08-16 07:18:20'),
(168, 26, 'Wednesday', 5, '2026-08-16 07:18:20'),
(169, 26, 'Thursday', 5, '2026-08-16 07:18:20'),
(170, 26, 'Friday', 5, '2026-08-16 07:18:20'),
(171, 26, 'Saturday', 5, '2026-08-16 07:18:20'),
(172, 26, 'Sunday', 5, '2026-08-16 07:18:20');

-- --------------------------------------------------------

--
-- Table structure for table `ca_checkout_request`
--

DROP TABLE IF EXISTS `ca_checkout_request`;
CREATE TABLE IF NOT EXISTS `ca_checkout_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attendance_id` int NOT NULL,
  `requested_by_user_id` int NOT NULL,
  `proposed_check_out_time` datetime NOT NULL,
  `requested_check_out_time` datetime DEFAULT NULL,
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AWAITING_EMPLOYEE',
  `reviewed_by_user_id` int DEFAULT NULL,
  `reject_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_checkout_request_attendance` (`attendance_id`),
  KEY `idx_checkout_request_status` (`status`,`updated_at`),
  KEY `idx_checkout_request_user` (`requested_by_user_id`),
  KEY `idx_checkout_request_reviewer` (`reviewed_by_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_checkout_request`
--

INSERT INTO `ca_checkout_request` (`id`, `attendance_id`, `requested_by_user_id`, `proposed_check_out_time`, `requested_check_out_time`, `reason`, `status`, `reviewed_by_user_id`, `reject_reason`, `created_at`, `updated_at`, `reviewed_at`) VALUES
(1, 6, 13, '2026-07-17 16:59:00', '2026-07-17 10:14:00', 'da cho em xin loi, em quen diem danh a : <<', 'APPROVED', 6, NULL, '2026-07-20 23:03:12', '2026-07-25 23:26:43', '2026-07-25 23:26:43'),
(2, 7, 13, '2026-07-18 23:59:00', '2026-07-18 18:00:00', 'da em quen diem danh a', 'REJECTED', 6, 'qua thang roi em', '2026-07-20 23:03:12', '2026-08-03 19:14:20', '2026-08-03 19:14:20'),
(3, 9, 13, '2026-07-28 16:59:00', '2026-07-28 16:59:00', 'sori chi', 'APPROVED', 6, NULL, '2026-07-28 18:16:23', '2026-07-28 18:17:51', '2026-07-28 18:17:51'),
(4, 12, 13, '2026-07-29 23:59:00', '2026-07-29 19:00:00', 'da em xin ve som a', 'REJECTED', 6, 'qua thang roi em', '2026-07-31 19:45:49', '2026-08-03 19:14:15', '2026-08-03 19:14:15'),
(5, 13, 2, '2026-08-03 03:00:00', NULL, NULL, 'AWAITING_EMPLOYEE', NULL, NULL, '2026-08-03 03:36:20', '2026-08-03 03:36:20', NULL),
(6, 15, 2, '2026-08-03 16:30:00', '2026-08-03 16:30:00', 'sdas', 'APPROVED', 4, NULL, '2026-08-03 19:06:28', '2026-08-10 05:03:17', '2026-08-10 05:03:17'),
(7, 17, 14, '2026-08-04 23:59:00', '2026-08-04 19:00:00', 'em xin loii', 'APPROVED', 6, NULL, '2026-08-04 19:09:23', '2026-08-04 19:11:23', '2026-08-04 19:11:23'),
(8, 16, 13, '2026-08-04 23:59:00', '2026-08-04 19:00:00', 'em sr', 'APPROVED', 6, NULL, '2026-08-04 19:09:23', '2026-08-04 19:11:24', '2026-08-04 19:11:24'),
(9, 18, 13, '2026-08-05 23:59:00', '2026-08-05 19:00:00', 'sri', 'APPROVED', 6, NULL, '2026-08-05 18:20:19', '2026-08-05 19:06:55', '2026-08-05 19:06:55'),
(10, 19, 14, '2026-08-05 23:59:00', '2026-08-05 16:00:00', 'sỏi', 'APPROVED', 6, NULL, '2026-08-05 18:20:19', '2026-08-05 19:06:56', '2026-08-05 19:06:56'),
(11, 21, 14, '2026-08-06 23:59:00', '2026-08-06 17:00:00', 'sryy', 'APPROVED', 6, NULL, '2026-08-07 12:03:26', '2026-08-07 14:05:15', '2026-08-07 14:05:15'),
(12, 20, 13, '2026-08-06 23:59:00', '2026-08-06 17:00:00', 'sryy', 'APPROVED', 6, NULL, '2026-08-07 12:03:26', '2026-08-07 14:05:15', '2026-08-07 14:05:15'),
(13, 22, 13, '2026-08-07 23:59:00', NULL, NULL, 'AWAITING_EMPLOYEE', NULL, NULL, '2026-08-07 18:33:34', '2026-08-07 18:33:34', NULL),
(14, 23, 14, '2026-08-07 23:59:00', NULL, NULL, 'AWAITING_EMPLOYEE', NULL, NULL, '2026-08-07 18:33:34', '2026-08-07 18:33:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ca_checkout_request_history`
--

DROP TABLE IF EXISTS `ca_checkout_request_history`;
CREATE TABLE IF NOT EXISTS `ca_checkout_request_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `request_id` int NOT NULL,
  `actor_user_id` int DEFAULT NULL,
  `action` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_checkout_history_request` (`request_id`),
  KEY `idx_checkout_history_actor` (`actor_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_checkout_request_history`
--

INSERT INTO `ca_checkout_request_history` (`id`, `request_id`, `actor_user_id`, `action`, `detail`, `created_at`) VALUES
(1, 1, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-07-20 23:03:12'),
(2, 2, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-07-20 23:03:12'),
(3, 1, 13, 'SUBMITTED', 'Giờ đề nghị: 2026-07-17T10:14:00.0000000. Lý do: da cho em xin loi, em quen diem danh a : <<', '2026-07-25 23:26:26'),
(4, 1, 6, 'APPROVED', 'Giờ checkout được duyệt: 2026-07-17T10:14:00.0000000', '2026-07-25 23:26:43'),
(5, 3, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-07-28 18:16:23'),
(6, 3, 13, 'SUBMITTED', 'Giờ đề nghị: 2026-07-28T16:59:00.0000000. Lý do: sori chi', '2026-07-28 18:17:27'),
(7, 3, 6, 'APPROVED', 'Giờ checkout được duyệt: 2026-07-28T16:59:00.0000000', '2026-07-28 18:17:51'),
(8, 4, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-07-31 19:45:49'),
(9, 5, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-08-03 03:36:20'),
(10, 6, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-08-03 19:06:28'),
(11, 4, 13, 'SUBMITTED', 'Giờ đề nghị: 2026-07-29T19:00:00.0000000. Lý do: da em xin ve som a', '2026-08-03 19:13:24'),
(12, 2, 13, 'SUBMITTED', 'Giờ đề nghị: 2026-07-18T18:00:00.0000000. Lý do: da em quen diem danh a', '2026-08-03 19:13:40'),
(13, 4, 6, 'REJECTED', 'qua thang roi em', '2026-08-03 19:14:15'),
(14, 2, 6, 'REJECTED', 'qua thang roi em', '2026-08-03 19:14:20'),
(15, 7, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-08-04 19:09:23'),
(16, 8, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-08-04 19:09:23'),
(17, 7, 14, 'SUBMITTED', 'Giờ đề nghị: 2026-08-04T19:00:00.0000000. Lý do: em xin loii', '2026-08-04 19:10:47'),
(18, 8, 13, 'SUBMITTED', 'Giờ đề nghị: 2026-08-04T19:00:00.0000000. Lý do: em sr', '2026-08-04 19:11:02'),
(19, 7, 6, 'APPROVED', 'Giờ checkout được duyệt: 2026-08-04T19:00:00.0000000', '2026-08-04 19:11:23'),
(20, 8, 6, 'APPROVED', 'Giờ checkout được duyệt: 2026-08-04T19:00:00.0000000', '2026-08-04 19:11:24'),
(21, 9, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-08-05 18:20:19'),
(22, 10, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-08-05 18:20:19'),
(23, 9, 13, 'SUBMITTED', 'Giờ đề nghị: 2026-08-05T19:00:00.0000000. Lý do: sri', '2026-08-05 19:06:29'),
(24, 10, 14, 'SUBMITTED', 'Giờ đề nghị: 2026-08-05T16:00:00.0000000. Lý do: sỏi', '2026-08-05 19:06:48'),
(25, 9, 6, 'APPROVED', 'Giờ checkout được duyệt: 2026-08-05T19:00:00.0000000', '2026-08-05 19:06:55'),
(26, 10, 6, 'APPROVED', 'Giờ checkout được duyệt: 2026-08-05T16:00:00.0000000', '2026-08-05 19:06:56'),
(27, 11, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-08-07 12:03:26'),
(28, 12, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-08-07 12:03:26'),
(29, 12, 13, 'SUBMITTED', 'Giờ đề nghị: 2026-08-06T17:00:00.0000000. Lý do: sryy', '2026-08-07 14:04:44'),
(30, 11, 14, 'SUBMITTED', 'Giờ đề nghị: 2026-08-06T17:00:00.0000000. Lý do: sryy', '2026-08-07 14:04:57'),
(31, 12, 6, 'APPROVED', 'Giờ checkout được duyệt: 2026-08-06T17:00:00.0000000', '2026-08-07 14:05:15'),
(32, 11, 6, 'APPROVED', 'Giờ checkout được duyệt: 2026-08-06T17:00:00.0000000', '2026-08-07 14:05:15'),
(33, 13, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-08-07 18:33:34'),
(34, 14, NULL, 'AUTO_CREATED', 'Checkout tạm được tạo theo giờ kết thúc ca.', '2026-08-07 18:33:34'),
(35, 6, 2, 'SUBMITTED', 'Giờ đề nghị: 2026-08-03T16:30:00.0000000. Lý do: sdas', '2026-08-10 05:02:04'),
(36, 6, 4, 'APPROVED', 'Giờ checkout được duyệt: 2026-08-03T16:30:00.0000000', '2026-08-10 05:03:17');

-- --------------------------------------------------------

--
-- Table structure for table `ca_final_schedule`
--

DROP TABLE IF EXISTS `ca_final_schedule`;
CREATE TABLE IF NOT EXISTS `ca_final_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `period_id` int DEFAULT NULL,
  `source_registration_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `shift_id` int NOT NULL,
  `work_date` date NOT NULL,
  `status` enum('DRAFT','PUBLISHED','LEAVE_APPROVED','ABSENT','CANCELLED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `assignment_type` enum('NORMAL','EMERGENCY_REPLACEMENT') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `pay_multiplier` decimal(5,2) NOT NULL DEFAULT '1.00',
  `replaces_schedule_id` int DEFAULT NULL,
  `absence_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `absence_marked_by_user_id` int DEFAULT NULL,
  `absence_marked_at` datetime DEFAULT NULL,
  `assigned_by_user_id` int DEFAULT NULL,
  `assigned_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_final_user_shift_date` (`user_id`,`shift_id`,`work_date`),
  UNIQUE KEY `uq_final_source_registration` (`source_registration_id`),
  UNIQUE KEY `uq_final_replaces_schedule` (`replaces_schedule_id`),
  KEY `fk_final_user` (`user_id`),
  KEY `fk_final_shift` (`shift_id`),
  KEY `idx_final_period` (`period_id`),
  KEY `idx_final_source_registration` (`source_registration_id`),
  KEY `idx_final_replaces_schedule` (`replaces_schedule_id`),
  KEY `idx_final_assignment` (`assignment_type`,`status`),
  KEY `idx_final_absence_manager` (`absence_marked_by_user_id`),
  KEY `idx_final_assigned_manager` (`assigned_by_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_final_schedule`
--

INSERT INTO `ca_final_schedule` (`id`, `period_id`, `source_registration_id`, `user_id`, `shift_id`, `work_date`, `status`, `assignment_type`, `pay_multiplier`, `replaces_schedule_id`, `absence_reason`, `absence_marked_by_user_id`, `absence_marked_at`, `assigned_by_user_id`, `assigned_at`) VALUES
(1, 1, NULL, 10, 17, '2026-05-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, NULL, 8, 17, '2026-05-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, NULL, 10, 18, '2026-05-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, NULL, 8, 18, '2026-05-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, NULL, 10, 17, '2026-05-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, NULL, 8, 17, '2026-05-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 1, NULL, 10, 18, '2026-05-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 1, NULL, 8, 18, '2026-05-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 1, NULL, 10, 17, '2026-05-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 1, NULL, 8, 17, '2026-05-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 1, NULL, 10, 18, '2026-05-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 1, NULL, 8, 18, '2026-05-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 1, NULL, 10, 17, '2026-05-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 1, NULL, 8, 17, '2026-05-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 1, NULL, 10, 18, '2026-05-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 1, NULL, 8, 18, '2026-05-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 1, NULL, 10, 17, '2026-05-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 1, NULL, 8, 17, '2026-05-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 1, NULL, 10, 18, '2026-05-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 1, NULL, 8, 18, '2026-05-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 2, NULL, 10, 17, '2026-05-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 2, NULL, 8, 17, '2026-05-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 2, NULL, 10, 18, '2026-05-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 2, NULL, 8, 18, '2026-05-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 2, NULL, 10, 17, '2026-05-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 2, NULL, 8, 17, '2026-05-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 2, NULL, 10, 18, '2026-05-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 2, NULL, 8, 18, '2026-05-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 2, NULL, 10, 17, '2026-05-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 2, NULL, 8, 17, '2026-05-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 2, NULL, 10, 18, '2026-05-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 2, NULL, 8, 18, '2026-05-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 2, NULL, 10, 17, '2026-05-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(34, 2, NULL, 8, 17, '2026-05-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(35, 2, NULL, 10, 18, '2026-05-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(36, 2, NULL, 8, 18, '2026-05-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(37, 2, NULL, 10, 17, '2026-05-22', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(38, 2, NULL, 8, 17, '2026-05-22', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(39, 2, NULL, 10, 18, '2026-05-22', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(40, 2, NULL, 8, 18, '2026-05-22', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 3, NULL, 10, 17, '2026-05-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 3, NULL, 8, 17, '2026-05-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 3, NULL, 10, 18, '2026-05-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 3, NULL, 8, 18, '2026-05-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(45, 3, NULL, 10, 17, '2026-05-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(46, 3, NULL, 8, 17, '2026-05-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(47, 3, NULL, 10, 18, '2026-05-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(48, 3, NULL, 8, 18, '2026-05-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 3, NULL, 10, 17, '2026-05-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 3, NULL, 8, 17, '2026-05-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(51, 3, NULL, 10, 18, '2026-05-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(52, 3, NULL, 8, 18, '2026-05-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 3, NULL, 10, 17, '2026-05-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(54, 3, NULL, 8, 17, '2026-05-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(55, 3, NULL, 10, 18, '2026-05-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 3, NULL, 8, 18, '2026-05-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(57, 3, NULL, 10, 17, '2026-05-08', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(58, 3, NULL, 8, 17, '2026-05-08', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(59, 3, NULL, 10, 18, '2026-05-08', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(60, 3, NULL, 8, 18, '2026-05-08', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(92, 5, NULL, 10, 17, '2026-05-25', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(93, 5, NULL, 8, 17, '2026-05-25', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(94, 5, NULL, 10, 18, '2026-05-25', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(97, 5, NULL, 10, 17, '2026-05-26', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(98, 5, NULL, 8, 17, '2026-05-26', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(99, 5, NULL, 10, 18, '2026-05-26', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(100, 5, NULL, 10, 17, '2026-05-27', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(101, 5, NULL, 8, 17, '2026-05-27', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(102, 5, NULL, 10, 18, '2026-05-27', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(103, 5, NULL, 10, 17, '2026-05-28', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(104, 5, NULL, 8, 17, '2026-05-28', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(105, 5, NULL, 10, 18, '2026-05-28', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(106, 5, NULL, 10, 17, '2026-05-29', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(107, 5, NULL, 10, 18, '2026-05-29', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(108, 6, NULL, 10, 17, '2026-06-08', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(109, 6, NULL, 10, 18, '2026-06-08', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(110, 6, NULL, 8, 18, '2026-06-08', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(112, 6, NULL, 10, 17, '2026-06-09', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(113, 6, NULL, 8, 17, '2026-06-09', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(114, 6, NULL, 10, 18, '2026-06-09', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(115, 6, NULL, 8, 18, '2026-06-09', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(116, 6, NULL, 10, 17, '2026-06-10', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(117, 6, NULL, 10, 18, '2026-06-10', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(118, 6, NULL, 10, 17, '2026-06-11', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(119, 6, NULL, 8, 17, '2026-06-11', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(120, 6, NULL, 10, 18, '2026-06-11', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(121, 6, NULL, 8, 18, '2026-06-11', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(122, 6, NULL, 10, 17, '2026-06-12', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(123, 6, NULL, 10, 18, '2026-06-12', 'DRAFT', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(124, 10, 109, 2, 2, '2026-07-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(125, 10, 110, 2, 2, '2026-07-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(126, 10, 111, 2, 2, '2026-07-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(127, 10, 112, 2, 2, '2026-07-16', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(128, 10, 108, 2, 2, '2026-07-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(129, 10, NULL, 4, 1, '2026-07-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(130, 10, NULL, 4, 2, '2026-07-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(131, 10, NULL, 4, 3, '2026-07-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(132, 10, NULL, 4, 1, '2026-07-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(133, 10, NULL, 4, 2, '2026-07-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(134, 10, NULL, 4, 3, '2026-07-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(135, 10, NULL, 4, 1, '2026-07-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(136, 10, NULL, 4, 2, '2026-07-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(137, 10, NULL, 4, 3, '2026-07-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(138, 10, NULL, 4, 1, '2026-07-16', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(139, 10, NULL, 4, 2, '2026-07-16', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(140, 10, NULL, 4, 3, '2026-07-16', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(141, 10, NULL, 4, 1, '2026-07-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(142, 10, NULL, 4, 2, '2026-07-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(143, 10, NULL, 4, 3, '2026-07-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(144, 11, 118, 13, 24, '2026-07-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(145, 11, 119, 13, 24, '2026-07-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(146, 11, 120, 13, 24, '2026-07-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(147, 11, 121, 13, 24, '2026-07-16', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(148, 11, 122, 13, 24, '2026-07-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(149, 11, 123, 13, 24, '2026-07-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(150, 11, 124, 13, 24, '2026-07-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(151, NULL, NULL, 6, 24, '2026-07-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(152, 11, NULL, 6, 24, '2026-07-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(153, 11, NULL, 6, 24, '2026-07-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(154, 11, NULL, 6, 24, '2026-07-16', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(155, 11, NULL, 6, 24, '2026-07-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(156, 11, NULL, 6, 24, '2026-07-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(157, 11, NULL, 6, 24, '2026-07-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(158, NULL, NULL, 13, 24, '2026-07-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(159, 12, NULL, 6, 24, '2026-07-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(160, 12, NULL, 6, 24, '2026-07-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(161, 12, NULL, 6, 24, '2026-07-22', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(162, 12, NULL, 6, 24, '2026-07-23', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(163, 12, NULL, 6, 24, '2026-07-24', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(164, 12, NULL, 6, 24, '2026-07-25', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(165, 12, NULL, 6, 24, '2026-07-26', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(166, 12, 146, 13, 24, '2026-07-23', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(167, 15, 147, 13, 24, '2026-07-28', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(168, 15, 148, 13, 24, '2026-07-29', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(169, 15, 149, 13, 24, '2026-07-30', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(170, 15, 150, 13, 24, '2026-07-31', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(171, 15, NULL, 6, 24, '2026-07-27', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(172, 15, NULL, 6, 24, '2026-07-28', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(173, 15, NULL, 6, 24, '2026-07-29', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(174, 15, NULL, 6, 24, '2026-07-30', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(175, 15, NULL, 6, 24, '2026-07-31', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(176, 15, NULL, 6, 24, '2026-08-01', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(177, 15, NULL, 6, 24, '2026-08-02', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(178, 16, 179, 14, 24, '2026-08-03', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(179, 16, 188, 13, 24, '2026-08-03', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(180, 16, 180, 14, 24, '2026-08-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(181, 16, 186, 13, 24, '2026-08-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(182, 16, 174, 13, 24, '2026-08-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(183, 16, 181, 14, 24, '2026-08-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(184, 16, 182, 14, 24, '2026-08-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(185, 16, 187, 13, 24, '2026-08-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(186, 16, 176, 13, 24, '2026-08-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(187, 16, 183, 14, 24, '2026-08-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(188, 16, 177, 13, 24, '2026-08-08', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(189, 16, 184, 14, 24, '2026-08-08', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(190, 16, 178, 13, 24, '2026-08-09', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(191, 16, 185, 14, 24, '2026-08-09', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(192, 16, NULL, 6, 24, '2026-08-03', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(193, 16, NULL, 6, 24, '2026-08-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(194, 16, NULL, 6, 24, '2026-08-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(195, 16, NULL, 6, 24, '2026-08-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(196, 16, NULL, 6, 24, '2026-08-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(197, 16, NULL, 6, 24, '2026-08-08', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(198, 16, NULL, 6, 24, '2026-08-09', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(199, 15, 189, 13, 24, '2026-07-27', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(200, 15, 190, 13, 24, '2026-08-01', 'ABSENT', 'NORMAL', 1.00, NULL, 'Goi khong nghe may', 6, '2026-08-01 04:00:29', NULL, NULL),
(201, 12, 191, 13, 24, '2026-07-26', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(202, 19, 207, 13, 24, '2026-08-10', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(203, 19, 208, 13, 24, '2026-08-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(204, 19, 209, 13, 24, '2026-08-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(205, 19, 210, 13, 24, '2026-08-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(206, 19, NULL, 6, 24, '2026-08-10', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(207, 19, NULL, 6, 24, '2026-08-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(208, 19, NULL, 6, 24, '2026-08-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(209, 19, NULL, 6, 24, '2026-08-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(210, 19, NULL, 6, 24, '2026-08-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(211, 19, NULL, 6, 24, '2026-08-15', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(212, 19, NULL, 6, 24, '2026-08-16', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(213, 21, NULL, 4, 1, '2026-08-10', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(214, 21, NULL, 2, 1, '2026-08-10', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(215, 21, NULL, 4, 2, '2026-08-10', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(216, 21, NULL, 2, 2, '2026-08-10', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(217, 21, NULL, 4, 3, '2026-08-10', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(218, 21, NULL, 2, 3, '2026-08-10', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(219, 21, NULL, 4, 1, '2026-08-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(220, 21, NULL, 2, 1, '2026-08-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(221, 21, NULL, 4, 2, '2026-08-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(222, 21, NULL, 2, 2, '2026-08-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(223, 21, NULL, 4, 3, '2026-08-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(224, 21, NULL, 2, 3, '2026-08-11', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(225, 21, NULL, 4, 1, '2026-08-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(226, 21, NULL, 2, 1, '2026-08-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(227, 21, NULL, 4, 2, '2026-08-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(228, 21, NULL, 2, 2, '2026-08-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(229, 21, NULL, 4, 3, '2026-08-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(230, 21, NULL, 2, 3, '2026-08-12', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(231, 21, NULL, 4, 1, '2026-08-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(232, 21, NULL, 2, 1, '2026-08-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(233, 21, NULL, 4, 2, '2026-08-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(234, 21, NULL, 2, 2, '2026-08-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(235, 21, NULL, 4, 3, '2026-08-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(236, 21, NULL, 2, 3, '2026-08-13', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(237, 21, NULL, 4, 1, '2026-08-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(238, 21, NULL, 2, 1, '2026-08-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(239, 21, NULL, 4, 2, '2026-08-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(240, 21, NULL, 2, 2, '2026-08-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(241, 21, NULL, 4, 3, '2026-08-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(242, 21, NULL, 2, 3, '2026-08-14', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(243, 18, NULL, 2, 1, '2026-08-03', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(244, 18, NULL, 2, 2, '2026-08-03', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(245, 18, NULL, 2, 3, '2026-08-03', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(246, 18, NULL, 2, 1, '2026-08-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(247, 18, NULL, 2, 2, '2026-08-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(248, 18, NULL, 2, 3, '2026-08-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(249, 18, NULL, 2, 1, '2026-08-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(250, 18, NULL, 2, 2, '2026-08-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(251, 18, NULL, 2, 3, '2026-08-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(252, 18, NULL, 2, 1, '2026-08-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(253, 18, NULL, 2, 2, '2026-08-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(254, 18, NULL, 2, 3, '2026-08-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(255, 18, NULL, 2, 1, '2026-08-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(256, 18, NULL, 2, 2, '2026-08-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(257, 18, NULL, 2, 3, '2026-08-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(258, 18, NULL, 4, 1, '2026-08-03', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(259, 18, NULL, 4, 2, '2026-08-03', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(260, 18, NULL, 4, 3, '2026-08-03', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(261, 18, NULL, 4, 1, '2026-08-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(262, 18, NULL, 4, 2, '2026-08-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(263, 18, NULL, 4, 3, '2026-08-04', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(264, 18, NULL, 4, 1, '2026-08-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(265, 18, NULL, 4, 2, '2026-08-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(266, 18, NULL, 4, 3, '2026-08-05', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(267, 18, NULL, 4, 1, '2026-08-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(268, 18, NULL, 4, 2, '2026-08-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(269, 18, NULL, 4, 3, '2026-08-06', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(270, 18, NULL, 4, 1, '2026-08-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(271, 18, NULL, 4, 2, '2026-08-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(272, 18, NULL, 4, 3, '2026-08-07', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(273, 20, NULL, 13, 24, '2026-08-24', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(274, 20, NULL, 13, 24, '2026-08-25', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(275, 20, NULL, 13, 24, '2026-08-26', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(276, 20, NULL, 13, 24, '2026-08-27', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(277, 20, NULL, 13, 24, '2026-08-28', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(278, 20, NULL, 13, 24, '2026-08-29', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(279, 20, NULL, 13, 24, '2026-08-30', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(280, 20, NULL, 6, 24, '2026-08-24', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(281, 20, NULL, 6, 24, '2026-08-25', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(282, 20, NULL, 6, 24, '2026-08-26', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(283, 20, NULL, 6, 24, '2026-08-27', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(284, 20, NULL, 6, 24, '2026-08-28', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(285, 20, NULL, 6, 24, '2026-08-29', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(286, 20, NULL, 6, 24, '2026-08-30', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(287, 23, NULL, 4, 1, '2026-08-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(288, 23, NULL, 2, 1, '2026-08-17', 'LEAVE_APPROVED', 'NORMAL', 1.00, NULL, 'oke', 4, '2026-08-05 12:01:17', NULL, NULL),
(289, 23, NULL, 4, 2, '2026-08-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(290, 23, NULL, 2, 2, '2026-08-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(291, 23, NULL, 4, 3, '2026-08-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(292, 23, NULL, 2, 3, '2026-08-17', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(293, 23, NULL, 4, 1, '2026-08-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(294, 23, NULL, 2, 1, '2026-08-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(295, 23, NULL, 4, 2, '2026-08-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(296, 23, NULL, 2, 2, '2026-08-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(297, 23, NULL, 4, 3, '2026-08-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(298, 23, NULL, 2, 3, '2026-08-18', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(299, 23, NULL, 4, 1, '2026-08-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(300, 23, NULL, 2, 1, '2026-08-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(301, 23, NULL, 4, 2, '2026-08-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(302, 23, NULL, 2, 2, '2026-08-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(303, 23, NULL, 4, 3, '2026-08-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(304, 23, NULL, 2, 3, '2026-08-19', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(305, 23, NULL, 4, 1, '2026-08-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(306, 23, NULL, 2, 1, '2026-08-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(307, 23, NULL, 4, 2, '2026-08-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(308, 23, NULL, 2, 2, '2026-08-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(309, 23, NULL, 4, 3, '2026-08-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(310, 23, NULL, 2, 3, '2026-08-20', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(311, 23, NULL, 4, 1, '2026-08-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(312, 23, NULL, 2, 1, '2026-08-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(313, 23, NULL, 4, 2, '2026-08-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(314, 23, NULL, 2, 2, '2026-08-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(315, 23, NULL, 4, 3, '2026-08-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(316, 23, NULL, 2, 3, '2026-08-21', 'PUBLISHED', 'NORMAL', 1.00, NULL, NULL, NULL, NULL, NULL, NULL),
(317, 23, 228, 7, 1, '2026-08-17', 'PUBLISHED', 'EMERGENCY_REPLACEMENT', 1.50, 288, NULL, NULL, NULL, 4, '2026-08-05 12:01:22');

-- --------------------------------------------------------

--
-- Table structure for table `ca_schedule_period`
--

DROP TABLE IF EXISTS `ca_schedule_period`;
CREATE TABLE IF NOT EXISTS `ca_schedule_period` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('OPEN','DRAFT','PUBLISHED','REVIEWING','CLOSED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OPEN',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_schedule_period`
--

INSERT INTO `ca_schedule_period` (`id`, `branch_id`, `start_date`, `end_date`, `status`, `created_at`) VALUES
(1, 3, '2026-05-11', '2026-05-17', 'PUBLISHED', '2026-05-06 08:12:55'),
(2, 3, '2026-05-18', '2026-05-24', 'PUBLISHED', '2026-05-07 12:49:39'),
(3, 3, '2026-05-04', '2026-05-10', 'PUBLISHED', '2026-05-07 12:57:12'),
(4, 1, '2026-05-18', '2026-05-24', 'CLOSED', '2026-05-11 04:18:27'),
(5, 3, '2026-05-25', '2026-05-30', 'PUBLISHED', '2026-05-13 05:42:18'),
(6, 3, '2026-06-08', '2026-06-13', 'DRAFT', '2026-05-19 12:21:08'),
(7, 4, '2026-06-22', '2026-06-28', 'CLOSED', '2026-06-17 07:25:12'),
(8, 1, '2026-06-22', '2026-06-28', 'PUBLISHED', '2026-06-20 05:25:28'),
(9, 1, '2026-06-29', '2026-07-05', 'CLOSED', '2026-06-27 14:20:57'),
(10, 1, '2026-07-13', '2026-07-19', 'PUBLISHED', '2026-07-04 18:55:19'),
(11, 2, '2026-07-13', '2026-07-19', 'PUBLISHED', '2026-07-10 19:39:00'),
(12, 2, '2026-07-20', '2026-07-26', 'PUBLISHED', '2026-07-11 22:00:26'),
(14, 1, '2026-07-27', '2026-08-02', 'CLOSED', '2026-07-22 00:01:27'),
(15, 2, '2026-07-27', '2026-08-02', 'PUBLISHED', '2026-07-22 00:02:55'),
(16, 2, '2026-08-03', '2026-08-09', 'PUBLISHED', '2026-07-25 20:04:01'),
(18, 1, '2026-08-03', '2026-08-09', 'PUBLISHED', '2026-07-28 23:39:25'),
(19, 2, '2026-08-10', '2026-08-16', 'PUBLISHED', '2026-07-29 05:56:13'),
(20, 2, '2026-08-24', '2026-08-30', 'PUBLISHED', '2026-07-31 22:15:32'),
(21, 1, '2026-08-10', '2026-08-16', 'PUBLISHED', '2026-08-03 02:17:06'),
(23, 1, '2026-08-17', '2026-08-23', 'PUBLISHED', '2026-08-05 04:50:51'),
(24, 3, '2026-08-17', '2026-08-23', 'CLOSED', '2026-08-07 18:32:18'),
(25, 7, '2026-08-17', '2026-08-23', 'CLOSED', '2026-08-16 07:19:09');

-- --------------------------------------------------------

--
-- Table structure for table `ca_shift`
--

DROP TABLE IF EXISTS `ca_shift`;
CREATE TABLE IF NOT EXISTS `ca_shift` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shift_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `branch_id` int DEFAULT NULL,
  `max_staff` int DEFAULT '3',
  `is_ot` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `inactive_at` datetime DEFAULT NULL,
  `inactive_by` int DEFAULT NULL,
  `inactive_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row_version` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_branch_shift` (`branch_id`),
  KEY `idx_shift_is_active` (`is_active`),
  KEY `idx_shift_inactive_by` (`inactive_by`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_shift`
--

INSERT INTO `ca_shift` (`id`, `shift_name`, `start_time`, `end_time`, `branch_id`, `max_staff`, `is_ot`, `is_active`, `inactive_at`, `inactive_by`, `inactive_reason`, `row_version`) VALUES
(1, 'Sáng', '05:50:00', '10:00:00', 1, 2, 0, 1, NULL, NULL, NULL, '2026-06-21 12:22:00'),
(2, 'Trưa', '10:00:00', '13:00:00', 1, 1, 0, 1, NULL, NULL, NULL, '2026-06-21 12:22:03'),
(3, 'Chiều', '14:00:00', '16:30:00', 1, 2, 0, 1, NULL, NULL, NULL, '2026-06-21 12:22:07'),
(17, 'Ca Thay Thinh', '13:00:00', '17:00:00', 3, 3, 0, 1, NULL, NULL, NULL, '2026-05-23 06:38:16'),
(18, 'Ca Sang', '05:50:00', '10:00:00', 3, 3, 0, 1, NULL, NULL, NULL, '2026-08-07 18:32:38'),
(22, 'Ca Trùng Hoai', '05:50:00', '10:00:00', 4, 5, 0, 1, NULL, NULL, NULL, '2026-06-17 07:03:47'),
(24, 'Ca test', '00:03:00', '23:59:00', 2, 2, 0, 1, NULL, NULL, NULL, '2026-07-10 19:40:38'),
(26, 'ca saMG', '06:00:00', '11:00:00', 7, 5, 0, 1, NULL, NULL, NULL, '2026-08-16 07:18:20');

-- --------------------------------------------------------

--
-- Table structure for table `ca_shift_delegation`
--

DROP TABLE IF EXISTS `ca_shift_delegation`;
CREATE TABLE IF NOT EXISTS `ca_shift_delegation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `shift_id` int NOT NULL,
  `work_date` date NOT NULL,
  `delegated_by_user_id` int NOT NULL,
  `delegate_user_id` int NOT NULL,
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `starts_at_utc` datetime NOT NULL,
  `ends_at_utc` datetime NOT NULL,
  `requested_at_utc` datetime NOT NULL,
  `responded_at_utc` datetime DEFAULT NULL,
  `revoked_at_utc` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_delegation_shift_date` (`branch_id`,`shift_id`,`work_date`),
  KEY `idx_delegation_delegate` (`delegate_user_id`),
  KEY `fk_delegation_shift` (`shift_id`),
  KEY `fk_delegation_delegator` (`delegated_by_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_shift_delegation`
--

INSERT INTO `ca_shift_delegation` (`id`, `branch_id`, `shift_id`, `work_date`, `delegated_by_user_id`, `delegate_user_id`, `reason`, `status`, `starts_at_utc`, `ends_at_utc`, `requested_at_utc`, `responded_at_utc`, `revoked_at_utc`) VALUES
(1, 1, 1, '2026-08-03', 4, 2, 'gggg', 'EXPIRED', '2026-08-02 22:50:00', '2026-08-03 03:00:00', '2026-08-03 02:23:09', '2026-08-03 02:23:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ca_shift_delegation_audit`
--

DROP TABLE IF EXISTS `ca_shift_delegation_audit`;
CREATE TABLE IF NOT EXISTS `ca_shift_delegation_audit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `delegation_id` int NOT NULL,
  `actor_user_id` int NOT NULL,
  `action_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occurred_at_utc` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_delegation_audit` (`delegation_id`),
  KEY `fk_delegation_audit_actor` (`actor_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_shift_delegation_audit`
--

INSERT INTO `ca_shift_delegation_audit` (`id`, `delegation_id`, `actor_user_id`, `action_type`, `details`, `occurred_at_utc`) VALUES
(1, 1, 4, 'DELEGATION_CREATED', 'Ủy quyền ca Sáng ngày 03/08/2026 cho Đặng Huy Vương.', '2026-08-03 02:23:09'),
(2, 1, 2, 'DELEGATION_ACCEPTED', 'Nhân viên đã nhận quyền trưởng ca tạm thời.', '2026-08-03 02:23:16');

-- --------------------------------------------------------

--
-- Table structure for table `ca_staff_registration`
--

DROP TABLE IF EXISTS `ca_staff_registration`;
CREATE TABLE IF NOT EXISTS `ca_staff_registration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `shift_id` int NOT NULL,
  `work_date` date NOT NULL,
  `status` enum('REGISTERED','WAITLIST','CANCELLED','REPLACEMENT_SELECTED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `period_id` int DEFAULT NULL,
  `registered_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_reg_user` (`user_id`),
  KEY `fk_reg_shift` (`shift_id`),
  KEY `idx_registration_waitlist` (`period_id`,`shift_id`,`work_date`,`status`,`registered_at`)
) ENGINE=InnoDB AUTO_INCREMENT=230 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_staff_registration`
--

INSERT INTO `ca_staff_registration` (`id`, `user_id`, `shift_id`, `work_date`, `status`, `period_id`, `registered_at`) VALUES
(1, 8, 18, '2026-05-11', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(2, 8, 17, '2026-05-11', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(3, 8, 18, '2026-05-12', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(4, 8, 17, '2026-05-12', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(5, 8, 18, '2026-05-13', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(6, 8, 17, '2026-05-13', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(7, 8, 18, '2026-05-14', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(8, 8, 17, '2026-05-14', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(9, 8, 18, '2026-05-15', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(10, 8, 17, '2026-05-15', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(11, 8, 18, '2026-05-18', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(12, 8, 17, '2026-05-18', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(13, 8, 18, '2026-05-19', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(14, 8, 17, '2026-05-19', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(15, 8, 18, '2026-05-20', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(16, 8, 17, '2026-05-20', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(17, 8, 18, '2026-05-21', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(18, 8, 17, '2026-05-21', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(19, 8, 18, '2026-05-22', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(20, 8, 17, '2026-05-22', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(30, 8, 18, '2026-05-04', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(31, 8, 18, '2026-05-05', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(32, 8, 17, '2026-05-04', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(33, 8, 17, '2026-05-05', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(34, 8, 17, '2026-05-06', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(35, 8, 17, '2026-05-07', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(36, 8, 17, '2026-05-08', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(37, 8, 18, '2026-05-08', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(38, 8, 18, '2026-05-07', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(39, 8, 18, '2026-05-06', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(40, 8, 17, '2026-05-25', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(43, 8, 17, '2026-05-26', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(44, 8, 17, '2026-05-27', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(47, 8, 17, '2026-05-28', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(48, 8, 18, '2026-06-08', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(49, 8, 17, '2026-06-09', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(50, 8, 17, '2026-06-11', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(51, 8, 18, '2026-06-11', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(54, 8, 18, '2026-06-09', 'REGISTERED', NULL, '2026-08-01 01:48:32'),
(64, 7, 1, '2026-06-22', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(65, 7, 2, '2026-06-22', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(66, 7, 3, '2026-06-22', 'REGISTERED', 8, '2026-08-01 01:48:32'),
(67, 7, 2, '2026-06-23', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(68, 7, 1, '2026-06-23', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(69, 7, 3, '2026-06-23', 'REGISTERED', 8, '2026-08-01 01:48:32'),
(70, 7, 1, '2026-06-24', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(71, 7, 2, '2026-06-24', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(72, 7, 3, '2026-06-24', 'REGISTERED', 8, '2026-08-01 01:48:32'),
(73, 7, 1, '2026-06-25', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(74, 7, 2, '2026-06-25', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(75, 7, 3, '2026-06-25', 'REGISTERED', 8, '2026-08-01 01:48:32'),
(76, 7, 1, '2026-06-26', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(77, 7, 2, '2026-06-26', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(78, 7, 3, '2026-06-26', 'REGISTERED', 8, '2026-08-01 01:48:32'),
(79, 2, 2, '2026-06-22', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(80, 2, 2, '2026-06-23', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(81, 2, 1, '2026-06-23', 'REGISTERED', 8, '2026-08-01 01:48:32'),
(82, 2, 1, '2026-06-22', 'REGISTERED', 8, '2026-08-01 01:48:32'),
(83, 2, 3, '2026-06-23', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(84, 2, 3, '2026-06-22', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(85, 2, 2, '2026-06-24', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(86, 2, 1, '2026-06-24', 'REGISTERED', 8, '2026-08-01 01:48:32'),
(87, 2, 1, '2026-06-25', 'REGISTERED', 8, '2026-08-01 01:48:32'),
(88, 2, 3, '2026-06-24', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(89, 2, 2, '2026-06-25', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(90, 2, 3, '2026-06-25', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(91, 2, 1, '2026-06-26', 'REGISTERED', 8, '2026-08-01 01:48:32'),
(92, 2, 2, '2026-06-26', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(93, 2, 3, '2026-06-26', 'CANCELLED', 8, '2026-08-01 01:48:32'),
(94, 2, 1, '2026-06-29', 'REGISTERED', 9, '2026-08-01 01:48:32'),
(95, 2, 1, '2026-07-03', 'REGISTERED', 9, '2026-08-01 01:48:32'),
(96, 2, 1, '2026-06-30', 'REGISTERED', 9, '2026-08-01 01:48:32'),
(97, 2, 1, '2026-07-01', 'REGISTERED', 9, '2026-08-01 01:48:32'),
(98, 2, 1, '2026-07-02', 'REGISTERED', 9, '2026-08-01 01:48:32'),
(99, 2, 3, '2026-06-29', 'REGISTERED', 9, '2026-08-01 01:48:32'),
(100, 2, 3, '2026-07-02', 'REGISTERED', 9, '2026-08-01 01:48:32'),
(101, 2, 3, '2026-06-30', 'REGISTERED', 9, '2026-08-01 01:48:32'),
(102, 2, 3, '2026-07-03', 'REGISTERED', 9, '2026-08-01 01:48:32'),
(103, 2, 3, '2026-07-01', 'REGISTERED', 9, '2026-08-01 01:48:32'),
(108, 2, 2, '2026-07-17', 'REGISTERED', 10, '2026-08-01 01:48:32'),
(109, 2, 2, '2026-07-13', 'REGISTERED', 10, '2026-08-01 01:48:32'),
(110, 2, 2, '2026-07-14', 'REGISTERED', 10, '2026-08-01 01:48:32'),
(111, 2, 2, '2026-07-15', 'REGISTERED', 10, '2026-08-01 01:48:32'),
(112, 2, 2, '2026-07-16', 'REGISTERED', 10, '2026-08-01 01:48:32'),
(118, 13, 24, '2026-07-13', 'REGISTERED', 11, '2026-08-01 01:48:32'),
(119, 13, 24, '2026-07-14', 'REGISTERED', 11, '2026-08-01 01:48:32'),
(120, 13, 24, '2026-07-15', 'REGISTERED', 11, '2026-08-01 01:48:32'),
(121, 13, 24, '2026-07-16', 'REGISTERED', 11, '2026-08-01 01:48:32'),
(122, 13, 24, '2026-07-17', 'REGISTERED', 11, '2026-08-01 01:48:32'),
(123, 13, 24, '2026-07-18', 'REGISTERED', 11, '2026-08-01 01:48:32'),
(124, 13, 24, '2026-07-19', 'REGISTERED', 11, '2026-08-01 01:48:32'),
(125, 13, 24, '2026-07-27', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(126, 13, 24, '2026-07-28', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(127, 13, 24, '2026-07-29', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(128, 13, 24, '2026-07-30', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(129, 13, 24, '2026-07-31', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(130, 13, 24, '2026-08-01', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(131, 13, 24, '2026-08-02', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(132, 13, 24, '2026-07-27', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(133, 13, 24, '2026-07-28', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(134, 13, 24, '2026-07-29', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(135, 13, 24, '2026-07-30', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(136, 13, 24, '2026-07-31', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(137, 13, 24, '2026-08-01', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(138, 13, 24, '2026-08-02', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(139, 13, 24, '2026-07-27', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(140, 13, 24, '2026-07-28', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(141, 13, 24, '2026-07-29', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(142, 13, 24, '2026-07-30', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(143, 13, 24, '2026-07-31', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(144, 13, 24, '2026-08-01', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(145, 13, 24, '2026-08-02', 'CANCELLED', 15, '2026-08-01 01:48:32'),
(146, 13, 24, '2026-07-23', 'REGISTERED', 12, '2026-08-01 01:48:32'),
(147, 13, 24, '2026-07-28', 'REGISTERED', 15, '2026-08-01 01:48:32'),
(148, 13, 24, '2026-07-29', 'REGISTERED', 15, '2026-08-01 01:48:32'),
(149, 13, 24, '2026-07-30', 'REGISTERED', 15, '2026-08-01 01:48:32'),
(150, 13, 24, '2026-07-31', 'REGISTERED', 15, '2026-08-01 01:48:32'),
(151, 2, 1, '2026-07-27', 'CANCELLED', 14, '2026-08-01 01:48:32'),
(152, 2, 2, '2026-07-27', 'CANCELLED', 14, '2026-08-01 01:48:32'),
(153, 2, 3, '2026-07-27', 'CANCELLED', 14, '2026-08-01 01:48:32'),
(154, 2, 1, '2026-07-27', 'CANCELLED', 14, '2026-08-01 01:48:32'),
(155, 2, 2, '2026-07-27', 'CANCELLED', 14, '2026-08-01 01:48:32'),
(156, 2, 3, '2026-07-27', 'CANCELLED', 14, '2026-08-01 01:48:32'),
(157, 2, 1, '2026-07-27', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(158, 2, 2, '2026-07-27', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(159, 2, 3, '2026-07-27', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(160, 2, 1, '2026-07-28', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(161, 2, 2, '2026-07-28', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(162, 2, 3, '2026-07-28', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(163, 2, 1, '2026-07-29', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(164, 2, 2, '2026-07-29', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(165, 2, 3, '2026-07-29', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(166, 2, 1, '2026-07-30', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(167, 2, 2, '2026-07-30', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(168, 2, 3, '2026-07-30', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(169, 2, 1, '2026-07-31', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(170, 2, 2, '2026-07-31', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(171, 2, 3, '2026-07-31', 'REGISTERED', 14, '2026-08-01 01:48:32'),
(172, 13, 24, '2026-08-03', 'CANCELLED', 16, '2026-08-01 01:48:32'),
(173, 13, 24, '2026-08-04', 'CANCELLED', 16, '2026-08-01 01:48:32'),
(174, 13, 24, '2026-08-05', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(175, 13, 24, '2026-08-06', 'CANCELLED', 16, '2026-08-01 01:48:32'),
(176, 13, 24, '2026-08-07', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(177, 13, 24, '2026-08-08', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(178, 13, 24, '2026-08-09', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(179, 14, 24, '2026-08-03', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(180, 14, 24, '2026-08-04', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(181, 14, 24, '2026-08-05', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(182, 14, 24, '2026-08-06', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(183, 14, 24, '2026-08-07', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(184, 14, 24, '2026-08-08', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(185, 14, 24, '2026-08-09', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(186, 13, 24, '2026-08-04', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(187, 13, 24, '2026-08-06', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(188, 13, 24, '2026-08-03', 'REGISTERED', 16, '2026-08-01 01:48:32'),
(189, 13, 24, '2026-07-27', 'REGISTERED', 15, '2026-08-01 01:48:32'),
(190, 13, 24, '2026-08-01', 'REGISTERED', 15, '2026-08-01 01:48:32'),
(191, 13, 24, '2026-07-26', 'REGISTERED', 12, '2026-08-01 01:48:32'),
(192, 2, 1, '2026-08-03', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(193, 2, 2, '2026-08-03', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(194, 2, 3, '2026-08-03', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(195, 2, 1, '2026-08-04', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(196, 2, 2, '2026-08-04', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(197, 2, 3, '2026-08-04', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(198, 2, 1, '2026-08-05', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(199, 2, 2, '2026-08-05', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(200, 2, 3, '2026-08-05', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(201, 2, 1, '2026-08-06', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(202, 2, 2, '2026-08-06', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(203, 2, 3, '2026-08-06', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(204, 2, 1, '2026-08-07', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(205, 2, 2, '2026-08-07', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(206, 2, 3, '2026-08-07', 'REGISTERED', 18, '2026-08-01 01:48:32'),
(207, 13, 24, '2026-08-10', 'REGISTERED', 19, '2026-08-01 01:48:32'),
(208, 13, 24, '2026-08-11', 'REGISTERED', 19, '2026-08-01 01:48:32'),
(209, 13, 24, '2026-08-12', 'REGISTERED', 19, '2026-08-01 01:48:32'),
(210, 13, 24, '2026-08-13', 'REGISTERED', 19, '2026-08-01 01:48:32'),
(211, 13, 24, '2026-08-24', 'REGISTERED', 20, '2026-08-01 05:19:13'),
(212, 13, 24, '2026-08-25', 'REGISTERED', 20, '2026-08-01 05:19:13'),
(213, 13, 24, '2026-08-26', 'REGISTERED', 20, '2026-08-01 05:19:13'),
(214, 13, 24, '2026-08-27', 'REGISTERED', 20, '2026-08-01 05:19:13'),
(215, 13, 24, '2026-08-28', 'REGISTERED', 20, '2026-08-01 05:19:13'),
(216, 13, 24, '2026-08-29', 'REGISTERED', 20, '2026-08-01 05:19:13'),
(217, 13, 24, '2026-08-30', 'REGISTERED', 20, '2026-08-01 05:19:13'),
(228, 7, 1, '2026-08-17', 'REPLACEMENT_SELECTED', 23, '2026-08-05 12:00:25'),
(229, 7, 2, '2026-08-17', 'WAITLIST', 23, '2026-08-05 12:00:30');

-- --------------------------------------------------------

--
-- Table structure for table `ca_supplemental_attendance_request`
--

DROP TABLE IF EXISTS `ca_supplemental_attendance_request`;
CREATE TABLE IF NOT EXISTS `ca_supplemental_attendance_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `schedule_id` int NOT NULL,
  `requested_by_manager_id` int NOT NULL,
  `proposed_check_in_time` datetime NOT NULL,
  `proposed_check_out_time` datetime NOT NULL,
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `reviewed_by_admin_id` int DEFAULT NULL,
  `reject_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_supplemental_schedule` (`schedule_id`),
  KEY `idx_supplemental_status` (`status`,`updated_at`),
  KEY `idx_supplemental_manager` (`requested_by_manager_id`),
  KEY `idx_supplemental_admin` (`reviewed_by_admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ca_supplemental_attendance_request`
--

INSERT INTO `ca_supplemental_attendance_request` (`id`, `schedule_id`, `requested_by_manager_id`, `proposed_check_in_time`, `proposed_check_out_time`, `reason`, `status`, `reviewed_by_admin_id`, `reject_reason`, `created_at`, `updated_at`, `reviewed_at`) VALUES
(1, 179, 6, '2026-08-03 00:03:00', '2026-08-03 17:00:00', 'Co di lam anh oi', 'APPROVED', 1, NULL, '2026-08-07 14:07:19', '2026-08-07 14:07:29', '2026-08-07 14:07:29'),
(2, 178, 6, '2026-08-03 00:03:00', '2026-08-03 17:00:00', 'Co di lam anh oi', 'APPROVED', 1, NULL, '2026-08-07 14:07:19', '2026-08-07 14:07:30', '2026-08-07 14:07:30'),
(3, 192, 6, '2026-08-03 00:03:00', '2026-08-03 17:00:00', 'Co di lam anh oi', 'APPROVED', 1, NULL, '2026-08-07 14:07:19', '2026-08-07 14:07:30', '2026-08-07 14:07:30');

-- --------------------------------------------------------

--
-- Table structure for table `dm_branch`
--

DROP TABLE IF EXISTS `dm_branch`;
CREATE TABLE IF NOT EXISTS `dm_branch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `inactive_at` datetime DEFAULT NULL,
  `inactive_by` int DEFAULT NULL,
  `inactive_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_branch_is_active` (`is_active`),
  KEY `idx_branch_inactive_by` (`inactive_by`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dm_branch`
--

INSERT INTO `dm_branch` (`id`, `name`, `address`, `latitude`, `longitude`, `is_active`, `inactive_at`, `inactive_by`, `inactive_reason`) VALUES
(1, 'THCS Khánh Bình', '314b Âu Dương Lân', 10.73814000, 106.67778000, 1, NULL, NULL, NULL),
(2, 'THCS Tùng Thiện Vương', '381 Tùng Thiện Vương', 10.74452100, 106.66057200, 1, NULL, NULL, NULL),
(3, 'THCS Phan Đăng Lưu', '104 Bùi Minh Trực', 10.73824000, 106.67785000, 1, NULL, NULL, NULL),
(4, 'TH Lương Thế Vinh', '12 Tân Kiểng', NULL, NULL, 1, NULL, NULL, NULL),
(7, 'Binh An', '1184', NULL, NULL, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kho_branch_front_stock`
--

DROP TABLE IF EXISTS `kho_branch_front_stock`;
CREATE TABLE IF NOT EXISTS `kho_branch_front_stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_front_stock_branch_product` (`branch_id`,`product_id`),
  KEY `fk_front_branch` (`branch_id`),
  KEY `fk_front_product` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kho_branch_front_stock`
--

INSERT INTO `kho_branch_front_stock` (`id`, `branch_id`, `product_id`, `quantity`) VALUES
(1, 1, 6, 0),
(2, 1, 5, 0),
(3, 1, 8, 1),
(4, 1, 9, 0),
(5, 2, 12, 13),
(6, 2, 13, 1),
(7, 2, 14, 28),
(8, 2, 15, 28),
(9, 2, 19, 8),
(10, 2, 16, 5),
(11, 2, 17, 5),
(12, 2, 18, 5),
(13, 2, 20, 5);

-- --------------------------------------------------------

--
-- Table structure for table `kho_branch_inventory`
--

DROP TABLE IF EXISTS `kho_branch_inventory`;
CREATE TABLE IF NOT EXISTS `kho_branch_inventory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_inventory_branch_product` (`branch_id`,`product_id`),
  KEY `branch_id` (`branch_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kho_branch_inventory`
--

INSERT INTO `kho_branch_inventory` (`id`, `branch_id`, `product_id`, `quantity`) VALUES
(1, 1, 5, 6),
(2, 1, 6, 100),
(3, 1, 7, 500),
(4, 1, 8, 0),
(5, 1, 9, 5),
(6, 1, 10, 10),
(7, 1, 11, 100),
(8, 1, 12, 100),
(9, 1, 13, 10),
(10, 2, 12, 70),
(11, 2, 13, 4),
(12, 2, 14, 558),
(13, 2, 15, 460),
(14, 1, 16, 10),
(15, 1, 17, 5),
(16, 1, 18, 10),
(17, 1, 19, 10),
(18, 1, 20, 20),
(19, 2, 16, 35),
(20, 2, 17, 25),
(21, 2, 18, 35),
(22, 2, 19, 25),
(23, 2, 20, 75);

-- --------------------------------------------------------

--
-- Table structure for table `kho_export_detail`
--

DROP TABLE IF EXISTS `kho_export_detail`;
CREATE TABLE IF NOT EXISTS `kho_export_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `export_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_det_export` (`export_id`),
  KEY `fk_expdet_product` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kho_export_detail`
--

INSERT INTO `kho_export_detail` (`id`, `export_id`, `product_id`, `quantity`) VALUES
(1, 8, 12, 10),
(2, 8, 13, 2),
(3, 9, 12, 5),
(4, 9, 13, 2),
(5, 9, 14, 2),
(6, 9, 15, 10),
(7, 10, 12, 10),
(8, 10, 13, 2),
(9, 10, 14, 10),
(10, 10, 15, 10),
(11, 11, 14, 20),
(12, 11, 15, 10),
(13, 11, 19, 10),
(14, 12, 12, 5),
(15, 12, 14, 10),
(16, 12, 15, 10),
(17, 12, 16, 5),
(18, 12, 17, 5),
(19, 12, 18, 5),
(20, 12, 19, 5),
(21, 12, 20, 5);

-- --------------------------------------------------------

--
-- Table structure for table `kho_export_ticket`
--

DROP TABLE IF EXISTS `kho_export_ticket`;
CREATE TABLE IF NOT EXISTS `kho_export_ticket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `manager_id` int NOT NULL,
  `branch_id` int NOT NULL,
  `schedule_id` int DEFAULT NULL,
  `export_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exp_manager` (`manager_id`),
  KEY `fk_exp_branch` (`branch_id`),
  KEY `idx_export_schedule` (`schedule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kho_export_ticket`
--

INSERT INTO `kho_export_ticket` (`id`, `manager_id`, `branch_id`, `schedule_id`, `export_date`, `note`) VALUES
(1, 1, 1, NULL, '2026-05-09 11:01:35', NULL),
(2, 1, 1, NULL, '2026-05-09 11:02:22', NULL),
(3, 1, 1, NULL, '2026-05-09 11:04:19', NULL),
(4, 1, 1, NULL, '2026-05-09 12:05:35', NULL),
(5, 4, 1, NULL, '2026-05-13 08:56:20', NULL),
(6, 4, 1, NULL, '2026-05-13 08:57:18', NULL),
(7, 4, 1, NULL, '2026-05-13 08:58:57', NULL),
(8, 6, 2, 151, '2026-07-11 02:57:20', NULL),
(9, 6, 2, 154, '2026-07-16 02:21:03', NULL),
(10, 6, 2, 155, '2026-07-17 01:56:21', NULL),
(11, 6, 2, 162, '2026-07-23 03:44:17', NULL),
(12, 6, 2, 173, '2026-07-29 03:28:28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kho_import_detail`
--

DROP TABLE IF EXISTS `kho_import_detail`;
CREATE TABLE IF NOT EXISTS `kho_import_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `import_id` int NOT NULL,
  `product_id` int NOT NULL,
  `unit_at_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `fk_impdet_import` (`import_id`),
  KEY `fk_impdet_product` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kho_import_detail`
--

INSERT INTO `kho_import_detail` (`id`, `import_id`, `product_id`, `unit_at_time`, `quantity`, `unit_price`) VALUES
(1, 8, 11, NULL, 100, 258000.00),
(2, 9, 12, 'Thùng', 100, 258000.00),
(3, 9, 13, 'Thùng', 10, 30000.00),
(4, 10, 12, 'Thùng', 100, 258000.00),
(5, 10, 13, 'Thùng', 10, 30000.00),
(6, 11, 14, 'Thùng', 100, 258000.00),
(7, 11, 15, 'Thùng', 100, 270000.00),
(8, 12, 16, 'Thùng', 10, 270000.00),
(9, 12, 17, 'Thùng', 5, 50000.00),
(10, 12, 18, 'Thùng', 10, 270000.00),
(11, 12, 19, 'Bịch', 10, 100000.00),
(12, 12, 20, 'Kg', 20, 50000.00),
(13, 13, 16, 'Thùng', 10, 270000.00),
(14, 13, 17, 'Thùng', 5, 50000.00),
(15, 13, 18, 'Thùng', 10, 270000.00),
(16, 13, 19, 'Bịch', 10, 100000.00),
(17, 13, 20, 'Kg', 20, 50000.00),
(18, 14, 16, 'Thùng', 10, 270000.00),
(19, 14, 17, 'Thùng', 5, 50000.00),
(20, 14, 18, 'Thùng', 10, 270000.00),
(21, 14, 19, 'Bịch', 10, 100000.00),
(22, 14, 20, 'Kg', 20, 50000.00),
(23, 15, 14, 'Thùng', 100, 258000.00),
(24, 15, 15, 'Thùng', 100, 270000.00),
(25, 16, 14, 'Thùng', 100, 258000.00),
(26, 16, 15, 'Thùng', 100, 270000.00),
(27, 17, 14, 'Thùng', 100, 258000.00),
(28, 17, 15, 'Thùng', 100, 270000.00),
(29, 18, 14, 'Thùng', 200, 258000.00),
(30, 18, 15, 'Thùng', 100, 270000.00),
(31, 19, 16, 'Thùng', 10, 270000.00),
(32, 19, 17, 'Thùng', 10, 50000.00),
(33, 19, 18, 'Thùng', 10, 270000.00),
(34, 19, 19, 'Bịch', 10, 100000.00),
(35, 19, 20, 'Kg', 20, 50000.00),
(36, 20, 16, 'Thùng', 10, 270000.00),
(37, 20, 17, 'Thùng', 10, 50000.00),
(38, 20, 18, 'Thùng', 10, 270000.00),
(39, 20, 19, 'Bịch', 10, 100000.00),
(40, 20, 20, 'Kg', 20, 50000.00);

-- --------------------------------------------------------

--
-- Table structure for table `kho_import_ticket`
--

DROP TABLE IF EXISTS `kho_import_ticket`;
CREATE TABLE IF NOT EXISTS `kho_import_ticket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `manager_id` int NOT NULL,
  `branch_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `invoice_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `import_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_import_supplier_invoice` (`supplier_id`,`invoice_code`),
  KEY `fk_imp_manager` (`manager_id`),
  KEY `fk_imp_branch` (`branch_id`),
  KEY `fk_imp_supplier` (`supplier_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kho_import_ticket`
--

INSERT INTO `kho_import_ticket` (`id`, `manager_id`, `branch_id`, `supplier_id`, `invoice_code`, `invoice_date`, `import_date`, `total_amount`, `note`) VALUES
(1, 1, 1, 1, NULL, NULL, '2026-05-09 09:56:34', 0.00, NULL),
(2, 1, 1, 3, NULL, NULL, '2026-05-09 09:59:39', 0.00, NULL),
(3, 1, 1, 2, NULL, NULL, '2026-05-09 10:00:34', 0.00, NULL),
(4, 1, 1, 3, NULL, NULL, '2026-05-09 11:32:38', 0.00, NULL),
(5, 1, 1, 1, NULL, NULL, '2026-05-09 12:04:24', 0.00, NULL),
(6, 1, 1, 2, NULL, NULL, '2026-05-13 07:31:12', 0.00, NULL),
(7, 4, 1, 3, NULL, NULL, '2026-05-13 08:16:28', 0.00, NULL),
(8, 4, 1, 4, NULL, NULL, '2026-06-26 15:59:11', 0.00, NULL),
(9, 4, 1, 4, 'HD001', '2026-05-06', '2026-07-10 02:47:27', 26100000.00, NULL),
(10, 6, 2, 4, 'HDTTV', '2026-05-06', '2026-07-11 02:44:51', 26100000.00, NULL),
(11, 6, 2, 4, 'HDTTV1', '2026-05-06', '2026-07-11 04:38:20', 52800000.00, 'Nhập hàng ca test'),
(12, 4, 1, 4, NULL, '2026-07-14', '2026-07-14 16:05:04', 7650000.00, NULL),
(13, 6, 2, 4, 'HD-OCR-002', '2026-07-14', '2026-07-18 02:23:49', 7650000.00, NULL),
(14, 6, 2, 4, 'HD-OCR-003', '2026-07-14', '2026-07-18 02:24:30', 7650000.00, NULL),
(15, 6, 2, 4, 'HDTTV2', '2026-05-06', '2026-07-18 02:24:58', 52800000.00, NULL),
(16, 6, 2, 4, 'HDTTV3', '2026-05-06', '2026-07-18 02:25:28', 52800000.00, NULL),
(17, 6, 2, 4, 'HDTTV4', '2026-07-23', '2026-07-23 02:29:09', 52800000.00, NULL),
(18, 6, 2, 5, 'HDTTV4', '2026-07-23', '2026-07-23 02:30:05', 78600000.00, NULL),
(19, 6, 2, 4, 'HD-OCR-005', '2026-07-14', '2026-07-28 20:44:34', 7900000.00, NULL),
(20, 6, 2, 4, 'HD-OCR-005-NGAY-HOA', '2026-07-14', '2026-07-29 03:05:29', 7900000.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kho_product`
--

DROP TABLE IF EXISTS `kho_product`;
CREATE TABLE IF NOT EXISTS `kho_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `inactive_at` datetime DEFAULT NULL,
  `inactive_by` int DEFAULT NULL,
  `inactive_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_product_code` (`product_code`),
  KEY `fk_product_supplier` (`supplier_id`),
  KEY `idx_product_name` (`product_name`(250)),
  KEY `idx_product_is_active` (`is_active`),
  KEY `idx_product_inactive_by` (`inactive_by`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kho_product`
--

INSERT INTO `kho_product` (`id`, `product_code`, `product_name`, `unit`, `supplier_id`, `is_active`, `inactive_at`, `inactive_by`, `inactive_reason`) VALUES
(5, NULL, 'kẹo', '1', NULL, 1, NULL, NULL, NULL),
(6, NULL, 'kem', '10', NULL, 1, NULL, NULL, NULL),
(7, NULL, 'Danisa VIP', 'Hộp', 2, 1, NULL, NULL, NULL),
(8, NULL, 'Kem chuoi', 'goi', 3, 1, NULL, NULL, NULL),
(9, NULL, 'Kem dau', 'goi', 3, 1, NULL, NULL, NULL),
(10, NULL, 'Kem xoai', 'goi', 3, 1, NULL, NULL, NULL),
(11, NULL, 'Mirinda Soda Kem', 'Cái', 4, 1, NULL, NULL, NULL),
(12, NULL, 'Mirinda Xá Xị', 'Thùng', 4, 1, NULL, NULL, NULL),
(13, NULL, 'Phô Mai Con  Cười', 'Thùng', 4, 1, NULL, NULL, NULL),
(14, NULL, '7Up', 'Thùng', 4, 1, NULL, NULL, NULL),
(15, NULL, 'Sting Dâu', 'Thùng', 4, 1, NULL, NULL, NULL),
(16, 'SP001', 'Mirinda cam', 'Thùng', 4, 1, NULL, NULL, NULL),
(17, 'SP002', 'Phô mai que', 'Thùng', 4, 0, '2026-08-08 01:46:42', 1, 'test'),
(18, 'SP003', 'Sting đỏ', 'Thùng', 4, 1, NULL, NULL, NULL),
(19, 'SP004', 'Bánh tráng cuộn', 'Bịch', 4, 1, NULL, NULL, NULL),
(20, 'SP005', 'Xúc xích tiệt trùng', 'Kg', 4, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kho_shift_closing_detail`
--

DROP TABLE IF EXISTS `kho_shift_closing_detail`;
CREATE TABLE IF NOT EXISTS `kho_shift_closing_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `report_id` int NOT NULL,
  `product_id` int NOT NULL,
  `system_count` int NOT NULL DEFAULT '0',
  `actual_count` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_closing_detail_report_product` (`report_id`,`product_id`),
  KEY `fk_detail_report` (`report_id`),
  KEY `fk_detail_product` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kho_shift_closing_detail`
--

INSERT INTO `kho_shift_closing_detail` (`id`, `report_id`, `product_id`, `system_count`, `actual_count`) VALUES
(1, 4, 12, 10, 3),
(2, 4, 13, 2, 1),
(3, 5, 6, 0, 0),
(4, 5, 8, 1, 1),
(5, 5, 9, 0, 0),
(6, 5, 5, 0, 0),
(7, 6, 14, 12, 10),
(8, 6, 12, 18, 15),
(9, 6, 13, 5, 4),
(10, 6, 15, 20, 17),
(15, 7, 14, 10, 7),
(16, 7, 12, 15, 13),
(17, 7, 13, 4, 3),
(18, 7, 15, 17, 15),
(19, 8, 14, 27, 20),
(20, 8, 19, 10, 5),
(21, 8, 12, 13, 10),
(22, 8, 13, 3, 3),
(23, 8, 15, 25, 20),
(24, 9, 14, 20, 19),
(25, 9, 19, 5, 4),
(26, 9, 12, 10, 9),
(27, 9, 13, 3, 2),
(28, 9, 15, 20, 17),
(29, 10, 14, 20, 19),
(30, 10, 19, 5, 4),
(31, 10, 12, 10, 9),
(32, 10, 13, 3, 2),
(33, 10, 15, 20, 19),
(34, 11, 14, 19, 18),
(35, 11, 19, 4, 3),
(36, 11, 12, 9, 8),
(37, 11, 13, 2, 1),
(38, 11, 15, 19, 18),
(39, 12, 14, 28, 27),
(40, 12, 19, 8, 7),
(41, 12, 16, 5, 4),
(42, 12, 12, 13, 12),
(43, 12, 13, 1, 1),
(44, 12, 17, 5, 4),
(45, 12, 15, 28, 27),
(46, 12, 18, 5, 4),
(47, 12, 20, 5, 4),
(48, 13, 6, 0, 0),
(49, 13, 8, 1, 1),
(50, 13, 9, 0, 0),
(51, 13, 5, 0, 0),
(52, 14, 14, 28, 28),
(53, 14, 19, 8, 8),
(54, 14, 16, 5, 5),
(55, 14, 12, 13, 13),
(56, 14, 13, 1, 1),
(57, 14, 17, 5, 5),
(58, 14, 15, 28, 28),
(59, 14, 18, 5, 5),
(60, 14, 20, 5, 5),
(61, 15, 14, 28, 28),
(62, 15, 19, 8, 8),
(63, 15, 16, 5, 5),
(64, 15, 12, 13, 13),
(65, 15, 13, 1, 1),
(66, 15, 17, 5, 5),
(67, 15, 15, 28, 28),
(68, 15, 18, 5, 5),
(69, 15, 20, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `kho_shift_closing_report`
--

DROP TABLE IF EXISTS `kho_shift_closing_report`;
CREATE TABLE IF NOT EXISTS `kho_shift_closing_report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `user_id` int NOT NULL,
  `schedule_id` int DEFAULT NULL,
  `report_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `reviewed_by` int DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `reject_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_shift_report_schedule` (`schedule_id`),
  KEY `fk_report_branch` (`branch_id`),
  KEY `fk_report_user` (`user_id`),
  KEY `idx_report_schedule` (`schedule_id`),
  KEY `idx_closing_report_status` (`status`),
  KEY `idx_closing_report_reviewed_by` (`reviewed_by`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kho_shift_closing_report`
--

INSERT INTO `kho_shift_closing_report` (`id`, `branch_id`, `user_id`, `schedule_id`, `report_date`, `note`, `status`, `reviewed_by`, `reviewed_at`, `reject_reason`) VALUES
(1, 1, 1, NULL, '2026-05-09 12:01:59', NULL, 'APPROVED', NULL, '2026-05-09 12:01:59', NULL),
(2, 1, 1, NULL, '2026-05-09 12:07:06', NULL, 'APPROVED', NULL, '2026-05-09 12:07:06', NULL),
(3, 1, 4, NULL, '2026-05-13 08:58:15', NULL, 'APPROVED', NULL, '2026-05-13 08:58:15', NULL),
(4, 2, 13, 158, '2026-07-11 06:01:50', NULL, 'APPROVED', NULL, '2026-07-11 06:01:50', NULL),
(5, 1, 2, 124, '2026-07-13 13:42:45', NULL, 'APPROVED', NULL, '2026-07-13 13:42:45', NULL),
(6, 2, 13, 148, '2026-07-17 01:57:54', NULL, 'APPROVED', NULL, '2026-07-17 01:57:54', NULL),
(7, 2, 13, 149, '2026-07-18 01:58:14', NULL, 'APPROVED', 6, '2026-07-18 01:58:26', NULL),
(8, 2, 13, 166, '2026-07-23 03:46:10', NULL, 'APPROVED', 6, '2026-07-23 03:46:34', NULL),
(9, 2, 13, 167, '2026-07-28 17:56:19', NULL, 'REJECTED', 6, '2026-07-23 17:56:40', 'Bao cao sai du lieu'),
(10, 2, 13, 201, '2026-07-26 22:05:30', NULL, 'APPROVED', 6, '2026-07-26 22:05:53', NULL),
(11, 2, 13, 199, '2026-07-27 23:03:02', NULL, 'APPROVED', 6, '2026-07-27 23:03:12', NULL),
(12, 2, 13, 168, '2026-07-29 04:58:14', NULL, 'REJECTED', 6, '2026-07-29 04:58:31', 'Đếm lại nha'),
(13, 1, 2, 244, '2026-08-03 10:42:03', NULL, 'APPROVED', 4, '2026-08-03 10:42:45', NULL),
(14, 2, 13, 181, '2026-08-04 02:14:36', NULL, 'APPROVED', 6, '2026-08-04 02:15:00', NULL),
(15, 2, 13, 182, '2026-08-05 12:06:29', NULL, 'APPROVED', 6, '2026-08-05 12:06:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kho_supplier`
--

DROP TABLE IF EXISTS `kho_supplier`;
CREATE TABLE IF NOT EXISTS `kho_supplier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kho_supplier`
--

INSERT INTO `kho_supplier` (`id`, `supplier_name`, `phone`, `address`, `is_deleted`, `deleted_at`) VALUES
(1, 'Đại lý Nước Ngọt & Bánh Kẹo', '0901234567', 'Q8, TP.HCM', 0, NULL),
(2, 'Đại lý bánh dalisa', '03026497', 'q8', 0, NULL),
(3, 'Kem clane', '090306548', 'q7', 0, NULL),
(4, 'Trùng Hoai', '0945', '1184', 0, NULL),
(5, 'Tiki Taka', '0912085084', '1123 Quang Trung', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `luong_monthly_salary`
--

DROP TABLE IF EXISTS `luong_monthly_salary`;
CREATE TABLE IF NOT EXISTS `luong_monthly_salary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `total_hours` decimal(10,2) NOT NULL,
  `hourly_wage_at_time` decimal(10,2) NOT NULL,
  `total_salary` decimal(15,2) NOT NULL,
  `total_bonus` decimal(15,2) DEFAULT '0.00',
  `total_penalty` decimal(15,2) DEFAULT '0.00',
  `bhxh_contribution_id` int DEFAULT NULL,
  `current_bhxh_deduction` decimal(15,2) NOT NULL DEFAULT '0.00',
  `previous_bhxh_recovery` decimal(15,2) NOT NULL DEFAULT '0.00',
  `social_insurance_deduction` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'PENDING',
  `paid_at` datetime DEFAULT NULL,
  `finalized_at` datetime DEFAULT NULL,
  `finalized_by_user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_month_year` (`user_id`,`month`,`year`),
  UNIQUE KEY `uq_salary_bhxh_contribution` (`bhxh_contribution_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_monthly_salary_finalized_by` (`finalized_by_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `luong_monthly_salary`
--

INSERT INTO `luong_monthly_salary` (`id`, `user_id`, `month`, `year`, `total_hours`, `hourly_wage_at_time`, `total_salary`, `total_bonus`, `total_penalty`, `bhxh_contribution_id`, `current_bhxh_deduction`, `previous_bhxh_recovery`, `social_insurance_deduction`, `status`, `paid_at`, `finalized_at`, `finalized_by_user_id`, `created_at`) VALUES
(1, 13, 7, 2026, 63.21, 34500.00, -269255.00, 500000.00, 2950000.00, 4, 400000.00, 0.00, 400000.00, 'PAID', '2026-08-05 02:11:57', '2026-08-03 15:09:52', 6, '2026-07-10 16:23:51'),
(2, 2, 7, 2026, 0.00, 27000.00, -1500000.00, 0.00, 1500000.00, NULL, 0.00, 0.00, 0.00, 'PAID', '2026-07-27 21:17:12', '2026-07-27 21:16:29', 4, '2026-07-23 07:25:46'),
(3, 13, 8, 2026, 66.29, 34500.00, -312995.00, 0.00, 2600000.00, NULL, 0.00, 0.00, 0.00, 'PAID', '2026-08-17 10:39:38', '2026-08-17 10:36:31', 1, '2026-07-31 14:10:40'),
(4, 2, 8, 2026, 5.31, 34500.00, 683195.00, 9000000.00, 8500000.00, NULL, 0.00, 0.00, 0.00, 'Pending', NULL, '2026-08-16 14:29:04', 4, '2026-08-02 20:35:59'),
(5, 14, 8, 2026, 63.28, 23000.00, 355440.00, 0.00, 1100000.00, NULL, 0.00, 0.00, 0.00, 'FINALIZED', NULL, '2026-08-17 10:36:31', 1, '2026-08-04 12:11:23'),
(6, 6, 8, 2026, 16.95, 35000.00, 593250.00, 0.00, 0.00, NULL, 0.00, 0.00, 0.00, 'PENDING', NULL, NULL, NULL, '2026-08-07 07:07:30'),
(7, 7, 8, 2026, 0.00, 23000.00, -300000.00, 0.00, 300000.00, NULL, 0.00, 0.00, 0.00, 'PENDING', NULL, NULL, NULL, '2026-08-16 19:58:44');

-- --------------------------------------------------------

--
-- Table structure for table `luong_salary_adjustment_history`
--

DROP TABLE IF EXISTS `luong_salary_adjustment_history`;
CREATE TABLE IF NOT EXISTS `luong_salary_adjustment_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `salary_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_by_user_id` int NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `bonus_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `penalty_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `reviewed_by_user_id` int DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `review_note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_salary_adjustment_salary` (`salary_id`),
  KEY `idx_salary_adjustment_user_period` (`user_id`,`year`,`month`),
  KEY `idx_salary_adjustment_creator` (`created_by_user_id`),
  KEY `idx_salary_adjustment_status` (`status`),
  KEY `idx_salary_adjustment_reviewer` (`reviewed_by_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `luong_salary_adjustment_history`
--

INSERT INTO `luong_salary_adjustment_history` (`id`, `salary_id`, `user_id`, `created_by_user_id`, `month`, `year`, `bonus_amount`, `penalty_amount`, `reason`, `status`, `reviewed_by_user_id`, `reviewed_at`, `review_note`, `created_at`) VALUES
(1, 1, 13, 6, 7, 2026, 500000.00, 100000.00, 'Đi trễ, Nghỉ làm', 'APPROVED', NULL, NULL, NULL, '2026-07-23 04:11:08'),
(2, 3, 13, 6, 8, 2026, 1100000.00, 0.00, 'khong di tre a', 'REJECTED', 1, '2026-08-07 21:08:02', '', '2026-08-07 21:06:32'),
(3, 4, 2, 4, 8, 2026, 900000000.00, 0.00, 'khai quoc', 'REJECTED', 1, '2026-08-16 14:27:51', '', '2026-08-16 14:26:47'),
(4, 4, 2, 4, 8, 2026, 9000000.00, 0.00, 'hay', 'APPROVED', 1, '2026-08-16 14:27:53', '', '2026-08-16 14:27:19');

-- --------------------------------------------------------

--
-- Table structure for table `luong_salary_complaint`
--

DROP TABLE IF EXISTS `luong_salary_complaint`;
CREATE TABLE IF NOT EXISTS `luong_salary_complaint` (
  `id` int NOT NULL AUTO_INCREMENT,
  `salary_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `manager_response` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reviewed_by_user_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reviewed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_salary_complaint_salary` (`salary_id`),
  KEY `idx_salary_complaint_user` (`user_id`),
  KEY `idx_salary_complaint_reviewer` (`reviewed_by_user_id`),
  KEY `idx_salary_complaint_status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `luong_salary_complaint`
--

INSERT INTO `luong_salary_complaint` (`id`, `salary_id`, `user_id`, `content`, `status`, `manager_response`, `reviewed_by_user_id`, `created_at`, `reviewed_at`) VALUES
(1, 4, 2, 'luong ky vay', 'RESOLVED', 'ky la ky cai gi', 4, '2026-08-16 14:30:21', '2026-08-16 14:30:45'),
(2, 3, 13, 'sao lương cao vậy', 'RESOLVED', 'Người Nhà Mà em', 6, '2026-08-17 10:34:58', '2026-08-17 10:36:15');

-- --------------------------------------------------------

--
-- Table structure for table `luong_salary_rule`
--

DROP TABLE IF EXISTS `luong_salary_rule`;
CREATE TABLE IF NOT EXISTS `luong_salary_rule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `bonus_threshold_days` int DEFAULT '15',
  `bonus_amount` decimal(15,2) DEFAULT '300000.00',
  `late_penalty` decimal(15,2) DEFAULT '20000.00',
  `absent_penalty` decimal(15,2) DEFAULT '50000.00',
  `weekend_multiplier` float DEFAULT '1.5',
  `emergency_replacement_multiplier` decimal(5,2) NOT NULL DEFAULT '1.50',
  PRIMARY KEY (`id`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `luong_salary_rule`
--

INSERT INTO `luong_salary_rule` (`id`, `branch_id`, `bonus_threshold_days`, `bonus_amount`, `late_penalty`, `absent_penalty`, `weekend_multiplier`, `emergency_replacement_multiplier`) VALUES
(1, 1, 10, 200000.00, 50000.00, 300000.00, 1.5, 1.50),
(2, 2, 10, 200000.00, 50000.00, 300000.00, 1.5, 1.50);

-- --------------------------------------------------------

--
-- Table structure for table `ns_role`
--

DROP TABLE IF EXISTS `ns_role`;
CREATE TABLE IF NOT EXISTS `ns_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hourly_wage` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ns_role`
--

INSERT INTO `ns_role` (`id`, `role_name`, `description`, `hourly_wage`) VALUES
(1, 'ADMIN', 'Quản trị viên toàn hệ thống', 0.00),
(2, 'MANAGER', 'Quản lý / Trưởng ca chi nhánh', 35000.00),
(3, 'STAFF', 'Nhân viên căn tin', 23000.00);

-- --------------------------------------------------------

--
-- Table structure for table `ns_user`
--

DROP TABLE IF EXISTS `ns_user`;
CREATE TABLE IF NOT EXISTS `ns_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `hire_date` date DEFAULT (curdate()),
  `employment_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PART_TIME',
  `reset_password_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reset_password_expiry` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `salary_coefficient` decimal(5,2) NOT NULL DEFAULT '1.00',
  `salary_coefficient_is_manual` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_phone` (`phone_number`),
  UNIQUE KEY `uq_user_email` (`email`),
  KEY `fk_user_branch` (`branch_id`),
  KEY `fk_user_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ns_user`
--

INSERT INTO `ns_user` (`id`, `password`, `full_name`, `phone_number`, `email`, `branch_id`, `role_id`, `hire_date`, `employment_type`, `reset_password_code`, `reset_password_expiry`, `is_deleted`, `deleted_at`, `salary_coefficient`, `salary_coefficient_is_manual`) VALUES
(1, '$2b$10$ZlRMXNXqac7cociyMZjG4e8h3jtqSup8OFKWujj/cEzCB0jG8xuZO', 'Nhất Duy', '0960227680', 'admin@qlcanteen.local', 1, 1, '2026-05-01', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0),
(2, '$2a$11$NIdvFJlsXER1ztrtShdMh.Y1b6mD2xfsFjAxMkglx6rvJ6k4LKf5O', 'Đặng Huy Vương', '0946258770', 'huyvuongkl@gmail.com', 1, 3, '2024-10-30', 'PART_TIME', NULL, NULL, 0, NULL, 1.50, 0),
(4, '$2b$10$rRRp294mUmNns6gRoZnXzOI8eWeHFcOXXbZEeY87IfBAWessGlJtK', 'Lê Đăng Tiền', '0967988348', 'manager1@qlcanteen.local', 1, 2, '2026-05-06', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0),
(6, '$2b$10$psNpsIOxDBHqQcBXRvSIPuxWS1dKTqFCYrZ/YROiJjMUqorBrM3.i', 'Phạm Tô Thảo Nhi', '0923708840', 'manager2@qlcanteen.local', 2, 2, '2026-05-01', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0),
(7, '$2a$11$DVfsAD5EOEYBJEs.3n38CuT/oVYyAvVSI0hbf3qr8248pkPzxoTDu', 'Phạm Lê Huy', '0983295001', 'huyvukl1234@gmail.com', 1, 3, '2026-05-01', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0),
(8, '$2a$11$kquqzTzX2w5KTkA6usbEGuq4iWLlt05fVfopUwvtCdKtG4A49e7ca', 'Nguyễn Thị Kim Ni', '0977321077', 'trungnguyenhoai@gmail.com', 3, 3, '2024-10-02', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0),
(9, '$2b$10$3/pPOOG14NNc5VsH6sTUguxoFearDlv48gA4a.koX1wUfbuY5vgz.', 'Lê Duy Trường', '0954139822', 'manager3@qlcanteen.local', 4, 2, '2026-05-01', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0),
(10, '$2b$10$Rvf33KJ/pRV7HYna3pEzpOqNMh4gySuuNrSX2P0IO9QLJbuwPxRGW', 'Mợ Thi', '0997673638', 'manager4@qlcanteen.local', 3, 2, '2026-05-01', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0),
(11, '$2b$10$rRRp294mUmNns6gRoZnXzOI8eWeHFcOXXbZEeY87IfBAWessGlJtK', 'Lê Minh Thu', '0926219547', 'thutuyen0473@gmail.com', 1, 3, '2026-05-03', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0),
(13, '$2a$11$JZf7rs1wUFcJEm.TnWAH5u28a19rjmaQO7ju1Y3ooF3pm1moPmhLK', 'Nguyễn Hoài Trung', '0945893968', 'trungnguyenhoai375@gmail.com', 2, 3, '2025-06-12', 'PART_TIME', NULL, NULL, 0, NULL, 1.50, 0),
(14, '$2a$11$DBcRiy8m0/SmVbBvjrTesu8LIbXGf1zOmnDRIzWGreStv0RCGybO2', 'Nguyễn Tuấn Tài', '0904045049', 'tai@gmail.com', 2, 3, '2026-07-23', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0),
(17, '$2a$11$2DTvLgM2YPqfCj5tthJDk.A0xPQnZli9ZFRNClJIKtxciuBA6itdW', 'Nguyen Hoai A', '0912085084', 'trung123@qlcanteen.local', 7, 2, '2026-07-29', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0),
(18, '$2a$11$J9j85QcUNQSkdvLN7JbmI.w2JSa3XyHS5nnxnLnR4Z8gNHRv9jigW', 'Nguyen Hoai  B', '0912085085', 'trung456@qlcanteen.local', 7, 3, '2026-07-29', 'PART_TIME', NULL, NULL, 0, NULL, 1.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ns_user_bank_account`
--

DROP TABLE IF EXISTS `ns_user_bank_account`;
CREATE TABLE IF NOT EXISTS `ns_user_bank_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `bank_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bank_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ns_user_bank_account`
--

INSERT INTO `ns_user_bank_account` (`id`, `user_id`, `bank_name`, `bank_account_number`, `bank_account_name`) VALUES
(1, 1, 'BIDV', '402501652580', 'NHAT DUY'),
(2, 2, 'Vietcombank', '687593586857', 'DANG HUY VUONG'),
(3, 4, 'VPBank', '136760652429', 'LE DANG TIEN'),
(4, 6, 'Sacombank', '957248611757', 'PHAM TO THAO NHI'),
(5, 7, 'VPBank', '674039598076', 'PHAM LE HUY'),
(6, 8, 'Vietcombank', '975168513199', 'NGUYEN THI KIM NI'),
(7, 9, 'VietinBank', '507895169156', 'LE DUY TRUONG'),
(8, 10, 'VPBank', '420055070003', 'MO THI'),
(9, 11, 'Techcombank', '810444769043', 'LE MINH THU'),
(10, 13, 'TP bank', '04166614101', 'Nguyen Hoai Trung');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ca_attendance`
--
ALTER TABLE `ca_attendance`
  ADD CONSTRAINT `fk_att_salary` FOREIGN KEY (`salary_id`) REFERENCES `luong_monthly_salary` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_att_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `ca_final_schedule` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ca_branch_shift_config`
--
ALTER TABLE `ca_branch_shift_config`
  ADD CONSTRAINT `fk_config_shift` FOREIGN KEY (`shift_id`) REFERENCES `ca_shift` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `ca_checkout_request`
--
ALTER TABLE `ca_checkout_request`
  ADD CONSTRAINT `fk_checkout_request_attendance` FOREIGN KEY (`attendance_id`) REFERENCES `ca_attendance` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_checkout_request_reviewer` FOREIGN KEY (`reviewed_by_user_id`) REFERENCES `ns_user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_checkout_request_user` FOREIGN KEY (`requested_by_user_id`) REFERENCES `ns_user` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `ca_checkout_request_history`
--
ALTER TABLE `ca_checkout_request_history`
  ADD CONSTRAINT `fk_checkout_history_actor` FOREIGN KEY (`actor_user_id`) REFERENCES `ns_user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_checkout_history_request` FOREIGN KEY (`request_id`) REFERENCES `ca_checkout_request` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ca_final_schedule`
--
ALTER TABLE `ca_final_schedule`
  ADD CONSTRAINT `fk_final_absence_manager` FOREIGN KEY (`absence_marked_by_user_id`) REFERENCES `ns_user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_final_assigned_manager` FOREIGN KEY (`assigned_by_user_id`) REFERENCES `ns_user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_final_period` FOREIGN KEY (`period_id`) REFERENCES `ca_schedule_period` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_final_replaces_schedule` FOREIGN KEY (`replaces_schedule_id`) REFERENCES `ca_final_schedule` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_final_shift` FOREIGN KEY (`shift_id`) REFERENCES `ca_shift` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_final_source_registration` FOREIGN KEY (`source_registration_id`) REFERENCES `ca_staff_registration` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_final_user` FOREIGN KEY (`user_id`) REFERENCES `ns_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ca_shift`
--
ALTER TABLE `ca_shift`
  ADD CONSTRAINT `fk_branch_shift` FOREIGN KEY (`branch_id`) REFERENCES `dm_branch` (`id`);

--
-- Constraints for table `ca_staff_registration`
--
ALTER TABLE `ca_staff_registration`
  ADD CONSTRAINT `fk_reg_period` FOREIGN KEY (`period_id`) REFERENCES `ca_schedule_period` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_reg_shift` FOREIGN KEY (`shift_id`) REFERENCES `ca_shift` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reg_user` FOREIGN KEY (`user_id`) REFERENCES `ns_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ca_supplemental_attendance_request`
--
ALTER TABLE `ca_supplemental_attendance_request`
  ADD CONSTRAINT `fk_supplemental_admin` FOREIGN KEY (`reviewed_by_admin_id`) REFERENCES `ns_user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_supplemental_manager` FOREIGN KEY (`requested_by_manager_id`) REFERENCES `ns_user` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_supplemental_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `ca_final_schedule` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kho_export_ticket`
--
ALTER TABLE `kho_export_ticket`
  ADD CONSTRAINT `fk_exp_branch` FOREIGN KEY (`branch_id`) REFERENCES `dm_branch` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_exp_manager` FOREIGN KEY (`manager_id`) REFERENCES `ns_user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_export_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `ca_final_schedule` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `luong_salary_rule`
--
ALTER TABLE `luong_salary_rule`
  ADD CONSTRAINT `luong_salary_rule_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `dm_branch` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
