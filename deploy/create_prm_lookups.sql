CREATE TABLE IF NOT EXISTS `prm_lookups` (
  `lkp_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `lkp_section_id` tinyint(4) NOT NULL,
  `lkp_section_name` varchar(100) NOT NULL,
  `lkp_item_id` tinyint(4) NOT NULL,
  `lkp_item_name` varchar(100) NOT NULL,
  `lkp_item_description` text,
  `lkp_item_priority_id` tinyint(4) DEFAULT NULL,
  `lkp_insert_date` datetime NOT NULL,
  `lkp_modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`lkp_id`),
  UNIQUE KEY `UNQ_lkp_section_id__lkp_item_id` (`lkp_section_id`,`lkp_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
