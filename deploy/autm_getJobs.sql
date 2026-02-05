DELIMITER $$

DROP PROCEDURE IF EXISTS `autm_getJobs`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `autm_getJobs`()
BEGIN
	SELECT 	job_id, 
	job_description, 
	job_insert_date, 
	job_modify_date, 
	job_last_execution_date, 
	job_schedule_at,
	job_schedule_task_id,
	job_assembly_id,
	assembly_name
	FROM autm_jobs j
	LEFT JOIN autm_assembiles a ON job_assembly_id = assembly_id
	WHERE job_active; 
END;$$

DELIMITER ;
