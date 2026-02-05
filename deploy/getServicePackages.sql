DELIMITER $$

DROP PROCEDURE IF EXISTS `getServicePackages`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicePackages`($product_id INT, $include_non_active TINYINT)
BEGIN
	
	SELECT sp_id, sp_name, product_id, insert_date, description, is_active, amount, IFNULL(is_default,0) as is_default, default_usage_period, max_account_users
	FROM service_packages sp
	WHERE product_id = $product_id 
		AND sp.is_active = IF(IFNULL($include_non_active, 0), sp.is_active, 1); 
END;$$

DELIMITER ;
