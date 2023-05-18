-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 18, 2023 at 04:45 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tellnotes`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `ContactID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Name` varchar(25) NOT NULL,
  `LastName` varchar(25) DEFAULT NULL,
  `Numb` varchar(12) NOT NULL,
  `Relation` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`ContactID`, `UserID`, `Name`, `LastName`, `Numb`, `Relation`) VALUES
(2, 1, 'Ali', 'Rezavand', '09123456789', 'Family'),
(3, 1, 'Ahmad', 'Fatehi', '09214456789', 'Friend'),
(4, 1, 'Saleh', 'moghadam', '09213241892', 'Family'),
(5, 1, 'Ehsan', 'Salehi', '0931412482', 'Business'),
(6, 2, 'reza', 'moslehi', '09245130592', 'Family'),
(7, 2, 'mohsen', 'Mokhtari', '09857175283', 'Friend'),
(8, 2, 'karim', 'namosalmon', '03952850632', 'Friend'),
(9, 2, 'fazel', 'behrang', '09512353941', 'Business'),
(11, 1, 'Pedar', 'NULL', '09123349852', 'Family');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UsersID` int(11) NOT NULL,
  `UserName` varchar(25) NOT NULL,
  `Password` varchar(25) NOT NULL,
  `Email` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UsersID`, `UserName`, `Password`, `Email`) VALUES
(1, 'Mordor', '@#Razzaz2019', 'Mordor@gmail.com'),
(2, 'Androo', '@#Androo2019', 'Androo@gmail.com'),
(13, 'younes', '123456789yyy', NULL),
(14, 'usertest', '1234', 'test@gmail.com'),
(15, 'ahmad', '1234', 'ahmad@gmail.com'),
(16, 'hani', '1234', 'www.@hani.com'),
(17, 'Ali', '1234', 'Ali@gamail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`ContactID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UsersID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `ContactID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UsersID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UsersID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
