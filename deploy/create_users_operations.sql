CREATE TABLE IF NOT EXISTS `users_operations` (
  `usop_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usop_type_id` tinyint(4) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_ip` varchar(35) DEFAULT NULL,
  `geo_country_id` int(5) DEFAULT NULL,
  `session_id` varchar(50) DEFAULT NULL,
  `source_guid` varchar(50) DEFAULT NULL,
  `insert_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` datetime DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  `reference_id` bigint(20) DEFAULT NULL,
  `backoffice_user_id` bigint(20) unsigned DEFAULT NULL,
  `source_id` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`usop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24968 DEFAULT CHARSET=utf8;
