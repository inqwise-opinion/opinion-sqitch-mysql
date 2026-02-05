DELIMITER $$

DROP PROCEDURE IF EXISTS `prm_setVariable`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prm_setVariable`($definition_key VARCHAR(50)
,$entity_id BIGINT
,$entity_type_id TINYINT
,$ref_value VARCHAR(50)
,$user_id BIGINT
,$depends_on_key VARCHAR(50)
)
BEGIN
	DECLARE $priority_id TINYINT DEFAULT NULL; 
	DECLARE $definition_id INT DEFAULT NULL; 
	
	SELECT def_id
	FROM prm_definitions
	WHERE def_key = $definition_key
	INTO $definition_id; 
	
	IF(ISNULL($definition_id)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'invalid $definition_key'; 
	END IF; 
	
	SELECT lkp_item_priority_id
	FROM prm_lookups
	WHERE lkp_item_id = $entity_type_id
		AND lkp_section_id = 1 
	INTO $priority_id; 
	
	IF(ISNULL($priority_id)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'invalid $entity_type_id'; 
	END IF; 
	
	INSERT INTO prm_references 
	(ref_definition_id, ref_entity_type_id, ref_entity_id, ref_value , ref_priority_id, ref_insert_date, ref_modify_user_id, ref_key											 , ref_depends_on_key)
	VALUES 
	($definition_id		, $entity_type_id		, $entity_id	 , $ref_value, $priority_id		, NOW()					 , $user_id, CONCAT($entity_type_id, ':', $entity_id), $depends_on_key)
	ON DUPLICATE KEY UPDATE
		ref_modify_date = values(ref_insert_date)
	, ref_modify_user_id = values(ref_modify_user_id)
	, ref_value = values(ref_value)
	, ref_depends_on_key = values(ref_depends_on_key); 
	
END;$$

DELIMITER ;
