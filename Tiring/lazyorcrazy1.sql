SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `lazyorcrazy` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `lazyorcrazy` ;

-- -----------------------------------------------------
-- Table `lazyorcrazy`.`c_user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`c_user` (
  `userid` INT(11) NOT NULL ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `status` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`userid`) )
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`c_credit`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`c_credit` (
  `creditinfo` VARCHAR(45) NULL DEFAULT NULL ,
  `c_user_userid` INT(11) NOT NULL ,
  PRIMARY KEY (`c_user_userid`) ,
  INDEX `fk_c_credit_c_user1_idx` (`c_user_userid` ASC) ,
  CONSTRAINT `fk_c_credit_c_user1`
    FOREIGN KEY (`c_user_userid` )
    REFERENCES `lazyorcrazy`.`c_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`l_user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`l_user` (
  `userid` INT(11) NOT NULL ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `status` TINYINT(1) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`userid`) )
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`l_order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`l_order` (
  `orderid` INT(11) NOT NULL ,
  `ordertitle` VARCHAR(160) NULL DEFAULT NULL ,
  `orderstatus` VARCHAR(2) NOT NULL ,
  `orderprice` VARCHAR(45) NOT NULL ,
  `orderdetail` VARCHAR(200) NULL DEFAULT NULL ,
  `ordertime` VARCHAR(45) NOT NULL ,
  `orderremark` VARCHAR(45) NULL DEFAULT NULL ,
  `orderinsurance` TINYINT(1) NOT NULL ,
  `l_user_userid` INT(11) NOT NULL ,
  PRIMARY KEY (`orderid`) ,
  INDEX `fk_l_order_l_user_idx` (`l_user_userid` ASC) ,
  CONSTRAINT `fk_l_order_l_user`
    FOREIGN KEY (`l_user_userid` )
    REFERENCES `lazyorcrazy`.`l_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`c_grab`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`c_grab` (
  `grabstatus` VARCHAR(4) NOT NULL ,
  `c_user_userid` INT(11) NOT NULL ,
  `l_order_orderid` INT(11) NOT NULL ,
  PRIMARY KEY (`c_user_userid`, `l_order_orderid`) ,
  INDEX `fk_c_grab_c_user1_idx` (`c_user_userid` ASC) ,
  INDEX `fk_c_grab_l_order1_idx` (`l_order_orderid` ASC) ,
  CONSTRAINT `fk_c_grab_c_user1`
    FOREIGN KEY (`c_user_userid` )
    REFERENCES `lazyorcrazy`.`c_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_c_grab_l_order1`
    FOREIGN KEY (`l_order_orderid` )
    REFERENCES `lazyorcrazy`.`l_order` (`orderid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`c_location`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`c_location` (
  `locationinfo` VARCHAR(200) NOT NULL ,
  `c_user_userid` INT(11) NOT NULL ,
  PRIMARY KEY (`c_user_userid`) ,
  INDEX `fk_c_location_c_user1_idx` (`c_user_userid` ASC) ,
  CONSTRAINT `fk_c_location_c_user1`
    FOREIGN KEY (`c_user_userid` )
    REFERENCES `lazyorcrazy`.`c_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`c_order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`c_order` (
  `ordertitle` VARCHAR(160) NULL DEFAULT NULL ,
  `orderstatus` VARCHAR(2) NOT NULL ,
  `orderprice` VARCHAR(45) NOT NULL ,
  `orderdetail` VARCHAR(200) NULL DEFAULT NULL ,
  `ordertime` VARCHAR(45) NOT NULL ,
  `orderremark` VARCHAR(45) NULL DEFAULT NULL ,
  `orderinsurance` TINYINT(1) NOT NULL ,
  `c_user_userid` INT(11) NOT NULL ,
  `l_order_orderid` INT(11) NOT NULL ,
  PRIMARY KEY (`l_order_orderid`) ,
  INDEX `fk_c_order_c_user1_idx` (`c_user_userid` ASC) ,
  INDEX `fk_c_order_l_order1_idx` (`l_order_orderid` ASC) ,
  CONSTRAINT `fk_c_order_c_user1`
    FOREIGN KEY (`c_user_userid` )
    REFERENCES `lazyorcrazy`.`c_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_c_order_l_order1`
    FOREIGN KEY (`l_order_orderid` )
    REFERENCES `lazyorcrazy`.`l_order` (`orderid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`c_report`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`c_report` (
  `reportReason` VARCHAR(200) NOT NULL ,
  `l_user_userid` INT(11) NOT NULL ,
  `c_user_userid` INT(11) NOT NULL ,
  `l_order_orderid` INT(11) NOT NULL ,
  `reportStatus` INT(4) NOT NULL ,
  PRIMARY KEY (`l_user_userid`, `c_user_userid`) ,
  INDEX `fk_c_report_l_user1_idx` (`l_user_userid` ASC) ,
  INDEX `fk_c_report_c_user1_idx` (`c_user_userid` ASC) ,
  INDEX `fk_c_report_l_order1_idx` (`l_order_orderid` ASC) ,
  CONSTRAINT `fk_c_report_c_user1`
    FOREIGN KEY (`c_user_userid` )
    REFERENCES `lazyorcrazy`.`c_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_c_report_l_order1`
    FOREIGN KEY (`l_order_orderid` )
    REFERENCES `lazyorcrazy`.`l_order` (`orderid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_c_report_l_user1`
    FOREIGN KEY (`l_user_userid` )
    REFERENCES `lazyorcrazy`.`l_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`c_userInfo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`c_userInfo` (
  `usernick` VARCHAR(45) NULL DEFAULT NULL ,
  `userphone` VARCHAR(45) NOT NULL ,
  `usersex` VARCHAR(2) NULL DEFAULT NULL ,
  `useremail` VARCHAR(45) NULL DEFAULT NULL ,
  `userimage` VARCHAR(200) NULL DEFAULT NULL ,
  `userstatus` TINYINT(1) NOT NULL DEFAULT '0' ,
  `registerTime` VARCHAR(45) NOT NULL ,
  `c_user_userid` INT(11) NOT NULL ,
  PRIMARY KEY (`c_user_userid`) ,
  INDEX `fk_c_userInfo_c_user1_idx` (`c_user_userid` ASC) ,
  CONSTRAINT `fk_c_userInfo_c_user1`
    FOREIGN KEY (`c_user_userid` )
    REFERENCES `lazyorcrazy`.`c_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`l_comment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`l_comment` (
  `commentlevel` VARCHAR(4) NOT NULL ,
  `commentmatter` VARCHAR(160) NULL DEFAULT NULL ,
  `l_user_userid` INT(11) NOT NULL ,
  `l_order_orderid` INT(11) NOT NULL ,
  PRIMARY KEY (`l_user_userid`, `l_order_orderid`) ,
  INDEX `fk_l_comment_l_user1_idx` (`l_user_userid` ASC) ,
  INDEX `fk_l_comment_l_order1_idx` (`l_order_orderid` ASC) ,
  CONSTRAINT `fk_l_comment_l_order1`
    FOREIGN KEY (`l_order_orderid` )
    REFERENCES `lazyorcrazy`.`l_order` (`orderid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_l_comment_l_user1`
    FOREIGN KEY (`l_user_userid` )
    REFERENCES `lazyorcrazy`.`l_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`l_location`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`l_location` (
  `locationinfo` VARCHAR(200) NOT NULL ,
  `l_user_userid` INT(11) NOT NULL ,
  PRIMARY KEY (`l_user_userid`) ,
  INDEX `fk_l_location_l_user1_idx` (`l_user_userid` ASC) ,
  CONSTRAINT `fk_l_location_l_user1`
    FOREIGN KEY (`l_user_userid` )
    REFERENCES `lazyorcrazy`.`l_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`l_release`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`l_release` (
  `releasestatus` VARCHAR(4) NOT NULL DEFAULT '-1' ,
  `l_user_userid` INT(11) NOT NULL ,
  `l_order_orderid` INT(11) NOT NULL ,
  PRIMARY KEY (`l_order_orderid`) ,
  INDEX `fk_l_release_l_user1_idx` (`l_user_userid` ASC) ,
  INDEX `fk_l_release_l_order1_idx` (`l_order_orderid` ASC) ,
  CONSTRAINT `fk_l_release_l_order1`
    FOREIGN KEY (`l_order_orderid` )
    REFERENCES `lazyorcrazy`.`l_order` (`orderid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_l_release_l_user1`
    FOREIGN KEY (`l_user_userid` )
    REFERENCES `lazyorcrazy`.`l_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`l_report`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`l_report` (
  `reportStatus` INT(4) NOT NULL ,
  `reportReason` VARCHAR(200) NOT NULL ,
  `c_user_userid` INT(11) NOT NULL ,
  `l_user_userid` INT(11) NOT NULL ,
  `l_order_orderid` INT(11) NOT NULL ,
  PRIMARY KEY (`c_user_userid`, `l_user_userid`) ,
  INDEX `fk_l_report_c_user1_idx` (`c_user_userid` ASC) ,
  INDEX `fk_l_report_l_user1_idx` (`l_user_userid` ASC) ,
  INDEX `fk_l_report_l_order1_idx` (`l_order_orderid` ASC) ,
  CONSTRAINT `fk_l_report_c_user1`
    FOREIGN KEY (`c_user_userid` )
    REFERENCES `lazyorcrazy`.`c_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_l_report_l_order1`
    FOREIGN KEY (`l_order_orderid` )
    REFERENCES `lazyorcrazy`.`l_order` (`orderid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_l_report_l_user1`
    FOREIGN KEY (`l_user_userid` )
    REFERENCES `lazyorcrazy`.`l_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `lazyorcrazy`.`l_userInfo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `lazyorcrazy`.`l_userInfo` (
  `usernick` VARCHAR(45) NULL DEFAULT NULL ,
  `userphone` VARCHAR(45) NOT NULL ,
  `usersex` VARCHAR(2) NULL DEFAULT NULL ,
  `useremail` VARCHAR(45) NULL DEFAULT NULL ,
  `userimage` VARCHAR(200) NULL DEFAULT NULL ,
  `registerTime` VARCHAR(45) NOT NULL ,
  `l_user_userid` INT(11) NOT NULL ,
  PRIMARY KEY (`l_user_userid`) ,
  INDEX `fk_l_userInfo_l_user1_idx` (`l_user_userid` ASC) ,
  CONSTRAINT `fk_l_userInfo_l_user1`
    FOREIGN KEY (`l_user_userid` )
    REFERENCES `lazyorcrazy`.`l_user` (`userid` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `lazyorcrazy` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
