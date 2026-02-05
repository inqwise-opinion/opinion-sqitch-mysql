CREATE TABLE IF NOT EXISTS `pay_bills$items` (
  `bill_item_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_id` bigint(20) NOT NULL,
  `bill_type_id` tinyint(4) NOT NULL,
  `insert_date` datetime NOT NULL,
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `item_id` bigint(20) NOT NULL,
  `item_type_id` tinyint(4) NOT NULL,
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`bill_item_id`),
  UNIQUE KEY `UNQ_item_id__item_type_id` (`item_id`,`item_type_id`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
