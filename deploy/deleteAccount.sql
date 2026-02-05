DROP procedure IF EXISTS `deleteAccount`;

DELIMITER $$
CREATE DEFINER=`opinion`@`localhost` PROCEDURE `deleteAccount`(p_account_id INT(11))
#CALL deleteAccount(-1)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	IF ((p_account_id IS NULL) OR p_account_id = 0) THEN
		 SIGNAL SQLSTATE '45000'
		 SET MESSAGE_TEXT='The input parameters cannot be null or zero:p_account_id';
	END IF;

	UPDATE accounts
	SET 
		status_id = 9, modify_date = NOW()
	WHERE
		account_id = p_account_id;
	
END$$
DELIMITER ;
