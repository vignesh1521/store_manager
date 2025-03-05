-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 05, 2025 at 02:36 AM
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
) ;

--
-- Dumping data for table `store_items`
--

INSERT INTO `store_items` (`item_no`, `name`, `type`, `quantity`, `price`) VALUES
(2, 'bread', 'Dairy & groceries', 15, 50),
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
(27, 'antiseptic', 'Health & Hygiene', 11, 80),
(28, 'cold syrup', 'Health & Hygiene', 5, 60),
(29, 'flour', 'Dairy & Groceries', 18, 45),
(30, 'sugar', 'Dairy & Groceries', 22, 60),
(31, 'salt', 'Dairy & Groceries', 25, 20),
(32, 'pepper', 'Dairy & Groceries', 15, 50),
(33, 'olive oil', 'Dairy & Groceries', 12, 250),
(34, 'sunflower oil', 'Dairy & Groceries', 10, 200),
(35, 'milk', 'Dairy & Groceries', 30, 40),
(36, 'yogurt', 'Dairy & Groceries', 20, 80),
(37, 'honey', 'Dairy & Groceries', 12, 300),
(38, 'jam', 'Dairy & Groceries', 14, 150),
(39, 'peanut butter', 'Dairy & Groceries', 10, 180),
(40, 'biscuits', 'Snacks & Beverages', 30, 50),
(41, 'cookies', 'Snacks & Beverages', 25, 70),
(42, 'potato chips', 'Snacks & Beverages', 20, 60),
(43, 'popcorn', 'Snacks & Beverages', 18, 90),
(44, 'instant noodles', 'Snacks & Beverages', 22, 40),
(45, 'coffee', 'Snacks & Beverages', 15, 200),
(46, 'tea', 'Snacks & Beverages', 18, 150),
(47, 'soft drink', 'Snacks & Beverages', 20, 50),
(48, 'energy drink', 'Snacks & Beverages', 12, 120),
(49, 'juice', 'Snacks & Beverages', 18, 80),
(50, 'almonds', 'Snacks & Beverages', 10, 400),
(51, 'cashews', 'Snacks & Beverages', 12, 450),
(52, 'walnuts', 'Snacks & Beverages', 8, 500),
(53, 'peanuts', 'Snacks & Beverages', 20, 200),
(54, 'raisins', 'Snacks & Beverages', 15, 350),
(55, 'spinach', 'Fruits & Vegetables', 18, 30),
(56, 'carrots', 'Fruits & Vegetables', 22, 25),
(57, 'cabbage', 'Fruits & Vegetables', 20, 35),
(58, 'cauliflower', 'Fruits & Vegetables', 15, 50),
(59, 'broccoli', 'Fruits & Vegetables', 12, 80),
(60, 'onions', 'Fruits & Vegetables', 30, 20),
(61, 'garlic', 'Fruits & Vegetables', 18, 100),
(62, 'ginger', 'Fruits & Vegetables', 12, 120),
(63, 'cucumber', 'Fruits & Vegetables', 25, 30),
(64, 'bell peppers', 'Fruits & Vegetables', 20, 60),
(65, 'zucchini', 'Fruits & Vegetables', 15, 75),
(66, 'mushrooms', 'Fruits & Vegetables', 10, 150),
(67, 'lettuce', 'Fruits & Vegetables', 12, 45),
(68, 'chicken breasts', 'Meat & Seafood', 10, 350),
(69, 'chicken drumsticks', 'Meat & Seafood', 15, 300),
(70, 'beef steak', 'Meat & Seafood', 8, 600),
(71, 'ground beef', 'Meat & Seafood', 12, 450),
(72, 'pork chops', 'Meat & Seafood', 10, 500),
(73, 'salmon', 'Meat & Seafood', 8, 700),
(74, 'shrimp', 'Meat & Seafood', 10, 650),
(75, 'tuna', 'Meat & Seafood', 12, 550),
(76, 'crab', 'Meat & Seafood', 6, 800),
(77, 'lobster', 'Meat & Seafood', 5, 1000),
(78, 'toilet paper', 'Health & Hygiene', 25, 40),
(79, 'sanitizer', 'Health & Hygiene', 20, 150),
(80, 'detergent', 'Household Supplies', 20, 150),
(81, 'dishwashing liquid', 'Household Supplies', 15, 100),
(82, 'garbage bags', 'Household Supplies', 30, 50),
(83, 'mop', 'Household Supplies', 10, 300),
(84, 'broom', 'Household Supplies', 12, 250),
(85, 'sponges', 'Household Supplies', 25, 60),
(86, 'air freshener', 'Household Supplies', 18, 120),
(87, 'paper towels', 'Household Supplies', 20, 80),
(88, 'baking soda', 'Dairy & Groceries', 15, 40),
(89, 'vinegar', 'Dairy & Groceries', 12, 70),
(90, 'mustard sauce', 'Dairy & Groceries', 10, 90),
(91, 'soy sauce', 'Dairy & Groceries', 14, 110),
(92, 'pasta sauce', 'Dairy & Groceries', 10, 120),
(93, 'corn flakes', 'Dairy & Groceries', 18, 150),
(94, 'oats', 'Dairy & Groceries', 22, 180),
(95, 'granola bars', 'Snacks & Beverages', 25, 200),
(96, 'dark chocolate', 'Snacks & Beverages', 12, 250),
(97, 'coffee creamer', 'Snacks & Beverages', 15, 100),
(98, 'green tea', 'Snacks & Beverages', 10, 130),
(99, 'black tea', 'Snacks & Beverages', 10, 110),
(100, 'lemon juice', 'Snacks & Beverages', 12, 90),
(101, 'almond milk', 'Snacks & Beverages', 8, 200),
(102, 'coconut water', 'Snacks & Beverages', 15, 80),
(103, 'soya chunks', 'Dairy & Groceries', 18, 150),
(104, 'jaggery', 'Dairy & Groceries', 20, 90),
(105, 'herbal supplements', 'Health & Hygiene', 10, 300),
(106, 'protein powder', 'Health & Hygiene', 8, 1200),
(107, 'face wash', 'Health & Hygiene', 15, 180),
(108, 'body lotion', 'Health & Hygiene', 12, 250),
(109, 'sunscreen', 'Health & Hygiene', 10, 350),
(110, 'lip balm', 'Health & Hygiene', 20, 50),
(111, 'cough drops', 'Health & Hygiene', 15, 70),
(112, 'first aid kit', 'Health & Hygiene', 8, 500),
(113, 'toothbrush', 'Health & Hygiene', 25, 40),
(114, 'deodorant', 'Health & Hygiene', 15, 200),
(115, 'razors', 'Health & Hygiene', 20, 180),
(116, 'hair comb', 'Health & Hygiene', 20, 70),
(117, 'cotton pads', 'Health & Hygiene', 18, 90),
(118, 'light bulbs', 'Electronics & Accessories', 30, 100),
(119, 'AA batteries', 'Electronics & Accessories', 20, 150),
(120, 'phone charger', 'Electronics & Accessories', 10, 500),
(121, 'USB cable', 'Electronics & Accessories', 15, 200),
(122, 'power bank', 'Electronics & Accessories', 8, 1500),
(123, 'earphones', 'Electronics & Accessories', 10, 800),
(124, 'extension cord', 'Electronics & Accessories', 12, 400),
(125, 'notebook', 'Stationery', 30, 80),
(126, 'pens', 'Stationery', 40, 30),
(127, 'glue stick', 'Stationery', 15, 50),
(128, 'sticky notes', 'Stationery', 18, 90),
(129, 'scissors', 'Stationery', 12, 150);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `store_items`
--
ALTER TABLE `store_items`
  ADD PRIMARY KEY (`item_no`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `store_items`
--
ALTER TABLE `store_items`
  MODIFY `item_no` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
