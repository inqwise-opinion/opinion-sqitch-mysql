CREATE TABLE IF NOT EXISTS `prm_definitions` (
  `def_id` int(11) NOT NULL AUTO_INCREMENT,
  `def_key` varchar(50) NOT NULL,
  `def_name` varchar(255) NOT NULL,
  `def_value_type_id` tinyint(4) NOT NULL,
  `def_value` varchar(50) NOT NULL,
  `def_description` text,
  `def_insert_date` datetime NOT NULL,
  `def_modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `def_is_active` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`def_id`),
  UNIQUE KEY `UNQ_def_key` (`def_key`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
