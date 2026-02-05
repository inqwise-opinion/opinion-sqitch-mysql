CREATE TABLE IF NOT EXISTS `groups` (
  `group_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL,
  `group_owner_id` bigint(20) DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`group_id`),
  KEY `group_creator` (`group_owner_id`),
  KEY `fk_groups_users` (`group_owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
