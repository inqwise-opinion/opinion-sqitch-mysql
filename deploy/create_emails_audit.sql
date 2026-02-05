CREATE TABLE IF NOT EXISTS `emails_audit` (
  `email_audit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email_audit_key` char(20) NOT NULL,
  `email_type_id` tinyint(4) NOT NULL,
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `email_audit_content` text,
  `insert_date` date NOT NULL,
  PRIMARY KEY (`email_audit_key`),
  UNIQUE KEY `email_audit_id` (`email_audit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4956 DEFAULT CHARSET=utf8;
