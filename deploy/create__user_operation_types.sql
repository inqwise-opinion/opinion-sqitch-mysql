CREATE TABLE IF NOT EXISTS `_user_operation_types` (
  `utt_id` tinyint(3) unsigned NOT NULL,
  `value` varchar(45) NOT NULL,
  `order` tinyint(3) unsigned DEFAULT '0',
  `insert_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`utt_id`),
  UNIQUE KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
