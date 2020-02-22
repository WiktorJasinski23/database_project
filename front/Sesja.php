<?php
  
class Sesja extends register{
  
   private $ident = 'test' ;
   private $auth = false ;
  
   function __construct () {
      parent::__construct();
      session_start() ;
   } 
  
public function setSession () {
session_start() ;
if ( isset( $_POST['username'] ) && isset( $_POST['password'] ) ) {
   // Getting submitted user data from database
   $db = new PDO ( 'pgsql:host=localhost;dbname=u7jasinski', 'u7jasinski', '7jasinski' ) ;
   $sth = $db->prepare('SELECT * FROM projekt.users WHERE username = :un');
   $sth->bindValue(':un',$_POST['username']);
   $sth->execute();
  
   $sth->setFetchMode(PDO::FETCH_ASSOC);
   $exist = $sth->fetch();
  
  // Verify user password and set $_SESSION
  if ( $_POST['password'] == $exist[pass] )  {
      $_SESSION['ident'] = $exist[id];
      $_SESSION['name'] = $_POST['username'];
  }
  }
  
session_set_cookie_params(360,"/","fis.agh.edu.pl",true,false) ; 
}
 
function destroySession() {
session_start() ;
$_SESSION = array() ;
if ( isset($_COOKIE[session_name()]) ) {
setcookie( session_name(), '', time()-42000, '/') ;
}
session_destroy();
}    
 
}
?>
