<?php
// autoload entry points
$dirs = glob(WPMU_PLUGIN_DIR . '/*' , GLOB_ONLYDIR);
foreach ($dirs as $dir) {
	if (! is_dir($dir)){
		continue;
	}
	$plugin = sprintf('%s/%s.php', basename($dir), basename($dir) );
	include_once($plugin);
}