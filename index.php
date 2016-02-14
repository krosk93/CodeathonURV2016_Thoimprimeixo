<?php
require("vendor/autoload.php");
$smarty = new Smarty();
$smarty->setTemplateDir(dirname(__FILE__).'/includes/smarty/templates');
$smarty->setCompileDir(dirname(__FILE__).'/includes/smarty/templates_c');
$smarty->setCacheDir(dirname(__FILE__).'/includes/smarty/cache');
$smarty->setConfigDir(dirname(__FILE__).'/includes/smarty/configs');
if($_GET['lang'] == "es"){
  $smarty->display('login_usuarios.es.tpl');
}elseif($_GET['lang'] == "en"){
    $smarty->display('login_usuarios.en.tpl');
} else {
  $smarty->display('login_usuarios.cat.tpl');
}

?>
