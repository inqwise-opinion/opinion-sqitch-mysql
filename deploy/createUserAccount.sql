DELIMITER $$

DROP PROCEDURE IF EXISTS `createUserAccount`$$

CREATE DEFINER=`opinion`@`localhost` PROCEDURE `createUserAccount`( p_client_ip VARCHAR(16)
, p_country_id INT(5)
, p_account_name VARCHAR(50)
, p_uid_prefix VARCHAR(50)
, p_source_id TINYINT(4)
, p_product_id BIGINT
, p_service_package_id BIGINT
, p_user_id BIGINT
, p_backoffice_user_id BIGINT
)
BEGIN
	DECLARE v_timezone_id INT(5) DEFAULT NULL;
	DECLARE v_account_operation_id BIGINT;
	DECLARE v_account_id BIGINT;
	DECLARE v_active TINYINT(1) DEFAULT 1;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
  
	START TRANSACTION;
	
	SELECT 
    default_timezone_id
FROM
    countries
WHERE
    country_id = p_country_id INTO v_timezone_id;
	
	
	INSERT INTO accounts (owner_id, product_id, account_name, uid_prefix, is_active, service_package_id, timezone_id, status_id)
	VALUES (p_user_id, p_product_id, p_account_name, p_uid_prefix, v_active, p_service_package_id, v_timezone_id, IF(v_active, 2, 1));
	SET v_account_id = LAST_INSERT_ID();
		
	INSERT INTO users$accounts 
	(account_id, user_id, product_id)
	VALUES
	(v_account_id, p_user_id, p_product_id);
	
	INSERT INTO accounts_operations
	(accop_type_id, user_id, account_id, product_id, source_id, amount, sp_id, client_ip, geo_country_id, balance, `backoffice_user_id`)
	VALUES
	(1  , p_user_id, v_account_id, p_product_id, p_source_id, 0, p_service_package_id, p_client_ip, p_country_id, 0, p_backoffice_user_id);
	
	SET v_account_operation_id = LAST_INSERT_ID();
	
	COMMIT;
	
	SELECT v_account_id AS account_id, p_uid_prefix as uid_prefix;
END$$

DELIMITER ;
