CREATE TABLE IF NOT EXISTS `prm_references` (
  `ref_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ref_definition_id` int(11) NOT NULL,
  `ref_key` varchar(50) NOT NULL,
  `ref_entity_type_id` tinyint(4) NOT NULL,
  `ref_entity_id` bigint(20) NOT NULL,
  `ref_value` varchar(50) DEFAULT NULL,
  `ref_priority_id` tinyint(4) DEFAULT NULL,
  `ref_insert_date` datetime NOT NULL,
  `ref_modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ref_modify_user_id` bigint(20) DEFAULT NULL,
  `ref_depends_on_key` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ref_id`),
  UNIQUE KEY `UNQ_ref_definition_id__ref_entity_type_id__ref_entity_id` (`ref_definition_id`,`ref_entity_type_id`,`ref_entity_id`),
  UNIQUE KEY `UNQ_ref_key` (`ref_definition_id`,`ref_key`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
