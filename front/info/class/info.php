<?php
 
class info extends controller {
 
   protected $layout ;
 
   function __construct() {
      parent::__construct() ;
      $this->layout = new view('main') ; 
      $this->layout->css = $this->css ;
      $this->layout->menu = $this->menu ;   
      $this->layout->title = 'Strona główna' ;
   }
 
  function index() {
      $this->layout->header  = 'Strona główna' ;
      $this->view = new view('mainpage');
      $this->layout->content = $this->view ; 
      return $this->layout ;
  }

  function index2() {
     $this->layout->header  = 'Strona główna' ;
     $this->menu = '';
     $this->view = new view('login');
     $this->layout->content = $this->view ; 
     return $this->layout ;
}
 
function logout() {
   $sesja = new Sesja();
   $sesja->destroySession() ;
   $this->view = new view('logout');
   $this->layout->content = $this->view ; 
   return $this->layout ;
}
 
}
 
?>