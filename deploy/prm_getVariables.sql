DELIMITER $$

DROP PROCEDURE IF EXISTS `prm_getVariables`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prm_getVariables`($categories VARCHAR(255)
,$entity_type_id TINYINT
,$entity_id BIGINT
,$via_references VARCHAR(500)
)
BEGIN
	DECLARE $max_priority_id TINYINT DEFAULT NULL; 
	
	SELECT lkp_item_priority_id
	FROM prm_lookups
	WHERE lkp_item_id = $entity_type_id
		AND lkp_section_id = 1 
	INTO $max_priority_id; 
	
	
	DROP TABLE IF EXISTS tmp_definitions;		
	CREATE TEMPORARY TABLE tmp_definitions
	(PRIMARY KEY (`def_id`))
	SELECT d.def_id, d.def_value_type_id, d.def_description, def_name, def_key, def_value
	FROM prm_definitions d
	LEFT JOIN prm_references r
		ON ref_definition_id = def_id
		AND ref_entity_type_id = 1  
	WHERE def_is_active
		AND IFNULL(FIND_IN_SET(ref_entity_id, $categories),1); 
	
	
	DROP TABLE IF EXISTS tmp_via_references;		
	CREATE TEMPORARY TABLE tmp_via_references
	(PRIMARY KEY (`ref_priority_id`, `def_id`))
	SELECT ref_id, IFNULL(r.ref_priority_id, l.lkp_item_priority_id) AS ref_priority_id, d.def_id
	FROM prm_lookups l
	LEFT JOIN prm_references r
		ON l.lkp_item_id = ref_entity_type_id
		AND FIND_IN_SET(ref_key, $via_references)
		AND !ISNULL(ref_priority_id)
	JOIN tmp_definitions d
	WHERE lkp_section_id = 1 
		AND !ISNULL(COALESCE(r.ref_priority_id, l.lkp_item_priority_id))
		AND $via_references REGEXP CONCAT(lkp_item_id, ':')
		AND d.def_id = IFNULL(r.ref_definition_id, d.def_id); 
		
	
	SELECT d.def_id, d.def_value_type_id, d.def_description, def_name, def_key, def_value
	FROM tmp_definitions d; 
	
	
	SELECT r.ref_definition_id, r.ref_id, r.ref_entity_type_id, r.ref_entity_id, r.ref_value, r.ref_priority_id
	FROM prm_references r
	JOIN tmp_definitions d
	LEFT JOIN prm_lookups l 
		ON r.ref_entity_type_id = lkp_item_id
		AND l.lkp_section_id = 1 
	LEFT JOIN tmp_via_references vr
		ON r.ref_priority_id = vr.ref_priority_id
		AND r.ref_definition_id = vr.def_id
	WHERE r.ref_definition_id = d.def_id
		AND $max_priority_id >= IFNULL(lkp_item_priority_id, $max_priority_id)
		AND ($via_references REGEXP CONCAT(ref_entity_type_id,':',ref_entity_id) 
		
			OR (ref_entity_id = $entity_id AND ref_entity_type_id = $entity_type_id )
		)
		AND (ISNULL(vr.ref_id) AND ISNULL(vr.ref_priority_id)
					OR vr.ref_id = r.ref_id)
	ORDER BY ref_priority_id DESC; 
	
	
	SELECT * FROM tmp_via_references; 
		
	
	
	DROP TABLE IF EXISTS tmp_definitions; 
	DROP TABLE IF EXISTS tmp_via_references; 
END;$$

DELIMITER ;
