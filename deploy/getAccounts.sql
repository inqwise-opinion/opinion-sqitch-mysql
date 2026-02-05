DROP procedure IF EXISTS `getAccounts`;

DELIMITER $$
CREATE DEFINER=`opinion`@`localhost` PROCEDURE `getAccounts`( p_user_id INT(11)
, p_product_id BIGINT
, p_include_non_active TINYINT(1)
, p_offset INT
, p_row_count INT
, p_from_insert_date DATE
, p_to_insert_date DATE
, p_account_id_list VARCHAR(2000)
)
BEGIN
	# CALL getAccounts( 1, 1, null, null, null, null, null, null)
	DECLARE v_offset		INT 	UNSIGNED;
	DECLARE v_row_count		INT 	UNSIGNED;
	DECLARE o_count			INT 	UNSIGNED;
    DECLARE v_include_non_active TINYINT(1); 
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    
	SET v_offset = IFNULL(p_offset, 0);
	SET v_row_count = IFNULL(p_row_count, 1000);
    SET v_include_non_active = IFNULL(p_include_non_active, FALSE);
    
	SELECT SQL_CALC_FOUND_ROWS 
    a.account_id, 
    a.uid_prefix, 
    a.owner_id, 
    a.product_id, 
    a.account_name, 
    a.service_package_id, 
    a.insert_date,
	a.is_active,
    a.status_id,
    IFNULL(display_name, u.user_name) owner_name, 
    sp_name, 
    asp.expiry_date AS service_package_expiry_date,
	t.GMT*1000*60*60 AS time_offset
		FROM accounts a
		LEFT JOIN users u ON a.owner_id = u.user_id
		LEFT JOIN service_packages sp ON sp.sp_id = a.service_package_id
		LEFT JOIN timezones t ON a.timezone_id = t.timezone_id
		LEFT JOIN accounts$service_packages asp
			ON a.account_id = asp.account_id
			AND a.service_package_id = asp.service_package_id
		WHERE (a.is_active OR v_include_non_active)
			AND (a.status_id != 9) # NOT DELETED
			AND a.product_id = p_product_id
			AND a.insert_date >= IFNULL(p_from_insert_date, a.insert_date)
			AND a.insert_date <= IFNULL(p_to_insert_date, a.insert_date)
			AND FIND_IN_SET(a.account_id, IFNULL(p_account_id_list, a.account_id)) 
			AND EXISTS (
				SELECT 1 
				FROM users$accounts ua 
				WHERE a.account_id = ua.account_id
				  AND ua.user_id = IFNULL(p_user_id, ua.user_id)
				  AND ua.product_id = p_product_id LIMIT 1)
	ORDER BY a.account_id DESC
    LIMIT v_offset, v_row_count;
    
END$$

DELIMITER ;
;
