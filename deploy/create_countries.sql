CREATE TABLE IF NOT EXISTS `countries` (
  `country_id` int(5) NOT NULL AUTO_INCREMENT,
  `iso2` char(2) DEFAULT NULL,
  `country_name` varchar(80) NOT NULL DEFAULT '',
  `iso3` char(3) DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  `calling_code` varchar(8) DEFAULT NULL,
  `default_timezone_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `iso2` (`iso2`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=latin1;
