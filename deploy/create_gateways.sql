CREATE TABLE IF NOT EXISTS `gateways` (
  `gateway_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gateway_name` varchar(100) NOT NULL,
  `campaign_id` bigint(20) NOT NULL,
  `gateway_description` varchar(255) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gateway_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
