DELIMITER $$

DROP PROCEDURE IF EXISTS `getEmailAudit`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEmailAudit`( $email_audit_key CHAR(20)
)
BEGIN
	SELECT email_audit_id, email_audit_key, email_type_id, email_audit_content, insert_date
	FROM emails_audit
	WHERE email_audit_key = $email_audit_key; 
END;$$

DELIMITER ;
