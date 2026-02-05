DELIMITER $$

DROP PROCEDURE IF EXISTS `prm_deleteReferences`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prm_deleteReferences`( $definition_key VARCHAR(50)
, $reference_key VARCHAR(50)
, $depends_on_key VARCHAR(50)
)
BEGIN
	DECLARE $definition_id INT DEFAULT NULL; 
	
	SELECT def_id
	FROM prm_definitions
	WHERE def_key = $definition_key
	INTO $definition_id; 
	
	IF(ISNULL($definition_id)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'invalid $definition_key'; 
	END IF; 
	
	IF(ISNULL(COALESCE($reference_key, $depends_on_key))) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'at last one of the parameters: `$reference_key`, `$depends_on_key` mandatory'; 
	END IF; 
	
	DELETE FROM prm_references
	WHERE ref_definition_id = $definition_id
		AND ref_key = IFNULL($reference_key, ref_key)
		AND ref_depends_on_key <=> IFNULL($depends_on_key, ref_depends_on_key); 
END;$$

DELIMITER ;
