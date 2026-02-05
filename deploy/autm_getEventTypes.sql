DELIMITER $$

DROP PROCEDURE IF EXISTS `autm_getEventTypes`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `autm_getEventTypes`()
BEGIN
	SELECT event_type_id, event_type_name, modify_date, event_type_description, event_type_recipients
	FROM autm_event_types; 
END;$$

DELIMITER ;
