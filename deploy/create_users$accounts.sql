CREATE TABLE IF NOT EXISTS `users$accounts` (
  `account_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'default is true',
  `product_id` bigint(20) NOT NULL,
  `insert_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` datetime DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`account_id`,`user_id`),
  KEY `INX_product_id` (`product_id`),
  KEY `INX_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
