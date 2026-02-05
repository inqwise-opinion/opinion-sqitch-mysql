CREATE TABLE IF NOT EXISTS `users` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(80) NOT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `insert_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` datetime DEFAULT NULL,
  `password_expiry_date` datetime DEFAULT NULL,
  `send_newsletters` tinyint(1) DEFAULT NULL,
  `gateway_id` bigint(20) unsigned DEFAULT NULL,
  `email` varchar(80) NOT NULL,
  `is_test` tinyint(1) DEFAULT NULL,
  `country_id` int(5) DEFAULT NULL,
  `provider_id` tinyint(4) DEFAULT NULL,
  `user_external_id` varchar(30) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`,`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5775 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
