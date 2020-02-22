<?php
 
try {
  function __autoload($class_name) {
   
   if       ( file_exists($path = $class_name.'.php')) {
      include $class_name.'.php' ;
   }
    elseif       ( file_exists($path = 'baza/class/'.$class_name.'.php')) {
       include 'baza/class/'.$class_name.'.php' ;
    } elseif ( file_exists($path = 'info/class/'.$class_name.'.php')) {
       include 'info/class/'.$class_name.'.php' ;
    } elseif ( file_exists($path = 'test/class/'.$class_name.'.php')) {
       include 'test/class/'.$class_name.'.php' ;
    } elseif ( file_exists($path = 'appl/'.$class_name.'.php')) {
       include 'appl/'.$class_name.'.php' ;
    } else {
       controller::http404() ;
    }
  }
  session_start();

   if($_POST){
      $reg = new register ;
      $reg->_read();

      session_start();

      $sesja = new Sesja();
    $sesja->setSession() ;
} 
  
if($_SESSION['ident']){
  if (empty ($_GET['sub']))    { $contr = 'info' ;   }
  else                         { $contr = $_GET['sub'] ; }
  if (empty ($_GET['action'])) { $action     = 'index' ;  }
  else                         { $action     = $_GET['action'] ; } 
   
  $controller = new $contr() ;
  echo $controller->$action() ;
}

  else{
   if (empty ($_GET['sub']))    { $contr = 'info' ;   }
   else                         { $contr = $_GET['sub'] ; }
   if (empty ($_GET['action'])) { $action     = 'index2' ;  }
   else                         { $action     = $_GET['action'] ; } 
    
   $controller = new $contr() ;
   echo $controller->$action() ;
   }



}
catch (Exception $e) {
  echo 'Blad: [' . $e->getCode() . '] ' . $e->getMessage() ;
}
 
?>