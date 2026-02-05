CREATE TABLE IF NOT EXISTS `accounts_details` (
  `account_id` bigint(20) unsigned NOT NULL,
  `insert_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` datetime DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  `business_company_name` varchar(100) DEFAULT NULL,
  `business_first_name` varchar(100) DEFAULT NULL,
  `business_last_name` varchar(100) DEFAULT NULL,
  `business_address1` varchar(255) DEFAULT NULL,
  `business_address2` varchar(255) DEFAULT NULL,
  `business_city` varchar(100) DEFAULT NULL,
  `business_state_id` int(5) DEFAULT NULL,
  `business_postal_code` varchar(20) DEFAULT NULL,
  `business_country_id` int(5) DEFAULT NULL,
  `business_phone1` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
