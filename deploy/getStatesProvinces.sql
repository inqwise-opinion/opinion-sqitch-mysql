DELIMITER $$

DROP PROCEDURE IF EXISTS `getStatesProvinces`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStatesProvinces`( $country_id INT(5) UNSIGNED )
BEGIN
	SELECT st.id, st.country_id, st.name, st.abbreviation
	FROM states st
	WHERE st.country_id = IFNULL($country_id, st.country_id); 
END;$$

DELIMITER ;
