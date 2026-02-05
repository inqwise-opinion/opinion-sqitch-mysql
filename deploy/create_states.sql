CREATE TABLE IF NOT EXISTS `states` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(5) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `abbreviation` varchar(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
