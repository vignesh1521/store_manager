-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 04, 2025 at 02:04 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `store`
--

-- --------------------------------------------------------

--
-- Table structure for table `store_items`
--

CREATE TABLE `store_items` (
  `item_no` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `quantity` int(255) NOT NULL,
  `price` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_items`
--

INSERT INTO `store_items` (`item_no`, `name`, `type`, `quantity`, `price`) VALUES
(1, 'clinic plus', 'Shampoo', 24, 1),
(2, 'bread', 'Dairy & Groceries', 15, 50),
(3, 'butter', 'Dairy & Groceries', 8, 200),
(4, 'eggs', 'Dairy & Groceries', 30, 5),
(5, 'cheese', 'Dairy & Groceries', 12, 150),
(6, 'apples', 'Fruits & Vegetables', 20, 30),
(7, 'bananas', 'Fruits & Vegetables', 25, 20),
(8, 'chicken', 'Dairy & Groceries', 5, 300),
(9, 'rice', 'Dairy & Groceries', 18, 80),
(10, 'pasta', 'Dairy & Groceries', 10, 70),
(11, 'tomatoes', 'Fruits & Vegetables', 22, 40),
(12, 'oranges', 'Fruits & Vegetables', 15, 35),
(13, 'grapes', 'Fruits & Vegetables', 10, 60),
(14, 'watermelon', 'Fruits & Vegetables', 5, 100),
(15, 'pineapple', 'Fruits & Vegetables', 7, 90),
(16, 'mangoes', 'Fruits & Vegetables', 12, 80),
(17, 'strawberries', 'Fruits & Vegetables', 8, 120),
(18, 'pears', 'Fruits & Vegetables', 14, 40),
(19, 'kiwi', 'Fruits & Vegetables', 9, 70),
(20, 'pomegranates', 'Fruits & Vegetables', 6, 150),
(21, 'cherries', 'Fruits & Vegetables', 10, 200),
(22, 'soap', 'Health & Hygiene', 20, 25),
(23, 'toothpaste', 'Health & Hygiene', 15, 50),
(24, 'shampoo', 'Health & Hygiene', 10, 100),
(25, 'painkillers', 'Health & Hygiene', 30, 10),
(26, 'band-aids', 'Health & Hygiene', 25, 5),
(27, 'antiseptic', 'Health & Hygiene', 12, 80),
(28, 'cold syrup', 'Health & Hygiene', 8, 60),
(29, 'cough drops', 'Health & Hygiene', 20, 15),
(30, 'strawberry', 'Fruits', 100, 12),
(31, 'moisturizer', 'Health & Hygiene', 10, 120),
(42, 'bomb', 'Cracekrs', 12, 12),
(43, 'cream', 'Food', 23, 10),
(44, 'lead', 'Pen', 12, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `store_items`
--
ALTER TABLE `store_items`
  ADD PRIMARY KEY (`item_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `store_items`
--
ALTER TABLE `store_items`
  MODIFY `item_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
