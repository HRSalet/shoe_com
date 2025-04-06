-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2025 at 08:05 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `product_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `adidas`
--

CREATE TABLE `adidas` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `price` decimal(20,2) NOT NULL,
  `imgAddress` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `adidas`
--

INSERT INTO `adidas` (`id`, `name`, `model`, `price`, `imgAddress`) VALUES
(1, 'ADIDAS', 'RUNCRYPT', '2300.00', 'adidas1.png'),
(2, 'ADIDAS', 'BEAMERS', '3086.00', 'adidas2.png'),
(3, 'ADIDAS', 'TRISTO', '2283.00', 'adidas3.png'),
(4, 'ADIDAS', 'MIDASO', '2278.00', 'adidas4.png'),
(5, 'ADIDAS', 'ALLIVER', '1700.00', 'adidas5.png'),
(6, 'ADIDAS', 'GAMBITO', '2283.00', 'adidas6.png'),
(7, 'ADIDAS', 'GLOWRUN', '1978.00', 'adidas7.png'),
(8, 'ADIDAS', 'STEADY', '3148.00', 'adidas8.png');

-- --------------------------------------------------------

--
-- Table structure for table `bata`
--

CREATE TABLE `bata` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `price` decimal(20,2) NOT NULL,
  `imgAddress` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bata`
--

INSERT INTO `bata` (`id`, `name`, `model`, `price`, `imgAddress`) VALUES
(1, 'BATA', 'SLIPON', '800.00', 'bata1.png'),
(2, 'BATA', 'ALBUS DERBY M', '1000.00', 'bata2.png'),
(3, 'BATA', 'SLIPON', '900.00', 'bata3.png'),
(4, 'BATA', 'SPARK E', '715.00', 'bata4.png'),
(5, 'BATA', 'DENIM BLUE', '531.00', 'bata6.png'),
(6, 'BATA', 'MESH MUSHY', '480.00', 'bata7.png'),
(7, 'BATA', 'SLIP-ON', '1980.00', 'bata8.png'),
(8, 'BATA', 'ADAM E', '700.00', 'bata5.png');

-- --------------------------------------------------------

--
-- Table structure for table `campus`
--

CREATE TABLE `campus` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `price` decimal(20,2) NOT NULL,
  `imgAddress` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `campus`
--

INSERT INTO `campus` (`id`, `name`, `model`, `price`, `imgAddress`) VALUES
(1, 'CAMPUS', 'LACE-UP', '1100.00', 'campus1.png'),
(2, 'CAMPUS', 'OXYFIT', '700.00', 'campus2.png'),
(3, 'CAMPUS', 'NORTH LACE-UP', '1200.00', 'campus3.png'),
(4, 'CAMPUS', 'TERMINATOR', '1250.00', 'campus4.png'),
(5, 'CAMPUS', 'TORMENTOR', '1000.00', 'campus5.png'),
(6, 'CAMPUS', 'DRAGON LACE-UP', '1100.00', 'campus6.png'),
(7, 'CAMPUS', 'OG-35 LACE-UP', '1000.00', 'campus7.png'),
(8, 'CAMPUS', 'MENS OMAX', '1000.00', 'campus8.png');

-- --------------------------------------------------------

--
-- Table structure for table `nike`
--

CREATE TABLE `nike` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `price` decimal(20,2) NOT NULL,
  `imgAddress` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nike`
--

INSERT INTO `nike` (`id`, `name`, `model`, `price`, `imgAddress`) VALUES
(1, 'NIKE', 'AIR-MAX', '13000.00', 'nike1.png'),
(2, 'NIKE', 'AIR-JORDAN MID', '12795.00', 'nike8.png'),
(3, 'NIKE', 'ZOOM', '11295.00', 'nike2.png'),
(4, 'NIKE', 'AIR-FORCE', '8000.00', 'nike3.png'),
(5, 'NIKE', 'AIR-JORDAN LOW', '12000.00', 'nike5.png'),
(6, 'NIKE', 'ZOOM', '11295.00', 'nike4.png'),
(7, 'NIKE', 'AIR-JORDAN LOW', '12000.00', 'nike7.png'),
(8, 'NIKE', 'AIR-JORDAN LOW', '12000.00', 'nike6.png');

-- --------------------------------------------------------

--
-- Table structure for table `puma`
--

CREATE TABLE `puma` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `price` decimal(20,2) NOT NULL,
  `imgAddress` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `puma`
--

INSERT INTO `puma` (`id`, `name`, `model`, `price`, `imgAddress`) VALUES
(1, 'PUMA', 'FOREVER RUN', '15000.00', 'puma1.png'),
(2, 'PUMA', 'DAZLER SNEAKER', '1584.00', 'puma2.png'),
(3, 'PUMA', 'GALAXIS PRO', '3850.00', 'puma3.png'),
(4, 'PUMA', 'COURT SHATTER', '3300.00', 'puma4.png'),
(5, 'PUMA', 'FRACTION FADE', '2800.00', 'puma5.png'),
(6, 'PUMA', 'BMW MS DRIFT', '3500.00', 'puma6.png'),
(7, 'PUMA', 'SOFTRIDE', '3084.00', 'puma7.png'),
(8, 'PUMA', 'LQDCELL METHOD', '3500.00', 'puma8.png');

-- --------------------------------------------------------

--
-- Table structure for table `reebok`
--

CREATE TABLE `reebok` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `price` decimal(20,2) NOT NULL,
  `imgAddress` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reebok`
--

INSERT INTO `reebok` (`id`, `name`, `model`, `price`, `imgAddress`) VALUES
(1, 'REEBOK', 'FLOW ADVANCE', '1520.00', 'reebok1.png'),
(2, 'REEBOK', 'STRIDER RUNNER', '1530.00', 'reebok2.png'),
(3, 'REEBOK', 'MOTION PULSE', '1380.00', 'reebok3.png'),
(4, 'REEBOK', 'UPFUN', '2000.00', 'reebok4.png'),
(5, 'REEBOK', 'WILD FIRE', '1085.00', 'reebok5.png'),
(6, 'REEBOK', 'COURTFLEX', '2080.00', 'reebok6.png'),
(7, 'REEBOK', 'SUPER SONIC', '1980.00', 'reebok7.png'),
(8, 'REEBOK', 'SPORT SHOE', '1300.00', 'reebok8.png');

-- --------------------------------------------------------

--
-- Table structure for table `woodland`
--

CREATE TABLE `woodland` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `price` decimal(20,2) NOT NULL,
  `imgAddress` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `woodland`
--

INSERT INTO `woodland` (`id`, `name`, `model`, `price`, `imgAddress`) VALUES
(1, 'WOODLAND', 'LEATHER SNEAKER', '2685.00', 'woodland1.png'),
(2, 'WOODLAND', 'LEATHER SNEAKER', '2850.00', 'woodland2.png'),
(3, 'WOODLAND', 'LEATHER SNEAKER', '2755.00', 'woodland3.png'),
(4, 'WOODLAND', 'LEATHER ANKLE BOOT', '5995.00', 'woodland4.png'),
(5, 'WOODLAND', 'LEATHER SNEAKER', '3040.00', 'woodland5.png'),
(6, 'WOODLAND', 'LEATHER SNEAKER', '3225.00', 'woodland6.png'),
(7, 'WOODLAND', 'LEATHER SNEAKER', '2600.00', 'woodland7.png'),
(8, 'WOODLAND', 'LEATHER SNEAKER', '2826.00', 'woodland8.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adidas`
--
ALTER TABLE `adidas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bata`
--
ALTER TABLE `bata`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `campus`
--
ALTER TABLE `campus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nike`
--
ALTER TABLE `nike`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `puma`
--
ALTER TABLE `puma`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reebok`
--
ALTER TABLE `reebok`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `woodland`
--
ALTER TABLE `woodland`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adidas`
--
ALTER TABLE `adidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `bata`
--
ALTER TABLE `bata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `campus`
--
ALTER TABLE `campus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `nike`
--
ALTER TABLE `nike`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `puma`
--
ALTER TABLE `puma`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `reebok`
--
ALTER TABLE `reebok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `woodland`
--
ALTER TABLE `woodland`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
