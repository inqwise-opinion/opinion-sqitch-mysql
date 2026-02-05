DELIMITER $$

DROP PROCEDURE IF EXISTS `setServicePackage`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `setServicePackage`( $service_package_id INT(11)
, $sp_name VARCHAR(200)
, $product_id BIGINT(20) UNSIGNED
, $amount DECIMAL(10,2)
, $description VARCHAR(1000)
, $default_usage_period INT(11)
)
BEGIN
	
	INSERT INTO service_packages
	( sp_id
	, sp_name
	, product_id
	, amount
	, description
	, default_usage_period )
	VALUES 
	( $service_package_id
	, $sp_name
	, IFNULL($product_id, sp_id) 
	, $amount
	, $description
	, $default_usage_period )
	ON DUPLICATE KEY UPDATE
		sp_name = IFNULL(VALUES(sp_name), sp_name)
	, amount = IF(is_default, 0, IFNULL(VALUES(amount), amount))
	, description = VALUES(description)
	, default_usage_period = IF(is_default, null, VALUES(default_usage_period))
	, modify_date = NOW(); 
END;$$

DELIMITER ;
