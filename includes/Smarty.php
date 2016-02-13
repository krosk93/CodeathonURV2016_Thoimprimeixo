<?php
require('Smarty/Smarty.class.php');
$smarty = new Smarty();
$smarty->setTemplateDir(dirname(__FILE__).'/smarty/templates');
$smarty->setCompileDir(dirname(__FILE__).'/smarty/templates_c');
$smarty->setCacheDir(dirname(__FILE__).'/smarty/cache');
$smarty->setConfigDir(dirname(__FILE__).'/smarty/configs');
?>