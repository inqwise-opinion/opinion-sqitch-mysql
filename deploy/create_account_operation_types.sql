CREATE TABLE IF NOT EXISTS `_account_operation_types` (
  `accop_type_id` tinyint(4) NOT NULL,
  `accop_type_name` varchar(200) NOT NULL,
  `insert_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` datetime DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`accop_type_id`),
  UNIQUE KEY `accop_type_name` (`accop_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
