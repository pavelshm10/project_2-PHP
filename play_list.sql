-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: דצמבר 27, 2018 בזמן 04:41 PM
-- גרסת שרת: 10.1.35-MariaDB
-- PHP Version: 7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `play_list`
--
CREATE DATABASE IF NOT EXISTS `play_list` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `play_list`;

-- --------------------------------------------------------

--
-- מבנה טבלה עבור טבלה `category`
--

CREATE TABLE `category` (
  `categoryID` int(11) NOT NULL,
  `categoryName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- הוצאת מידע עבור טבלה `category`
--

INSERT INTO `category` (`categoryID`, `categoryName`) VALUES
(1, 'rock'),
(2, 'rap'),
(3, 'metal'),
(4, 'pop'),
(5, 'trance'),
(6, 'dance'),
(7, 'R&B'),
(8, 'regaton');

-- --------------------------------------------------------

--
-- מבנה טבלה עבור טבלה `users`
--

CREATE TABLE `users` (
  `FName` varchar(20) NOT NULL,
  `LName` varchar(20) NOT NULL,
  `UserName` text NOT NULL,
  `Password` int(11) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- הוצאת מידע עבור טבלה `users`
--

INSERT INTO `users` (`FName`, `LName`, `UserName`, `Password`, `userID`) VALUES
('pavel', 'shmilevich', 'pash', 0, 9),
('gal', 'weiss', 'gala', 67, 10),
('yossi', 'haim', 'yos', 4, 11),
('shahar', 'hieman', 'shr@', 9666, 12),
('igal', 'shmil', 'tiger ', 0, 13),
('yossi', 'haim', 'hai', 27, 14),
('ss', 'ds', 'pashi', 27, 15),
('yossi', 'haim', 'rep', 1954, 16),
('yossi', 'yossi', 'yo', 2147483647, 17),
('ds', 'haim', 'yoss', 2147483647, 18),
('p', 'p', 'p', 0, 19);

-- --------------------------------------------------------

--
-- מבנה טבלה עבור טבלה `videos`
--

CREATE TABLE `videos` (
  `title` varchar(50) NOT NULL,
  `categoryID` int(11) NOT NULL,
  `description` text NOT NULL,
  `link` text NOT NULL,
  `userID` int(11) NOT NULL,
  `videoID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- הוצאת מידע עבור טבלה `videos`
--

INSERT INTO `videos` (`title`, `categoryID`, `description`, `link`, `userID`, `videoID`) VALUES
('pink floyed', 1, 'wish you were here', 'https://youtu.be/IXdNnw99-Ic', 9, 1),
('pearl jam', 1, 'black', 'https://youtu.be/4q9UafsiQ6k', 9, 3),
('artick', 7, 'wanna know', 'https://youtu.be/bpOSxM0rNPM', 12, 4),
('eminem', 2, 'lose yourself', 'https://youtu.be/_Yhyp-_hX2s', 12, 5),
('led zeplin', 1, 'babe im gonna leave you', 'https://youtu.be/eOUaQz8GYPA', 9, 6),
('led zeplin', 1, 'Stairway To Heaven', 'https://youtu.be/D9ioyEvdggk', 13, 7),
('led zeplin', 1, 'Stairway To Heaven', 'https://youtu.be/D9ioyEvdggk', 13, 8),
('led zeplin', 1, 'Stairway To Heaven', 'https://youtu.be/D9ioyEvdggk', 13, 9),
('2-pac', 7, 'DO 4 LOVE', 'https://youtu.be/VjJpf_5FFJo', 14, 10),
('led zeplin', 2, 'das', 'https://youtu.be/VjJpf_5FFJo', 15, 11),
('edd', 8, 'fds', 'https://youtu.be/VjJpf_5FFJo', 15, 12),
('led zeplin', 6, 'back', 'https://youtu.be/4q9UafsiQ6k', 16, 13),
('queen', 1, 'Bohemian Rhapsody', 'https://youtu.be/fJ9rUzIMcZQ', 17, 14),
('queen', 1, 'Bohemian Rhapsody', 'https://youtu.be/fJ9rUzIMcZQ', 18, 15),
('edd', 8, 'das', 'https://youtu.be/fJ9rUzIMcZQ', 19, 16);

--
-- Indexes for dumped tables
--

--
-- אינדקסים לטבלה `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryID`);

--
-- אינדקסים לטבלה `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- אינדקסים לטבלה `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`videoID`),
  ADD KEY `categoryID` (`categoryID`),
  ADD KEY `userID` (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `videoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- הגבלות לטבלאות שהוצאו
--

--
-- הגבלות לטבלה `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`),
  ADD CONSTRAINT `videos_ibfk_2` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
