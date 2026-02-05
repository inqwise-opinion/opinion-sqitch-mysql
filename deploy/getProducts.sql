DELIMITER $$

DROP PROCEDURE IF EXISTS `getProducts`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProducts`($product_guid VARCHAR(36), $product_id BIGINT)
BEGIN
	
	DROP TABLE IF EXISTS tmp_products;		
	CREATE temporary TABLE tmp_products
		(PRIMARY KEY (`product_id`))
	SELECT p.product_id, p.product_guid, p.product_name, p.description, p.feedback_caption,
	 p.feedback_short_caption, p.support_email, p.no_reply_email, p.admin_email, p.sales_email,
	 p.contact_us_email
	FROM products p
	WHERE p.product_guid = IFNULL($product_guid, p.product_guid)
		AND p.product_id = IFNULL($product_id, p.product_id)
	ORDER BY order_id; 
	
	SELECT * FROM tmp_products; 
	DROP TABLE IF EXISTS tmp_products;		
	
END;$$

DELIMITER ;
