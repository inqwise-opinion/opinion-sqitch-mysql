CREATE TABLE IF NOT EXISTS `messages` (
  `message_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message_name` varchar(100) NOT NULL,
  `message_content` text,
  `user_id` bigint(20) NOT NULL,
  `insert_date` datetime NOT NULL,
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modify_user_id` bigint(20) DEFAULT NULL,
  `close_date` datetime DEFAULT NULL,
  `close_user_id` bigint(20) DEFAULT NULL,
  `activate_date` datetime DEFAULT NULL,
  `exclude_date` datetime DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
