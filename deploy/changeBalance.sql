DROP PROCEDURE IF EXISTS changeBalance;

DELIMITER $$
$$
CREATE DEFINER=`opinion`@`localhost` PROCEDURE `changeBalance`( p_account_id BIGINT
, p_backoffice_user_id BIGINT
, p_comments VARCHAR(255)
, p_amount DECIMAL(10,2)
, p_accop_type_id TINYINT
, p_source_id TINYINT(4)
, p_session_id VARCHAR(50)
, p_geo_country_code VARCHAR(4)
, p_client_ip VARCHAR(35)
) 
BEGIN
		DECLARE v_product_id BIGINT;
		DECLARE v_country_id INT(5) DEFAULT NULL;
		DECLARE v_account_operation_id BIGINT;
		DECLARE v_source_id TINYINT(4);
		DECLARE v_valid_amount TINYINT(1) DEFAULT 1;
		DECLARE v_balance DECIMAL(10,2) DEFAULT NULL;		

		START TRANSACTION;
		
		SELECT country_id FROM countries WHERE iso2 = p_geo_country_code INTO v_country_id;
	
		SELECT product_id FROM accounts WHERE account_id = p_account_id INTO v_product_id;
		SET @valid_amount = 1;
		
		UPDATE accounts
		SET balance = @balance := balance + p_amount,
			modify_date = NOW()
		WHERE account_id = p_account_id
			AND status_id != 9 # not deleted
			AND (@valid_amount := (balance + p_amount >= 0))
		LIMIT 1;
		
		IF (@valid_amount) THEN
		 SIGNAL SQLSTATE '45000'
		 SET MESSAGE_TEXT='Invalid amount:p_amount';
		END IF;
		
		IF (ROW_COUNT() = 1) THEN
			
			INSERT INTO accounts_operations
				(accop_type_id, account_id, product_id, amount, client_ip, geo_country_id, balance, backoffice_user_id, comments, source_id)
			VALUES
				(p_accop_type_id, p_account_id, v_product_id, p_amount, p_client_ip, v_country_id, @balance, p_backoffice_user_id, p_comments, v_source_id);
				
			SELECT LAST_INSERT_ID() INTO v_account_operation_id;
		ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT='Account not exist';
		END IF;
		
		SELECT v_account_operation_id as account_operation_id;
		
	COMMIT;
  END$$
DELIMITER ;
