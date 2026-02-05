CREATE TABLE IF NOT EXISTS `accounts$service_packages` (
  `account_id` bigint(20) unsigned NOT NULL,
  `service_package_id` int(10) unsigned NOT NULL,
  `max_users` int(10) unsigned DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `insert_date` datetime NOT NULL,
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`,`service_package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
