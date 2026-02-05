DROP PROCEDURE IF EXISTS setAccountServicePackage;

DELIMITER $$
$$
CREATE DEFINER=`opinion`@`localhost` PROCEDURE `setAccountServicePackage`(p_account_id BIGINT UNSIGNED
,p_service_package_id INT UNSIGNED
,p_service_package_expiry_date DATETIME
,p_max_users INT
)
BEGIN
	
	DECLARE v_current_service_package_id INT;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	START TRANSACTION;
	
	SELECT service_package_id
	FROM accounts
	WHERE account_id = p_account_id
	  AND status_id != 9 # not deleted
	INTO v_current_service_package_id;
	
	IF(ISNULL(v_current_service_package_id)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'invalid p_account_id';
	END IF;
	
	INSERT INTO accounts$service_packages
	(account_id, service_package_id, expiry_date, insert_date, max_users)
	VALUES
	(p_account_id, p_service_package_id, p_service_package_expiry_date, NOW(), p_max_users)
	ON DUPLICATE KEY UPDATE
	 expiry_date = VALUES(expiry_date)
	,max_users = VALUES(max_users);
	
	IF(v_current_service_package_id <> p_service_package_id) THEN
		
		DELETE FROM accounts$service_packages
		WHERE account_id = p_account_id
			AND service_package_id = v_current_service_package_id
		LIMIT 1;
			
		
		DELETE FROM prm_references
		WHERE ref_depends_on_key = CONCAT(2, ':', v_current_service_package_id);
		
		
		UPDATE accounts
		SET service_package_id = p_service_package_id
		
		WHERE account_id = p_account_id;
	END IF;
	
	COMMIT;
	
END$$
DELIMITER ;
