DROP PROCEDURE IF EXISTS setAccountDetails;

DELIMITER $$
$$
CREATE DEFINER=`opinion`@`localhost` PROCEDURE `setAccountDetails`( p_account_id BIGINT UNSIGNED
, p_comments VARCHAR(1000)
, p_timezone_id INT(11)
, p_account_name VARCHAR(200)
, p_is_active TINYINT(1)
, p_include_deposit_bounds TINYINT(1)
, p_min_deposit_amount DECIMAL(10,2)
, p_max_deposit_amount DECIMAL(10,2)
)
BEGIN 
	
	DECLARE v_timestamp DATETIME DEFAULT NOW();
	DECLARE v_status_id TINYINT(2) DEFAULT NULL;
	DECLARE v_include_deposit_bounds TINYINT(1) DEFAULT IFNULL(p_include_deposit_bounds, FALSE);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	START TRANSACTION;
	
	IF (NOT p_is_active IS NULL) THEN
		SET v_status_id = IF(p_is_active, 2, 1);
	END IF;
	
	UPDATE accounts
	SET modify_date = v_timestamp
		, account_name = IFNULL(p_account_name, account_name)
		, is_active = IFNULL(p_is_active, is_active)
		, status_id = IFNULL(v_status_id, status_id)
		, timezone_id = IFNULL(p_timezone_id, timezone_id)
		, min_deposit_amount = IF(v_include_deposit_bounds, p_min_deposit_amount, min_deposit_amount)
		, max_deposit_amount = IF(v_include_deposit_bounds, p_max_deposit_amount, max_deposit_amount)
	WHERE account_id = p_account_id
	  AND status_id != 9; # not deleted

	IF (ROW_COUNT() = 0) THEN
	    SIGNAL SQLSTATE '45400'
        SET MESSAGE_TEXT = 'Account not found';
	END IF;
	
	INSERT INTO accounts_details
	( account_id
	, comments
	)
	VALUES
	( p_account_id
	, p_comments
	) ON DUPLICATE KEY UPDATE
	  comments = values(comments)
	, modify_date = v_timestamp
	;
	
	
	
	
	COMMIT;
END$$
DELIMITER ;
