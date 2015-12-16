-- phpMyAdmin SQL Dump
-- version 4.1.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2015-11-07 09:46:42
-- 服务器版本： 5.0.45-community-nt
-- PHP Version: 5.5.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `lazyorcrazy`
--

-- --------------------------------------------------------

--
-- 表的结构 `c_credit`
--

CREATE TABLE IF NOT EXISTS `c_credit` (
  `creditinfo` varchar(45) collate utf8_unicode_ci default '',
  `c_user_userid` int(11) NOT NULL,
  PRIMARY KEY  (`c_user_userid`),
  KEY `fk_c_credit_c_user1_idx` (`c_user_userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `c_credit`
--

INSERT INTO `c_credit` (`creditinfo`, `c_user_userid`) VALUES
('4', 1),
('201', 2),
('4', 3),
('109', 8);

-- --------------------------------------------------------

--
-- 表的结构 `c_grab`
--

CREATE TABLE IF NOT EXISTS `c_grab` (
  `grabstatus` varchar(4) collate utf8_unicode_ci NOT NULL,
  `c_user_userid` int(11) NOT NULL,
  `l_order_orderid` int(11) NOT NULL,
  PRIMARY KEY  (`c_user_userid`,`l_order_orderid`),
  KEY `fk_c_grab_c_user1_idx` (`c_user_userid`),
  KEY `fk_c_grab_l_order1_idx` (`l_order_orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `c_location`
--

CREATE TABLE IF NOT EXISTS `c_location` (
  `locationinfo` varchar(200) collate utf8_unicode_ci NOT NULL,
  `c_user_userid` int(11) NOT NULL,
  PRIMARY KEY  (`c_user_userid`),
  KEY `fk_c_location_c_user1_idx` (`c_user_userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `c_location`
--

INSERT INTO `c_location` (`locationinfo`, `c_user_userid`) VALUES
('31.375148,120.742073', 1),
('31.375148,120.752073', 2),
('0.000000,0.000000', 3),
('0.000000,0.000000', 8);

-- --------------------------------------------------------

--
-- 表的结构 `c_order`
--

CREATE TABLE IF NOT EXISTS `c_order` (
  `ordertitle` varchar(160) collate utf8_unicode_ci default '',
  `orderstatus` varchar(2) collate utf8_unicode_ci default '',
  `orderprice` varchar(45) collate utf8_unicode_ci default '',
  `orderdetail` varchar(200) collate utf8_unicode_ci default '',
  `orderphone` varchar(11) collate utf8_unicode_ci default '',
  `ordertime` varchar(45) collate utf8_unicode_ci default '',
  `orderremark` varchar(45) collate utf8_unicode_ci default '',
  `orderinsurance` varchar(5) collate utf8_unicode_ci default '',
  `c_user_userid` int(11) NOT NULL,
  `l_order_orderid` int(11) NOT NULL,
  PRIMARY KEY  (`l_order_orderid`),
  KEY `fk_c_order_c_user1_idx` (`c_user_userid`),
  KEY `fk_c_order_l_order1_idx` (`l_order_orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `c_report`
--

CREATE TABLE IF NOT EXISTS `c_report` (
  `reportReason` varchar(200) collate utf8_unicode_ci NOT NULL,
  `l_user_userid` int(11) NOT NULL,
  `c_user_userid` int(11) NOT NULL,
  `l_order_orderid` int(11) NOT NULL,
  `reportStatus` int(4) NOT NULL,
  PRIMARY KEY  (`l_user_userid`,`c_user_userid`),
  KEY `fk_c_report_l_user1_idx` (`l_user_userid`),
  KEY `fk_c_report_c_user1_idx` (`c_user_userid`),
  KEY `fk_c_report_l_order1_idx` (`l_order_orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `c_user`
--

CREATE TABLE IF NOT EXISTS `c_user` (
  `userid` int(11) NOT NULL auto_increment,
  `username` varchar(45) collate utf8_unicode_ci NOT NULL,
  `password` varchar(100) collate utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `c_user`
--

INSERT INTO `c_user` (`userid`, `username`, `password`, `status`) VALUES
(1, 'root', 'j6jWv8zY8q7M8SZl4LP5eg==', 0),
(2, '15606946786', 'j6jWv8zY8q7M8SZl4LP5eg==', 0),
(3, '18344904404', 'j6jWv8zY8q7M8SZl4LP5eg==', 0),
(8, '18861331676', 'j6jWv8zY8q7M8SZl4LP5eg==', 0);

-- --------------------------------------------------------

--
-- 表的结构 `c_userinfo`
--

CREATE TABLE IF NOT EXISTS `c_userinfo` (
  `usernick` varchar(45) collate utf8_unicode_ci default '',
  `userphone` varchar(45) collate utf8_unicode_ci default '',
  `usersex` varchar(2) collate utf8_unicode_ci default '',
  `useremail` varchar(45) collate utf8_unicode_ci default '',
  `userimage` varchar(200) collate utf8_unicode_ci default '',
  `userstatus` varchar(11) collate utf8_unicode_ci default '0',
  `registerTime` varchar(45) collate utf8_unicode_ci default '',
  `c_user_userid` int(11) NOT NULL,
  PRIMARY KEY  (`c_user_userid`),
  KEY `fk_c_userInfo_c_user1_idx` (`c_user_userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `c_userinfo`
--

INSERT INTO `c_userinfo` (`usernick`, `userphone`, `usersex`, `useremail`, `userimage`, `userstatus`, `registerTime`, `c_user_userid`) VALUES
('root', 'root', '未知', 'root@136.com', 'is5631bf399e259.png', '1', '2015-10-29', 1),
('吕佳', '15606946786', '男', 'ljia789@foxmail.com', 'is5631be6c72800.png', '1', '2015-10-29', 2),
('黄一璐', '18344904404', '女', 'huangyilu@qq.com', 'is5631be6c72800.png', '1', '2015-11-1', 3),
('XDD', '18861331676', '男', 'xdd@qq.com', 'is5638989b4905b.png', '0', '2015-11-03', 8);

-- --------------------------------------------------------

--
-- 表的结构 `idea`
--

CREATE TABLE IF NOT EXISTS `idea` (
  `id` int(11) NOT NULL auto_increment,
  `info` varchar(1000) collate utf8_unicode_ci NOT NULL,
  `imgone` varchar(200) collate utf8_unicode_ci default '',
  `imgtwo` varchar(200) collate utf8_unicode_ci default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `idea`
--

INSERT INTO `idea` (`id`, `info`, `imgone`, `imgtwo`) VALUES
(1, '测试一下', 'is5631cf370c393.png', ''),
(2, '9999999', 'is56373aa78d1dc.png', 'is56373aa79946a.png');

-- --------------------------------------------------------

--
-- 表的结构 `l_comment`
--

CREATE TABLE IF NOT EXISTS `l_comment` (
  `commentlevel` varchar(4) collate utf8_unicode_ci NOT NULL,
  `commentmatter` varchar(160) collate utf8_unicode_ci default '',
  `l_user_userid` int(11) NOT NULL,
  `l_order_orderid` int(11) NOT NULL,
  PRIMARY KEY  (`l_user_userid`,`l_order_orderid`),
  KEY `fk_l_comment_l_user1_idx` (`l_user_userid`),
  KEY `fk_l_comment_l_order1_idx` (`l_order_orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `l_comment`
--

INSERT INTO `l_comment` (`commentlevel`, `commentmatter`, `l_user_userid`, `l_order_orderid`) VALUES
('5', '测试评价表和信用表', 3, 4),
('5', '很好，很喜欢', 3, 6);

-- --------------------------------------------------------

--
-- 表的结构 `l_location`
--

CREATE TABLE IF NOT EXISTS `l_location` (
  `locationinfo` varchar(200) collate utf8_unicode_ci NOT NULL,
  `l_user_userid` int(11) NOT NULL,
  PRIMARY KEY  (`l_user_userid`),
  KEY `fk_l_location_l_user1_idx` (`l_user_userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `l_location`
--

INSERT INTO `l_location` (`locationinfo`, `l_user_userid`) VALUES
('31.277148,120.742573', 1),
('31.277248,120.742473', 2),
('31.287148,120.748573', 3),
('31.277148,120.743537', 4),
('31.278148,120.743537', 5);

-- --------------------------------------------------------

--
-- 表的结构 `l_order`
--

CREATE TABLE IF NOT EXISTS `l_order` (
  `orderid` int(11) NOT NULL auto_increment,
  `ordertitle` varchar(60) collate utf8_unicode_ci default NULL,
  `orderstatus` varchar(2) collate utf8_unicode_ci default '',
  `orderprice` varchar(45) collate utf8_unicode_ci default '',
  `orderdetail` varchar(200) collate utf8_unicode_ci default '',
  `orderphone` varchar(11) collate utf8_unicode_ci default '',
  `ordertime` varchar(45) collate utf8_unicode_ci default '',
  `orderremark` varchar(45) collate utf8_unicode_ci default '',
  `orderinsurance` tinyint(1) default '0',
  `l_user_userid` int(11) NOT NULL,
  PRIMARY KEY  (`orderid`),
  KEY `fk_l_order_l_user_idx` (`l_user_userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `l_order`
--

INSERT INTO `l_order` (`orderid`, `ordertitle`, `orderstatus`, `orderprice`, `orderdetail`, `orderphone`, `ordertime`, `orderremark`, `orderinsurance`, `l_user_userid`) VALUES
(1, '买份报纸', '2', '1', '明天早上，帮忙买份苏州早报，送到高博教育区G楼保安室', '15606946786', '2015-10-29 13:18:11', '当天的早报', 1, 3),
(2, '取快递', '2', '10', '明天中午取快递（圆通）', '15046623624', '2015-10-29 14:09:43', '', 1, 3),
(4, '吃饭去', '2', '1', '到文星广场  吃吃吃。。。。', '110', '2015-10-29 21:48:47', '', 0, 3),
(5, '去校园快递取快递', '2', '2', '是一个很轻的小东西，具体单号：请电话联系我', '18861331676', '2015-11-02 14:24:20', '易碎', 0, 4),
(6, '发传单', '2', '11', '周六晚上6点到杨南路口', '15606946786', '2015-11-02 19:55:03', '准时', 0, 3),
(7, '找个人聊天', '2', '10', '明天下午', '15606946786', '2015-11-04 09:23:36', '', 0, 3),
(8, '十万个弄啥子', '2', '22', '看看看看看看看，，，，，那是什么傻逼', '15606946786', '2015-11-04 09:22:56', '', 0, 3),
(9, '打人', '2', '10', '周日， 随时都可以  ', '11100', '2015-11-04 15:49:42', '', 0, 1),
(10, '买菜', '2', '20', '今天晚上五点   买一个白菜', '15046623624', '2015-11-04 15:50:49', '', 0, 2),
(11, '找人', '2', '12', '人肉搜索 黄一璐', '18861331676', '2015-11-04 15:53:00', '', 0, 4),
(12, '找死', '2', '3', '寻找自杀之法', '18344904404', '2015-11-04 15:53:58', '', 0, 5);

-- --------------------------------------------------------

--
-- 表的结构 `l_release`
--

CREATE TABLE IF NOT EXISTS `l_release` (
  `releasestatus` varchar(4) collate utf8_unicode_ci NOT NULL default '-1',
  `l_user_userid` int(11) NOT NULL,
  `l_order_orderid` int(11) NOT NULL,
  PRIMARY KEY  (`l_order_orderid`),
  KEY `fk_l_release_l_user1_idx` (`l_user_userid`),
  KEY `fk_l_release_l_order1_idx` (`l_order_orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `l_report`
--

CREATE TABLE IF NOT EXISTS `l_report` (
  `reportStatus` int(4) NOT NULL,
  `reportReason` varchar(200) collate utf8_unicode_ci default '',
  `c_user_userid` int(11) NOT NULL,
  `l_user_userid` int(11) NOT NULL,
  `l_order_orderid` int(11) NOT NULL,
  PRIMARY KEY  (`c_user_userid`,`l_user_userid`),
  KEY `fk_l_report_c_user1_idx` (`c_user_userid`),
  KEY `fk_l_report_l_user1_idx` (`l_user_userid`),
  KEY `fk_l_report_l_order1_idx` (`l_order_orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `l_user`
--

CREATE TABLE IF NOT EXISTS `l_user` (
  `userid` int(11) NOT NULL auto_increment,
  `username` varchar(45) collate utf8_unicode_ci NOT NULL,
  `password` varchar(100) collate utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `l_user`
--

INSERT INTO `l_user` (`userid`, `username`, `password`, `status`) VALUES
(1, 'root', 'j6jWv8zY8q7M8SZl4LP5eg==', 0),
(2, '15046623624', 'j6jWv8zY8q7M8SZl4LP5eg==', 0),
(3, '15606946786', 'j6jWv8zY8q7M8SZl4LP5eg==', 0),
(4, '18861331676', 'j6jWv8zY8q7M8SZl4LP5eg==', 0),
(5, '18344904404', 'j6jWv8zY8q7M8SZl4LP5eg==', 0);

-- --------------------------------------------------------

--
-- 表的结构 `l_userinfo`
--

CREATE TABLE IF NOT EXISTS `l_userinfo` (
  `usernick` varchar(45) collate utf8_unicode_ci default '',
  `userphone` varchar(45) collate utf8_unicode_ci default '',
  `usersex` varchar(45) collate utf8_unicode_ci default '',
  `useremail` varchar(45) collate utf8_unicode_ci default '',
  `userimage` varchar(200) collate utf8_unicode_ci default '',
  `registerTime` varchar(45) collate utf8_unicode_ci default '',
  `l_user_userid` int(11) NOT NULL,
  PRIMARY KEY  (`l_user_userid`),
  KEY `fk_l_userInfo_l_user1_idx` (`l_user_userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `l_userinfo`
--

INSERT INTO `l_userinfo` (`usernick`, `userphone`, `usersex`, `useremail`, `userimage`, `registerTime`, `l_user_userid`) VALUES
('root', 'root', '不详', 'root@163.com', 'is5631ac2149543.png', '2015-10-29', 1),
('Bill', '15046623624', '女', '15046623624@136.com', 'is5631b66c8c1fe.png', '2015-10-29', 2),
('超人', '15606946786', '不详', 'ljia789@gmail.com', 'is563741a2777b8.png', '2015-10-29', 3),
('熊大', '18861331676', '男', 'suibian@qq.com', 'is5631cd01d4eb3.png', '2015-10-29', 4),
('黄大猪头', '18344904404', '女', 'huangyilu@qq.com', 'is5631d9df7531e.png', '2015-10-29', 5);

--
-- 限制导出的表
--

--
-- 限制表 `c_credit`
--
ALTER TABLE `c_credit`
  ADD CONSTRAINT `fk_c_credit_c_user1` FOREIGN KEY (`c_user_userid`) REFERENCES `c_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `c_grab`
--
ALTER TABLE `c_grab`
  ADD CONSTRAINT `fk_c_grab_c_user1` FOREIGN KEY (`c_user_userid`) REFERENCES `c_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_c_grab_l_order1` FOREIGN KEY (`l_order_orderid`) REFERENCES `l_order` (`orderid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `c_location`
--
ALTER TABLE `c_location`
  ADD CONSTRAINT `fk_c_location_c_user1` FOREIGN KEY (`c_user_userid`) REFERENCES `c_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `c_order`
--
ALTER TABLE `c_order`
  ADD CONSTRAINT `fk_c_order_c_user1` FOREIGN KEY (`c_user_userid`) REFERENCES `c_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_c_order_l_order1` FOREIGN KEY (`l_order_orderid`) REFERENCES `l_order` (`orderid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `c_report`
--
ALTER TABLE `c_report`
  ADD CONSTRAINT `fk_c_report_c_user1` FOREIGN KEY (`c_user_userid`) REFERENCES `c_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_c_report_l_order1` FOREIGN KEY (`l_order_orderid`) REFERENCES `l_order` (`orderid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_c_report_l_user1` FOREIGN KEY (`l_user_userid`) REFERENCES `l_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `c_userinfo`
--
ALTER TABLE `c_userinfo`
  ADD CONSTRAINT `fk_c_userInfo_c_user1` FOREIGN KEY (`c_user_userid`) REFERENCES `c_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `l_comment`
--
ALTER TABLE `l_comment`
  ADD CONSTRAINT `fk_l_comment_l_order1` FOREIGN KEY (`l_order_orderid`) REFERENCES `l_order` (`orderid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_l_comment_l_user1` FOREIGN KEY (`l_user_userid`) REFERENCES `l_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `l_location`
--
ALTER TABLE `l_location`
  ADD CONSTRAINT `fk_l_location_l_user1` FOREIGN KEY (`l_user_userid`) REFERENCES `l_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `l_order`
--
ALTER TABLE `l_order`
  ADD CONSTRAINT `fk_l_order_l_user` FOREIGN KEY (`l_user_userid`) REFERENCES `l_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `l_release`
--
ALTER TABLE `l_release`
  ADD CONSTRAINT `fk_l_release_l_order1` FOREIGN KEY (`l_order_orderid`) REFERENCES `l_order` (`orderid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_l_release_l_user1` FOREIGN KEY (`l_user_userid`) REFERENCES `l_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `l_report`
--
ALTER TABLE `l_report`
  ADD CONSTRAINT `fk_l_report_c_user1` FOREIGN KEY (`c_user_userid`) REFERENCES `c_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_l_report_l_order1` FOREIGN KEY (`l_order_orderid`) REFERENCES `l_order` (`orderid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_l_report_l_user1` FOREIGN KEY (`l_user_userid`) REFERENCES `l_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 限制表 `l_userinfo`
--
ALTER TABLE `l_userinfo`
  ADD CONSTRAINT `fk_l_userInfo_l_user1` FOREIGN KEY (`l_user_userid`) REFERENCES `l_user` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
