-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Dec 05, 2024 at 12:09 PM
-- Server version: 8.0.40
-- PHP Version: 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `taghi_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `access_permissions`
--

CREATE TABLE `access_permissions` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `door_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `access_permissions`
--

INSERT INTO `access_permissions` (`id`, `user_id`, `door_id`) VALUES
(1, 3, 7),
(2, 5, 11),
(3, 7, 7),
(4, 7, 11),
(5, 9, 7),
(6, 9, 8),
(7, 9, 11),
(8, 9, 12),
(9, 11, 7),
(10, 11, 8),
(11, 11, 11),
(12, 11, 12);

-- --------------------------------------------------------

--
-- Table structure for table `doors`
--

CREATE TABLE `doors` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `doors`
--

INSERT INTO `doors` (`id`, `name`) VALUES
(7, '1-1'),
(8, '1-2'),
(11, '2-1'),
(12, '2-2');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `door_id` int NOT NULL,
  `status` enum('pending','approved','denied') NOT NULL DEFAULT 'pending',
  `request_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'request creation Timestamp',
  `decision_time` timestamp NULL DEFAULT NULL COMMENT 'Time when the request was approved/denied',
  `handled_by` int DEFAULT NULL COMMENT 'Security person who handled the request'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `user_id`, `door_id`, `status`, `request_time`, `decision_time`, `handled_by`) VALUES
(1, 3, 7, 'pending', '2024-12-05 12:08:16', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` enum('normal','security') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(3, 'un1', '1', 'normal'),
(5, 'un2', '2', 'normal'),
(7, 'un3', '3', 'normal'),
(9, 'us1', '1', 'security'),
(11, 'us2', '2', 'security');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `access_permissions`
--
ALTER TABLE `access_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `access_permissions.user_id Foreign Key to users.id` (`user_id`),
  ADD KEY `access_permissions.door_id Foreign Key to doors.id` (`door_id`);

--
-- Indexes for table `doors`
--
ALTER TABLE `doors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `requests.door_id Foreign Key to doors.id` (`door_id`),
  ADD KEY `requests.handled_by Foreign Key to users.id` (`handled_by`),
  ADD KEY `requests.user_id Foreign Key to users.id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `access_permissions`
--
ALTER TABLE `access_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `doors`
--
ALTER TABLE `doors`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `access_permissions`
--
ALTER TABLE `access_permissions`
  ADD CONSTRAINT `access_permissions.door_id Foreign Key to doors.id` FOREIGN KEY (`door_id`) REFERENCES `doors` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `access_permissions.user_id Foreign Key to users.id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `requests`
--
ALTER TABLE `requests`
  ADD CONSTRAINT `requests.door_id Foreign Key to doors.id` FOREIGN KEY (`door_id`) REFERENCES `doors` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `requests.handled_by Foreign Key to users.id` FOREIGN KEY (`handled_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `requests.user_id Foreign Key to users.id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
