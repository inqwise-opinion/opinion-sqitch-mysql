CREATE TABLE IF NOT EXISTS `geoip_blocks` (
  `gbl_block_start` int(10) unsigned NOT NULL,
  `gbl_block_end` int(10) unsigned NOT NULL,
  `gbl_glc_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`gbl_block_start`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
