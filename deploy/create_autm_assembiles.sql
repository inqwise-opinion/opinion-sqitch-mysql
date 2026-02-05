CREATE TABLE IF NOT EXISTS `autm_assembiles` (
  `assembly_id` tinyint(3) unsigned NOT NULL,
  `assembly_name` varchar(500) NOT NULL,
  `assembly_description` text,
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `insert_date` datetime NOT NULL,
  PRIMARY KEY (`assembly_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
