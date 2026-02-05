CREATE TABLE IF NOT EXISTS `timezones` (
  `timezone_id` int(11) NOT NULL AUTO_INCREMENT,
  `GMT` varchar(5) NOT NULL,
  `timezone_name` varchar(120) NOT NULL,
  PRIMARY KEY (`timezone_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
