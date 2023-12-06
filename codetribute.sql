-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 06, 2023 at 04:00 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codetribute`
--

-- --------------------------------------------------------

--
-- Table structure for table `commitbase`
--

CREATE TABLE `commitbase` (
  `commit_id` varchar(10) NOT NULL,
  `contributor_id` varchar(3) NOT NULL,
  `commit_path` varchar(500) NOT NULL,
  `project_id` varchar(10) NOT NULL,
  `commit_status` varchar(10) NOT NULL DEFAULT 'Pending',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `commitbase`
--

INSERT INTO `commitbase` (`commit_id`, `contributor_id`, `commit_path`, `project_id`, `commit_status`, `timestamp`) VALUES
('Comit59961', 'C01', 'https://sepolia.etherscan.io/tokeen/0xe2ca36365e40e81a8185bb8986d662501df5f6f2', 'Project4', 'Accepted', '2023-11-18 13:30:34'),
('Commit1', 'C01', 'https://fefgergre.com', 'Project5', 'Accepted', '2023-10-27 08:44:13'),
('Commit3', 'C08', 'https://drive.google.com/file/d/1GjegepX80KVdvLCLkTfMxRBfiG6xP4On/view', 'Project5', 'Accepted', '2023-10-27 04:49:39'),
('Commit3566', 'C02', 'bherhetrhrbrb', 'Project79', 'Pending', '2023-12-06 07:47:21'),
('wefwe', 'C01', 'ewfef', 'Project5', 'Accepted', '2023-11-03 15:03:29');

--
-- Triggers `commitbase`
--
DELIMITER $$
CREATE TRIGGER `commitbaseTriggerDelete` AFTER DELETE ON `commitbase` FOR EACH ROW BEGIN
  DECLARE sql_text LONGTEXT;

  SELECT CONCAT('DELETE FROM commitbase WHERE commit_id = ', OLD.commit_id, ';')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (OLD.contributor_id, 'DELETE', 'commitbase', sql_text);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `commitbaseTriggerInsert` AFTER INSERT ON `commitbase` FOR EACH ROW BEGIN
  -- Declare a variable to store the SQL statement
  DECLARE sql_text LONGTEXT;

  -- Get the full SQL statement from information_schema
  SELECT CONCAT('INSERT INTO commitbase (commit_id, contributor_id, commit_path, project_id) VALUES (', NEW.commit_id, ', ', NEW.contributor_id, ', ', NEW.commit_path, ', ', NEW.project_id, ');')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  -- Insert data from the NEW row into transaction_log
  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (NEW.contributor_id, 'INSERT', 'commitbase', sql_text);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `commitbaseTriggerUpdate` AFTER UPDATE ON `commitbase` FOR EACH ROW BEGIN
  DECLARE sql_text LONGTEXT;

  SELECT CONCAT('UPDATE commitbase SET commit_id = ', NEW.commit_id, ', contributor_id = ', NEW.contributor_id, ', commit_path = ', NEW.commit_path, ', project_id = ', NEW.project_id, ', commit_status = ', NEW.commit_status, ', timestamp = ', NEW.timestamp, ' WHERE commit_id = ', OLD.commit_id, ';')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (NEW.contributor_id, 'UPDATE', 'commitbase', sql_text);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `transaction_id` varchar(64) NOT NULL,
  `sender_user_id` varchar(3) NOT NULL,
  `receiver_user_id` varchar(3) NOT NULL,
  `amount` int(11) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`transaction_id`, `sender_user_id`, `receiver_user_id`, `amount`, `timestamp`) VALUES
('4d6e0b140bc3e81e1cd95f51c4989f3a4a742eb4', 'A01', 'P25', 499, '2023-12-05 16:46:28'),
('56e055f2a2103a625ab444f80b942e33ef61462f', 'P25', 'C01', 12000, '2023-12-05 15:50:16'),
('ec9925fa46e5a956a140626d97b312c47befd2f9', 'C01', 'P25', 2000, '2023-12-05 15:48:12');

--
-- Triggers `payments`
--
DELIMITER $$
CREATE TRIGGER `paymentTrigger` AFTER INSERT ON `payments` FOR EACH ROW BEGIN
  -- Declare a variable to store the SQL statement
  DECLARE sql_text LONGTEXT;

  -- Get the full SQL statement from information_schema
  SELECT CONCAT('INSERT INTO payments (sender_user_id, receiver_user_id, amount) VALUES (', NEW.sender_user_id, ', ', NEW.receiver_user_id, ', ', NEW.amount, ');')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  -- Insert data from the NEW row into transaction_log
  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (NEW.sender_user_id, 'INSERT', 'payments', sql_text);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `paymentTriggerDelete` AFTER DELETE ON `payments` FOR EACH ROW BEGIN
  DECLARE sql_text LONGTEXT;

  SELECT CONCAT('DELETE FROM payments WHERE transaction_id = ', OLD.transaction_id, ';')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (OLD.sender_user_id, 'DELETE', 'payments', sql_text);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `paymentTriggerUpdate` AFTER UPDATE ON `payments` FOR EACH ROW BEGIN
  DECLARE sql_text LONGTEXT;

  SELECT CONCAT('UPDATE payments SET sender_user_id = ', NEW.sender_user_id, ', receiver_user_id = ', NEW.receiver_user_id, ', amount = ', NEW.amount, ', timestamp = ', NEW.timestamp, ' WHERE transaction_id = ', OLD.transaction_id, ';')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (NEW.sender_user_id, 'UPDATE', 'payments', sql_text);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `projectbase`
--

CREATE TABLE `projectbase` (
  `project_id` varchar(10) NOT NULL,
  `project_name` varchar(100) NOT NULL,
  `project_description` varchar(500) NOT NULL,
  `publisher_id` varchar(3) NOT NULL,
  `code_path` varchar(500) NOT NULL,
  `tokens_offered` int(11) NOT NULL DEFAULT 0,
  `tokens_required` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `projectbase`
--

INSERT INTO `projectbase` (`project_id`, `project_name`, `project_description`, `publisher_id`, `code_path`, `tokens_offered`, `tokens_required`) VALUES
('Project4', 'Stack Underflow', 'Asewvrevin', 'P25', 'https://chat.openai.com/c/286135cf-55d4-45c3-9ae4-029ee44dd9ef', 300, 200),
('Project5', 'CodSoft', 'Internship projects', 'P25', 'https://github.com/ahmed-develops/CODSOFT', 300, 200),
('Project79', 'Blind can see', 'A device made to assist blind people with hearing and seeing.', 'P05', 'http://localhost/phpmyadmin/index.php?route=/sql&pos=0&db=codetribute&table=projectbase', 0, 0);

--
-- Triggers `projectbase`
--
DELIMITER $$
CREATE TRIGGER `projectbaseTriggerDelete` AFTER DELETE ON `projectbase` FOR EACH ROW BEGIN
  DECLARE sql_text LONGTEXT;

  SELECT CONCAT('DELETE FROM projectbase WHERE project_id = ', OLD.project_id, ';')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (OLD.publisher_id, 'DELETE', 'projectbase', sql_text);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `projectbaseTriggerInsert` AFTER INSERT ON `projectbase` FOR EACH ROW BEGIN
  -- Declare a variable to store the SQL statement
  DECLARE sql_text LONGTEXT;

  -- Get the full SQL statement from information_schema
  SELECT CONCAT('INSERT INTO project (project_id, project_name, project_description, publisher_id, code_path, tokens_offered, tokens_required) VALUES (', NEW.project_id, ', ', NEW.project_name, ', ', NEW.project_description, ', ', NEW.publisher_id, ', ', NEW.code_path, ', ', NEW.tokens_offered, ', ', NEW.tokens_required, ');')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  -- Insert data from the NEW row into transaction_log
  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (NEW.publisher_id, 'INSERT', 'projectbase', sql_text);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `projectbaseTriggerUpdate` AFTER UPDATE ON `projectbase` FOR EACH ROW BEGIN
  DECLARE sql_text LONGTEXT;

  SELECT CONCAT('UPDATE projectbase SET project_name = ', NEW.project_name, ', project_description = ', NEW.project_description, ', publisher_id = ', NEW.publisher_id, ', code_path = ', NEW.code_path, ', tokens_offered = ', NEW.tokens_offered, ', tokens_required = ', NEW.tokens_required, ' WHERE project_id = ', OLD.project_id, ';')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (NEW.publisher_id, 'UPDATE', 'projectbase', sql_text);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_log`
--

CREATE TABLE `transaction_log` (
  `log_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `actor_id` varchar(3) DEFAULT NULL,
  `operation_type` varchar(50) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `query` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction_log`
--

INSERT INTO `transaction_log` (`log_id`, `timestamp`, `actor_id`, `operation_type`, `table_name`, `query`) VALUES
(27, '2023-12-05 10:48:12', 'C01', 'INSERT', 'payments', 'INSERT INTO payments (sender_user_id, receiver_user_id, amount) VALUES (C01, P25, 2000);'),
(28, '2023-12-05 10:50:16', 'P25', 'INSERT', 'payments', 'INSERT INTO payments (sender_user_id, receiver_user_id, amount) VALUES (P25, C01, 12000);'),
(29, '2023-12-05 11:29:32', 'P81', 'INSERT', 'users', 'INSERT INTO users (user_id, name, email, password, phone_number, privilege) VALUES (P81, Jahangir, jahangir@jahangir.com, imbatman12340, 03362175634, Publisher);'),
(30, '2023-12-05 11:46:28', 'A01', 'INSERT', 'payments', 'INSERT INTO payments (sender_user_id, receiver_user_id, amount) VALUES (A01, P25, 499);'),
(31, '2023-12-05 16:43:05', 'A01', 'INSERT', 'payments', 'INSERT INTO payments (sender_user_id, receiver_user_id, amount) VALUES (A01, C01, 99);'),
(32, '2023-12-05 16:44:44', 'P77', 'INSERT', 'users', 'INSERT INTO users (user_id, name, email, password, phone_number, privilege) VALUES (P77, Philipp Lahm, philipp@lahm.com, 123456789, 92435435435, Publisher);'),
(33, '2023-12-06 07:32:16', 'P01', 'INSERT', 'walletbase', 'INSERT INTO walletbase (user_id, wallet_address) VALUES (P01, 0x6DCFbB4a4BF7E2f41981f540694267D074e71730);'),
(34, '2023-12-06 07:42:50', 'P05', 'INSERT', 'projectbase', 'INSERT INTO project (project_id, project_name, project_description, publisher_id, code_path, tokens_offered, tokens_required) VALUES (Project79, Blind can see, A device made to assist blind people with hearing and seeing., P05, http://localhost/phpmyadmin/index.php?route=/sql&pos=0&db=codetribute&table=projectbase, 0, 0);'),
(35, '2023-12-06 07:47:21', 'C02', 'INSERT', 'commitbase', 'INSERT INTO commitbase (commit_id, contributor_id, commit_path, project_id) VALUES (Commit3566, C02, bherhetrhrbrb, Project79);'),
(36, '2023-12-06 09:18:04', 'C07', 'INSERT', 'commitbase', 'INSERT INTO commitbase (commit_id, contributor_id, commit_path, project_id) VALUES (Commit675, C07, rwegerge, Project8);'),
(37, '2023-12-06 09:19:24', 'C01', 'UPDATE', 'commitbase', 'UPDATE commitbase SET commit_id = Comit5996, contributor_id = C01, commit_path = https://sepolia.etherscan.io/token/0xe2ca36365e40e81a8185bb8986d662501df5f6f22432432, project_id = Project4, commit_status = Accepted, timestamp = 2023-11-18 18:26:29 WHERE commit_id = Comit5996;'),
(38, '2023-12-06 09:21:31', 'C01', 'DELETE', 'commitbase', 'DELETE FROM commitbase WHERE commit_id = Comit5996;'),
(39, '2023-12-06 10:57:53', 'A01', 'UPDATE', 'payments', 'UPDATE payments SET sender_user_id = A01, receiver_user_id = C01, amount = 91, timestamp = 2023-12-05 21:43:05 WHERE transaction_id = 1b91584e3a02badbfbf5d74fc987a3efa446ec50;'),
(40, '2023-12-06 10:59:39', 'A01', 'DELETE', 'payments', 'DELETE FROM payments WHERE transaction_id = 1b91584e3a02badbfbf5d74fc987a3efa446ec50;'),
(41, '2023-12-06 11:00:50', 'P02', 'UPDATE', 'projectbase', 'UPDATE projectbase SET project_name = App Development Toolkitfwef, project_description = C++, publisher_id = P02, code_path = https://github.com/ahmed-develops/MERN/tree/main/server, tokens_offered = 300, tokens_required = 200 WHERE project_id = Project1;'),
(42, '2023-12-06 11:01:32', 'P02', 'DELETE', 'projectbase', 'DELETE FROM projectbase WHERE project_id = Project1;'),
(43, '2023-12-06 11:02:58', 'A01', 'UPDATE', 'users', 'UPDATE users SET name = Muhammad Ahmed, email = k213161@nu.edu.pk, password = manutd:*1, phone_number = 923052976751, privilege = admin, status = Active WHERE user_id = A01;'),
(48, '2023-12-06 11:45:59', 'P25', 'DELETE', 'projectbase', 'DELETE FROM projectbase WHERE project_id = Project8;'),
(49, '2023-12-06 13:26:26', 'P25', 'UPDATE', 'projectbase', 'UPDATE projectbase SET project_name = ergerg, project_description = ergterytery, publisher_id = P25, code_path = grerghterhgeg, tokens_offered = 300, tokens_required = 200 WHERE project_id = Project3;'),
(50, '2023-12-06 13:27:14', 'P25', 'UPDATE', 'projectbase', 'UPDATE projectbase SET project_name = wefwefwef, project_description = rgtergtr, publisher_id = P25, code_path = bbrttrbtr, tokens_offered = 300, tokens_required = 200 WHERE project_id = Project3;'),
(51, '2023-12-06 13:49:37', 'P25', 'UPDATE', 'projectbase', 'UPDATE projectbase SET project_name = 1111111111111, project_description = 111111111111111, publisher_id = P25, code_path = htttps:wsefwefwef, tokens_offered = 300, tokens_required = 200 WHERE project_id = Project3;'),
(52, '2023-12-06 14:33:43', 'P25', 'DELETE', 'projectbase', 'DELETE FROM projectbase WHERE project_id = Project2;'),
(53, '2023-12-06 14:33:54', 'P25', 'DELETE', 'projectbase', 'DELETE FROM projectbase WHERE project_id = Project3;'),
(54, '2023-12-06 14:35:05', 'C01', 'UPDATE', 'users', 'UPDATE users SET name = Muhammad Shaheer, email = k213323@nu.edu.pk, password = naiver, phone_number = 923410286680, privilege = contributor, status = Suspended WHERE user_id = C01;'),
(55, '2023-12-06 14:35:12', 'P25', 'UPDATE', 'users', 'UPDATE users SET name = Rohan Shergil, email = k234041@nu.edu.pk, password = khalid1, phone_number = 927765843117, privilege = Publisher, status = Suspended WHERE user_id = P25;');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` varchar(3) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(16) NOT NULL,
  `phone_number` varchar(12) DEFAULT NULL,
  `privilege` varchar(11) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `phone_number`, `privilege`, `status`) VALUES
('A01', 'Muhammad Ahmed', 'k213161@nu.edu.pk', 'manutd:*1', '923052976751', 'admin', 'Active'),
('C01', 'Muhammad Shaheer', 'k213323@nu.edu.pk', 'naiver', '923410286680', 'contributor', 'Suspended'),
('C02', 'Zain Ali', 'k214870@nu.edu.pk', 'mostnaive', '923219216325', 'contributor', 'Suspended'),
('C07', 'Cristiano Ronadaldo', 'k236969@nu.edu.pk', 'siuuuuuuuuu', '927765843169', 'Contributor', 'Suspended'),
('C08', 'Babar Ashraf', 'k213202@nu.edu.pk', 'manutd:*', '923410286689', 'Contributor', 'Suspended'),
('C10', 'Fahad Ahmed', 'k214926@nu.edu.pk', 'niggafahad', '923009216325', 'Contributor', 'Active'),
('C11', 'Owais Ali2', 'k213298@nu.edu.pk', 'hammas', '921234567890', 'Contributor', 'Active'),
('C12', 'Ammad Hasan', 'k213218@nu.edu.pk', 'hammas', '921234567899', 'Contributor', 'Active'),
('C13', 'Mohammad Ali', 'k213228@nu.edu.pk', 'hammas', '921234567897', 'Contributor', 'Active'),
('C15', 'Mohammad Asif', 'k214258@nu.edu.pk', 'hammas', '921234567891', 'Contributor', 'Active'),
('C19', 'Garfield Sobers', 'k213341@nu.edu.pk', 'johnnysins', '92876545321', 'contributor', 'Active'),
('C26', 'Ole Saeter', 'ole@saeter.com', 'harunhamid', '03045256246', 'Contributor', 'Active'),
('C69', 'Johnny Bravo', 'johnny@bravo.com', 'johnny', '12345667765', 'Contributor', 'Active'),
('C78', 'Rajesh', 'rajesh@rajesh.com', 'password', '21434234234', 'Contributor', 'Active'),
('C85', 'Hannah', 'hannah@hannah.com', 'imgood', '34425245', 'Contributor', 'Active'),
('P01', 'Muhammad Anas', 'k214556@nu.edu.pk', 'naive', '923362171607', 'publisher', 'Active'),
('P02', 'Taqi Baqir', 'k213175@nu.edu.pk', 'leastnaive', '923229216325', 'publisher', 'Active'),
('P05', 'Zafar Khan', 'k204566@nu.edu.pk', 'localhoster', '923331112223', 'publisher', 'Active'),
('P06', 'Rehan Ahmed', 'k234495@nu.edu.pk', 'qwerty01', '924445687436', 'Publisher', 'Active'),
('P09', 'Saud Shakeel', 'k217445@nu.edu.pk', 'khalid', '927765843109', 'Publisher', 'Active'),
('P19', 'Khan Ali', 'k237145@nu.edu.pk', 'khalid', '927765843101', 'Publisher', 'Active'),
('P20', 'Jamshed Akbar', 'k214145@nu.edu.pk', 'khalid', '927765843108', 'Publisher', 'Active'),
('P25', 'Rohan Shergil', 'k234041@nu.edu.pk', 'khalid1', '927765843117', 'Publisher', 'Suspended'),
('P26', 'Harun Hamid', 'haroon@hamid.com', 'imadwasim', '03045235763', 'Publisher', 'Suspended'),
('P34', 'ahmed shakeel', 'ahmed@shakeel.com', 'manutd', '13245325234', 'Publisher', 'Active'),
('P44', 'Kemra', 'kemra@gmail.com', 'sfwefwe', '332523524542', 'Publisher', 'Active'),
('P56', 'Haroon Khan', 'haroon@khan.com', 'wqwefewf', '2143242432', 'Publisher', 'Active'),
('P76', 'Kamran Ghulam', 'kamran@ghulam.com', 'fwefwef', '13241341', 'Publisher', 'Active'),
('P77', 'Philipp Lahm', 'philipp@lahm.com', '123456789', '92435435435', 'Publisher', 'Active'),
('P81', 'Jahangir', 'jahangir@jahangir.com', 'imbatman12340', '03362175634', 'Publisher', 'Active'),
('P86', 'Ali', 'ali@ali.com', 'fewfwe', '342352', 'Publisher', 'Active'),
('P87', 'Yahya', 'yahya@yahya.com', 'nucesfast', '923456753451', 'Publisher', 'Active'),
('P90', 'Graves', 'graves@graves.com', 'graves', '24235346534', 'Publisher', 'Active'),
('P99', 'Khanna', 'khanna@khanna.com', 'johnny', '2412343215', 'Publisher', 'Active');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `usersTriggerDelete` AFTER DELETE ON `users` FOR EACH ROW BEGIN
  DECLARE sql_text LONGTEXT;

  SELECT CONCAT('DELETE FROM users WHERE user_id = ', OLD.user_id, ';')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (OLD.user_id, 'DELETE', 'users', sql_text);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `usersTriggerInsert` AFTER INSERT ON `users` FOR EACH ROW BEGIN
  DECLARE sql_text LONGTEXT;

  SELECT CONCAT('INSERT INTO users (user_id, name, email, password, phone_number, privilege) VALUES (', NEW.user_id, ', ', NEW.name, ', ', NEW.email, ', ', NEW.password, ', ', NEW.phone_number, ', ', NEW.privilege, ');')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (NEW.user_id, 'INSERT', 'users', sql_text);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `usersTriggerUpdate` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
  DECLARE sql_text LONGTEXT;

  SELECT CONCAT('UPDATE users SET name = ', NEW.name, ', email = ', NEW.email, ', password = ', NEW.password, ', phone_number = ', NEW.phone_number, ', privilege = ', NEW.privilege, ', status = ', NEW.status, ' WHERE user_id = ', OLD.user_id, ';')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (NEW.user_id, 'UPDATE', 'users', sql_text);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `walletbase`
--

CREATE TABLE `walletbase` (
  `user_id` varchar(3) NOT NULL,
  `wallet_address` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `walletbase`
--

INSERT INTO `walletbase` (`user_id`, `wallet_address`) VALUES
('A01', '0xD3CECBC2de13f1eE2f381f5cF0C7864A8108f937'),
('C01', '0xe165c933Fb9d5aAB5c113c2B99C594FcDC4E2A42'),
('P01', '0x6DCFbB4a4BF7E2f41981f540694267D074e71730'),
('P25', '0x118De23b4A3d1bD029b454C9c4a2B10Ee00218C7');

--
-- Triggers `walletbase`
--
DELIMITER $$
CREATE TRIGGER `walletbaseTriggerInsert` AFTER INSERT ON `walletbase` FOR EACH ROW BEGIN
  -- Declare a variable to store the SQL statement
  DECLARE sql_text LONGTEXT;

  -- Get the full SQL statement from information_schema
  SELECT CONCAT('INSERT INTO walletbase (user_id, wallet_address) VALUES (', NEW.user_id, ', ', NEW.wallet_address, ');')
  INTO sql_text
  FROM information_schema.processlist
  WHERE id = CONNECTION_ID();

  -- Insert data from the NEW row into transaction_log
  INSERT INTO transaction_log (actor_id, operation_type, table_name, query)
  VALUES (NEW.user_id, 'INSERT', 'walletbase', sql_text);
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `commitbase`
--
ALTER TABLE `commitbase`
  ADD PRIMARY KEY (`commit_id`),
  ADD UNIQUE KEY `commit_path` (`commit_path`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `contributor_id` (`contributor_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `receiver_user_id_fk` (`receiver_user_id`),
  ADD KEY `sender_user_id_fk` (`sender_user_id`);

--
-- Indexes for table `projectbase`
--
ALTER TABLE `projectbase`
  ADD PRIMARY KEY (`project_id`),
  ADD KEY `publisher_id` (`publisher_id`);

--
-- Indexes for table `transaction_log`
--
ALTER TABLE `transaction_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`actor_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `unique_email` (`email`),
  ADD UNIQUE KEY `email_unique` (`email`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- Indexes for table `walletbase`
--
ALTER TABLE `walletbase`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transaction_log`
--
ALTER TABLE `transaction_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `commitbase`
--
ALTER TABLE `commitbase`
  ADD CONSTRAINT `commitbase_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projectbase` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `commitbase_ibfk_2` FOREIGN KEY (`contributor_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `receiver_user_id_fk` FOREIGN KEY (`receiver_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sender_user_id_fk` FOREIGN KEY (`sender_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `projectbase`
--
ALTER TABLE `projectbase`
  ADD CONSTRAINT `projectbase_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction_log`
--
ALTER TABLE `transaction_log`
  ADD CONSTRAINT `transaction_log_ibfk_1` FOREIGN KEY (`actor_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `walletbase`
--
ALTER TABLE `walletbase`
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
