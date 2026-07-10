-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Lip 10, 2026 at 06:16 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `url_db`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `analytics`
--

CREATE TABLE `analytics` (
  `aID` int(11) NOT NULL,
  `short_url` varchar(500) NOT NULL,
  `click_time` datetime DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  `browser` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `analytics`
--

INSERT INTO `analytics` (`aID`, `short_url`, `click_time`, `country`, `browser`) VALUES
(1, '67gYyHa', '2026-07-07 11:38:10', 'Poland', 'Mozilla/5.0'),
(2, '67gYyHa', '2026-07-07 11:39:19', 'Localhost (Test)', 'Mozilla/5.0'),
(3, '67gYyHa', '2026-07-07 11:39:21', 'Localhost (Test)', 'Mozilla/5.0'),
(4, '67gYyHa', '2026-07-07 11:39:22', 'Localhost (Test)', 'Mozilla/5.0'),
(5, '67gYyHa', '2026-07-07 11:39:23', 'Localhost (Test)', 'Mozilla/5.0'),
(6, '67gYyHa', '2026-07-07 11:42:14', 'Localhost (Test)', 'PostmanRuntime/7.54.0'),
(7, '67gYyHb', '2026-07-09 15:07:46', 'Localhost (Test)', 'Mozilla/5.0'),
(8, '67gYyHb', '2026-07-09 15:08:07', 'Localhost (Test)', 'Mozilla/5.0'),
(9, '67gYyHY', '2026-07-09 17:43:34', 'Localhost (Test)', 'Mozilla/5.0'),
(10, '67gYyHb', '2026-07-09 17:52:41', 'Localhost (Test)', 'Mozilla/5.0'),
(11, '67gYyHb', '2026-07-09 17:54:58', 'Localhost (Test)', 'Mozilla/5.0'),
(12, '67gYyHb', '2026-07-09 17:57:43', 'Localhost (Test)', 'Mozilla/5.0'),
(13, '67gYyHb', '2026-07-09 17:57:57', 'Localhost (Test)', 'Mozilla/5.0'),
(14, '67gYyHb', '2026-07-09 18:30:32', 'Localhost (Test)', 'Mozilla/5.0'),
(15, '67gYyHa', '2026-07-09 18:37:15', 'Localhost (Test)', 'Mozilla/5.0'),
(16, '67gYyHa', '2026-07-09 18:37:17', 'Localhost (Test)', 'Mozilla/5.0'),
(17, '67gYyHa', '2026-07-09 18:37:18', 'Localhost (Test)', 'Mozilla/5.0'),
(18, '67gYyHa', '2026-07-09 18:37:20', 'Localhost (Test)', 'Mozilla/5.0'),
(19, '67gYyHa', '2026-07-09 18:37:21', 'Localhost (Test)', 'Mozilla/5.0'),
(20, '67gYyHa', '2026-07-09 18:37:23', 'Localhost (Test)', 'Mozilla/5.0'),
(21, '67gYyHa', '2026-07-09 18:37:24', 'Localhost (Test)', 'Mozilla/5.0'),
(22, '67gYyHa', '2026-07-09 18:37:25', 'Localhost (Test)', 'Mozilla/5.0'),
(23, '67gYyHa', '2026-07-09 18:37:27', 'Localhost (Test)', 'Mozilla/5.0'),
(24, '67gYyHa', '2026-07-09 18:37:29', 'Localhost (Test)', 'Mozilla/5.0'),
(25, '67gYyHa', '2026-07-09 18:37:30', 'Localhost (Test)', 'Mozilla/5.0'),
(26, '67gYyHb', '2026-07-09 20:07:58', 'Localhost (Test)', 'Opera'),
(27, '67gYyHb', '2026-07-09 20:08:40', 'Localhost (Test)', 'Opera'),
(28, '67gYyHa', '2026-07-09 23:09:22', 'Localhost (Test)', 'Opera'),
(29, '67gYyHa', '2026-07-09 23:09:25', 'Localhost (Test)', 'Opera');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `urls`
--

CREATE TABLE `urls` (
  `full_url` varchar(500) NOT NULL,
  `short_url` varchar(500) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `urls`
--

INSERT INTO `urls` (`full_url`, `short_url`, `created_at`) VALUES
('https://google.com', '67gYyHY', '2026-07-07 11:32:11'),
('https://mediaexpert.pl', '67gYyHf', '2026-07-09 12:57:59'),
('https://pinterest.com', '67gYyHZ', '2026-07-07 11:32:11'),
('https://spotify.com', '67gYyHe', '2026-07-07 11:32:11'),
('https://www.x-kom.pl/p/1267059-telewizor-32-i-mniejszy-xiaomi-tv-a-2025-32.html', '67gYyHa', '2026-07-07 11:32:11'),
('https://youtube.com', '67gYyHb', '2026-07-07 11:32:11');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `analytics`
--
ALTER TABLE `analytics`
  ADD PRIMARY KEY (`aID`),
  ADD KEY `short_url` (`short_url`);

--
-- Indeksy dla tabeli `urls`
--
ALTER TABLE `urls`
  ADD PRIMARY KEY (`full_url`),
  ADD UNIQUE KEY `short_url` (`short_url`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `analytics`
--
ALTER TABLE `analytics`
  MODIFY `aID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `analytics`
--
ALTER TABLE `analytics`
  ADD CONSTRAINT `analytics_ibfk_1` FOREIGN KEY (`short_url`) REFERENCES `urls` (`short_url`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
