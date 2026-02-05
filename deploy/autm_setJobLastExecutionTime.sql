DELIMITER $$

DROP PROCEDURE IF EXISTS `autm_setJobLastExecutionTime`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `autm_setJobLastExecutionTime`($job_id TINYINT
,$job_last_execution_date DATETIME
)
BEGIN
	
		UPDATE autm_jobs 
		SET job_modify_date = now(),
			job_last_execution_date = $job_last_execution_date
		WHERE job_id = $job_id; 
END;$$

DELIMITER ;
