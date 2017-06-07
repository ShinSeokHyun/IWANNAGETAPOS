-- phpMyAdmin SQL Dump
-- version 4.2.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 17-05-24 03:17
-- 서버 버전: 5.6.20
-- PHP 버전: 5.6.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 데이터베이스: `pos`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `item`
--

CREATE TABLE IF NOT EXISTS `item` (
  `barcode` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `price` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `item`
--

INSERT INTO `item` (`barcode`, `name`, `price`, `stock`, `type`) VALUES
('1', '일', 1234, 1, 2),
('2', '월', 1234, 2, 2),
('3', '화', 12345, 1, 1),
('4', '수', 12345, 1, 2);

-- --------------------------------------------------------

--
-- 테이블 구조 `order`
--

CREATE TABLE IF NOT EXISTS `order` (
`no` int(11) NOT NULL,
  `totalprice` int(11) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `orderitem`
--

CREATE TABLE IF NOT EXISTS `orderitem` (
`No` int(11) NOT NULL,
  `orderNo` int(11) NOT NULL,
  `barcode` varchar(20) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
`no` int(11) NOT NULL,
  `userid` varchar(30) NOT NULL,
  `userpassword` varchar(30) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `isadmin` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `user`
--

INSERT INTO `user` (`no`, `userid`, `userpassword`, `Name`, `isadmin`) VALUES
(1, 'admin', '1', 'Administrator', 1),
(2, 'casher', '1', 'Parttime', 0);

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `item`
--
ALTER TABLE `item`
 ADD PRIMARY KEY (`barcode`);

--
-- 테이블의 인덱스 `order`
--
ALTER TABLE `order`
 ADD PRIMARY KEY (`no`);

--
-- 테이블의 인덱스 `orderitem`
--
ALTER TABLE `orderitem`
 ADD PRIMARY KEY (`No`);

--
-- 테이블의 인덱스 `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`no`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `order`
--
ALTER TABLE `order`
MODIFY `no` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- 테이블의 AUTO_INCREMENT `orderitem`
--
ALTER TABLE `orderitem`
MODIFY `No` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- 테이블의 AUTO_INCREMENT `user`
--
ALTER TABLE `user`
MODIFY `no` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
