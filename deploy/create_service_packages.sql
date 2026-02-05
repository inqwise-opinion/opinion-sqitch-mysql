CREATE TABLE IF NOT EXISTS `service_packages` (
  `sp_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sp_name` varchar(200) NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `insert_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` datetime DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_default` tinyint(4) DEFAULT NULL,
  `default_usage_period` int(11) DEFAULT NULL,
  `max_account_users` int(11) DEFAULT NULL,
  PRIMARY KEY (`sp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
