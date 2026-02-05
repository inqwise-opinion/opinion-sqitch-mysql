CREATE TABLE IF NOT EXISTS `autm_event_types` (
  `event_type_id` int(11) NOT NULL,
  `event_type_name` varchar(255) NOT NULL,
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `event_type_description` text,
  `event_type_recipients` text,
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
