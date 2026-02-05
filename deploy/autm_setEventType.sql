DELIMITER $$

DROP PROCEDURE IF EXISTS `autm_setEventType`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `autm_setEventType`( $event_type_id INT
, $event_type_name VARCHAR(255)
, $event_type_description TEXT
, $event_type_recipients TEXT
)
BEGIN
	INSERT INTO autm_event_types
	( event_type_id
	, event_type_name
	, event_type_description
	, event_type_recipients
	)
	VALUES 
	( $event_type_id
	, IFNULL($event_type_name, '')
	, $event_type_description
	, $event_type_recipients
	) ON DUPLICATE KEY UPDATE
	  event_type_name = IFNULL($event_type_name, event_type_name)
	, event_type_description = IFNULL($event_type_description, event_type_description)
	, event_type_recipients = $event_type_recipients
	; 
END;$$

DELIMITER ;
