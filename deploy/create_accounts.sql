CREATE TABLE IF NOT EXISTS `accounts` (
  `account_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid_prefix` varchar(20) NOT NULL,
  `owner_id` bigint(20) unsigned NOT NULL,
  `insert_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` datetime DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `service_package_id` int(11) DEFAULT '1',
  `account_name` varchar(200) DEFAULT NULL,
  `status_id` tinyint(2) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `balance` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `timezone_id` int(11) DEFAULT NULL,
  `min_deposit_amount` decimal(10,2) unsigned DEFAULT NULL,
  `max_deposit_amount` decimal(10,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5783 DEFAULT CHARSET=utf8;
