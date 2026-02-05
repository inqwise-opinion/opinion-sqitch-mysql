CREATE TABLE IF NOT EXISTS `products` (
  `product_id` bigint(20) NOT NULL,
  `product_guid` varchar(36) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `description` tinyint(255) DEFAULT NULL,
  `insert_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `order_id` int(11) DEFAULT NULL,
  `feedback_caption` varchar(100) DEFAULT NULL,
  `feedback_short_caption` varchar(100) DEFAULT NULL,
  `support_email` varchar(255) DEFAULT NULL,
  `no_reply_email` varchar(255) DEFAULT NULL,
  `admin_email` varchar(255) DEFAULT NULL,
  `sales_email` varchar(255) DEFAULT NULL,
  `contact_us_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `INX_product_guid` (`product_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
