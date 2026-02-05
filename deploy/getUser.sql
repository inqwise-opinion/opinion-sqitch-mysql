DELIMITER $$

DROP PROCEDURE IF EXISTS `getUser`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUser`($user_name VARCHAR(80)
,$user_id BIGINT UNSIGNED
,$user_external_id VARCHAR(35)
,$provider_id TINYINT
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
        ROLLBACK; 
        RESIGNAL; 
  END; 
        
	SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	IF(ISNULL(COALESCE($user_name, $user_id, $user_external_id))) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'at last one of the parameters: `$user_name`, `$user_id`, `$user_external_id` mandatory'; 
	END IF; 
	
	IF(!ISNULL($user_external_id) AND IFNULL($provider_id, 1) <= 1  ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '`$user_external_id` going only with external `$provider_id` (greater than 1)'; 
	END IF; 
	
	SELECT u.user_id, IFNULL(u.display_name, u.user_name) as display_name, u.user_name, u.send_newsletters, u.email, u.insert_date, u.country_id, u.provider_id, u.user_external_id, u.gateway_id
	FROM users u
	WHERE (u.user_name = IFNULL($user_name, user_name)
		AND u.user_id = IFNULL($user_id, user_id))
		AND u.user_external_id <=> IFNULL($user_external_id, user_external_id)
		AND IFNULL(u.provider_id, 1) = IFNULL(IFNULL($provider_id, u.provider_id), 1)
	LIMIT 1; 
END;$$

DELIMITER ;
