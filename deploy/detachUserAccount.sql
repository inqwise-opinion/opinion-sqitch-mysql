DROP PROCEDURE IF EXISTS detachUserAccount;

DELIMITER $$
$$
CREATE DEFINER=`opinion`@`localhost` PROCEDURE `detachUserAccount`( p_source_id TINYINT(4)
, p_user_id BIGINT
, p_account_id BIGINT
, p_backoffice_user_id BIGINT
)
BEGIN
	DECLARE v_balance DECIMAL(10,2) UNSIGNED;
	DECLARE v_product_id BIGINT;
	DECLARE v_owner_id BIGINT;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
  
	START TRANSACTION;
	
	SELECT balance, product_id, owner_id 
	FROM accounts
	WHERE account_id = p_account_id
	  AND status_id != 9 # not deleted
	INTO v_balance, v_product_id, v_owner_id;	
	
	IF(ISNULL(v_balance)) THEN
	    SIGNAL SQLSTATE  '45400'
        SET MESSAGE_TEXT = 'Account not found';
	END IF;
	
	IF(p_user_id = v_owner_id) THEN
	    SIGNAL SQLSTATE '45400'
        SET MESSAGE_TEXT = 'Unable to detach account from owner';
	END IF;
	
	
	DELETE FROM users$accounts 
	WHERE account_id = p_account_id
	  AND user_id = p_user_id;
	
	IF (ROW_COUNT() = 0) THEN
	    SIGNAL SQLSTATE '45400'
        SET MESSAGE_TEXT = 'Not attached';
	END IF;
	
	INSERT INTO accounts_operations
	(accop_type_id, user_id, account_id, product_id, source_id, balance, `backoffice_user_id`)
	VALUES
	(9  , p_user_id, p_account_id, v_product_id, p_source_id, v_balance, p_backoffice_user_id);
	
	COMMIT;
	
END$$
DELIMITER ;
