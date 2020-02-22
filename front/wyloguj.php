<?php

function __autoload($class_name) {
    include $class_name . '.php' ;
}

 
$sesja = new Sesja();
$sesja->destroySession() ;
    echo "Wylogowano";
    echo '</br>';
    echo '<a href="index.php">Powrot</a>';
   
?>
