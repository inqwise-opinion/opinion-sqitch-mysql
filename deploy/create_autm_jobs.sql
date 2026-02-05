CREATE TABLE IF NOT EXISTS `autm_jobs` (
  `job_id` tinyint(3) unsigned NOT NULL,
  `job_description` text,
  `job_insert_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `job_modify_date` datetime DEFAULT NULL,
  `job_last_execution_date` datetime DEFAULT NULL,
  `job_schedule_at` text,
  `job_schedule_task_id` tinyint(4) DEFAULT NULL,
  `job_assembly_id` tinyint(4) DEFAULT NULL,
  `job_active` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
