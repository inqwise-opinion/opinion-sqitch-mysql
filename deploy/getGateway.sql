DELIMITER $$

DROP PROCEDURE IF EXISTS `getGateway`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getGateway`( $gateway_id BIGINT(20)
)
BEGIN
	SELECT g.gateway_id, g.gateway_name, g.campaign_id, g.gateway_description, g.create_date, g.modify_date, c.first_login_landing_page
	FROM gateways g
	JOIN campaigns c
	WHERE g.campaign_id = c.campaign_id
		AND g.gateway_id = $gateway_id; 
END;$$

DELIMITER ;
