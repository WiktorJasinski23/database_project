<?php 
 
class baza extends controller 
{
 
    protected $layout ;
    protected $model ;
 
  
    function __construct() {
       parent::__construct() ;
       $this->layout = new view('main') ;
       $this->model  = new model2 ;
       $this->layout->css = $this->css ;
       $this->layout->menu = $this->menu ;
       $this->layout->title  = 'Baza danych SQL' ;
    }
 
    function listaKlientow() {
      if($_SESSION['ident']) {
       $this->layout->header = 'Lista Klientow' ;
       $this->view = new view('listaKlientow') ;
       $this->view->data = $this->model->listaKlientow() ;
       $this->layout->content = $this->view ; 
       return $this->layout ;
      } else {
         $this->layout->header = 'Lista Klientow' ;
         $this->layout->content = 'Dostęp jedynie dla zalogowanych użytkowników';
         return $this->layout ;
      } 
    }

    function listaHoteli() {
      $this->layout->header = 'Lista hoteli' ;
      $this->view = new view('listaHoteli') ;
      $this->view->data = $this->model->listaHoteli() ;
      $this->layout->content = $this->view ; 
      return $this->layout ;
   
   }

   function listaRezerwacji() {
      if($_SESSION['ident']) {
      $this->layout->header = 'Lista Rezerwacji' ;
      $this->view = new view('listarezerwacji') ;
      $this->view->data = $this->model->listaRezerwacji() ;
      $this->layout->content = $this->view ; 
      return $this->layout ;
   } else {
      $this->layout->header = 'Lista Rezerwacji' ;
      $this->layout->content = 'Dostęp jedynie dla zalogowanych użytkowników';
      return $this->layout ;
   } 
   }
   
    
        
   function nowaRezerwacja() {
      if($_SESSION['ident']) {
      $this->layout->header = 'Dodanie nowej rezerwacji' ;
      $this->view = new view('form') ;
      $this->layout->content = $this->view ;
      return $this->layout ;
   } else {
      $this->layout->header = 'Dodanie nowej rezerwacji' ;
      $this->layout->content = 'Dostęp jedynie dla zalogowanych użytkowników';
      return $this->layout ;
   } 
   }

   function oplata() {
      if($_SESSION['ident']) {
      $this->layout->header = 'Sprawdź ranuchek dla danej rezerwacji' ;
      $this->view = new view('form3') ;
      $this->layout->content = $this->view ;
      return $this->layout ;
   } else {
      $this->layout->header = 'Sprawdź ranuchek dla danej rezerwacji' ;
      $this->layout->content = 'Dostęp jedynie dla zalogowanych użytkowników';
      return $this->layout ;
   } 
   }

   function wolnePok(){
      $this->layout->header = 'Sprawdź dostępność pokoi' ;
      $this->view = new view('form4') ;
      $this->layout->content = $this->view ;
      return $this->layout ;
   }

   function rezerwacjaNazwisko(){
      $this->layout->header = 'Sprawdź rezerwacje na nazwwisko' ;
      $this->view = new view('form2') ;
      $this->layout->content = $this->view ;
      return $this->layout ;
   }

    
   function dodajNowaRezerwacja() {
      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if ( isset($obj->fname) and isset($obj->lname) and isset($obj->phone) and isset($obj->mail) and isset($obj->idh) and isset($obj->nr) and isset($obj->dataod) and isset($obj->datado) and isset($obj->typ) ) {    
           $response = $this->model->dodajNowaRezerwacja($obj) ;
      }
      return ( $response = 'true'? "Dodano nową rezerwację" : "Wystąpił błąd podczas dodawania rezerwacji; " ) ;
   }

 

   function doOplata() {
      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if ( isset($obj->id)  ) {    
           $response = $this->model->doOplata($obj) ;
           
         }
      return ( $response ? 'Oplata wynosi: '.strval($response).' zl' : 'Nie ma gościa o takim numerze rezerwacji') ;
   }
   

   function checkReservation() {
      $data = $_POST['data'] ;
      $obj  = json_decode($data) ;
      if ( isset($obj->fname) and isset($obj->lname) ) {    
           $this->model->checkReservation($obj) ;
           
         }
         
   }

function checkFreeRooms() {
   $data = $_POST['data'] ;
   $obj  = json_decode($data) ;
   if ( isset($obj->id_hotel) and isset($obj->losob) and isset($obj->dataod) and isset($obj->datado)) {    
        $this->model->checkFreeRooms($obj) ;
        
      }
      
}

  
}


        
 
 
?>