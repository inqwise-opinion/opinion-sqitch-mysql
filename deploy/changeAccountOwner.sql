DROP PROCEDURE IF EXISTS changeAccountOwner;

DELIMITER $$
$$
CREATE DEFINER=`opinion`@`localhost` PROCEDURE `changeAccountOwner`( p_source_id TINYINT(4)
, p_new_owner_id BIGINT
, p_account_id BIGINT
, p_backoffice_user_id BIGINT
) 
BEGIN
	#CALL changeAccountOwner(:p_source_id, :p_new_owner_id, :p_account_id, :p_backoffice_user_id)
	DECLARE v_balance DECIMAL(10,2) UNSIGNED;
	DECLARE v_product_id BIGINT;
	DECLARE v_accop_type_id INT DEFAULT 10;
	DECLARE v_account_operation_id BIGINT;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
  
	START TRANSACTION;
	
	SELECT balance, product_id
	FROM accounts
	WHERE account_id = p_account_id
	  AND status_id != 9 # not deleted
	INTO v_balance, v_product_id;	
	
	IF(ISNULL(v_balance)) THEN
	    SIGNAL SQLSTATE '45400'
        SET MESSAGE_TEXT = 'Account not found';
	END IF;
	
	UPDATE accounts a
	SET a.owner_id = p_new_owner_id,
	a.modify_date = NOW()
	WHERE a.account_id = p_account_id;
	  
	
	INSERT INTO accounts_operations
	(accop_type_id, user_id, account_id, product_id, source_id, balance, `backoffice_user_id`)
	VALUES
	(v_accop_type_id, p_new_owner_id, p_account_id, v_product_id, p_source_id, v_balance, p_backoffice_user_id);
	
	SELECT LAST_INSERT_ID() INTO v_account_operation_id;
	
	SELECT v_account_operation_id as account_operation_id;
	
	COMMIT;
END$$
DELIMITER ;
