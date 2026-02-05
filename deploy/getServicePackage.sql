DELIMITER $$

DROP PROCEDURE IF EXISTS `getServicePackage`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getServicePackage`( $service_package_id INT
, $product_id INT)
BEGIN
	SELECT sp_id, sp_name, product_id, insert_date, description, IFNULL(is_default,0) as is_default, default_usage_period, amount, max_account_users
	FROM service_packages sp
	WHERE sp_id = $service_package_id
		AND product_id = IFNULL($product_id, product_id)
	LIMIT 1; 
END;$$

DELIMITER ;
