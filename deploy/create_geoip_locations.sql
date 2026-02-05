CREATE TABLE IF NOT EXISTS `geoip_locations` (
  `glc_id` int(10) unsigned NOT NULL,
  `glc_country` char(2) NOT NULL,
  `glc_region` varchar(2) NOT NULL,
  `glc_city` varchar(64) NOT NULL,
  `glc_zip` varchar(16) NOT NULL,
  `glc_latitude` decimal(7,4) NOT NULL,
  `glc_longitude` decimal(7,4) NOT NULL,
  PRIMARY KEY (`glc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
