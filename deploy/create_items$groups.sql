CREATE TABLE IF NOT EXISTS `items$groups` (
  `item_id` bigint(20) unsigned NOT NULL,
  `group_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item_type_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`item_id`,`group_id`,`item_type_id`),
  KEY `fk_items$groups_groups1` (`group_id`),
  KEY `fk_items$groups_accounts1` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
