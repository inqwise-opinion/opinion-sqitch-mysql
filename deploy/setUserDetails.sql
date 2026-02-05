DELIMITER $$

DROP PROCEDURE IF EXISTS `setUserDetails`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `setUserDetails`( $user_id BIGINT UNSIGNED
, $title VARCHAR(10)
, $first_name VARCHAR(100)
, $last_name VARCHAR(100)
, $address1 VARCHAR(255)
, $address2 VARCHAR(255)
, $city VARCHAR(100)
, $country_id INT(5)
, $state_id INT(5)
, $postal_code VARCHAR(20)
, $phone1 VARCHAR(20)
, $comments TEXT
, $display_name varchar(50)
, $email varchar(80)
, $send_newsletters tinyint(1)
)
BEGIN
	START TRANSACTION; 
	SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ; 
	
	INSERT INTO `users_details`
	( user_id
	, title
	, first_name
	, last_name
	, address1
	, address2
	, city
	, state_id
	, postal_code
	, phone1
	, comments
	)
	VALUES 
	( $user_id
	, $title
	, $first_name
	, $last_name
	, $address1
	, $address2
	, $city
	, $state_id
	, $postal_code
	, $phone1
	, $comments
	)
	ON DUPLICATE KEY UPDATE
		modify_date = values(insert_date)
	, title       = values(title) 
	, first_name	= values(first_name)
	, last_name		= values(last_name)
	, address1		= values(address1)
	, address2		= values(address2)
	, city				= values(city)
	, state_id		= values(state_id)
	, postal_code	= values(postal_code)
	, phone1			= values(phone1)
	, comments		= values(comments)
	; 
	
	UPDATE users
	SET country_id = $country_id, modify_date = now(),
	display_name = $display_name, email = $email,
	send_newsletters = $send_newsletters
	WHERE user_id = $user_id; 
	
	COMMIT; 
END;$$

DELIMITER ;
