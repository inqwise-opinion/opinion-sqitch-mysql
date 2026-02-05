CREATE TABLE IF NOT EXISTS `_item_types` (
  `item_type_id` tinyint(3) unsigned NOT NULL,
  `item_type_value` varchar(45) NOT NULL,
  `item_type_order` tinyint(3) unsigned DEFAULT '0',
  `item_type_create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `item_type_modify_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`item_type_id`),
  UNIQUE KEY `item_type_value` (`item_type_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
