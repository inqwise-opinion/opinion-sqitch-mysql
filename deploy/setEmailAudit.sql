DELIMITER $$

DROP PROCEDURE IF EXISTS `setEmailAudit`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `setEmailAudit`( $email_audit_key CHAR(20)
, $email_audit_content TEXT
, $email_type_id TINYINT)
BEGIN
		INSERT INTO emails_audit
		( email_audit_key
		, email_audit_content
		, insert_date
		, email_type_id)
		VALUES
		( $email_audit_key
		, $email_audit_content
		, now()
		, $email_type_id); 
END;$$

DELIMITER ;
