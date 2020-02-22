<?php
class model2 
{
 
   protected static $db ;
   private $sth ;
 
   function __construct()
   {
      self::$db = new PDO ( 'pgsql:host=pascal;dbname=u7jasinski;port=5432', 'u7jasinski', '7jasinski' ) ;//interfejs języka PHP przeznaczony do komunikacji z bazami danych
      self::$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_SILENT) ;
   }
 
   public function listaKlientow()
   {
      $this->sth = self::$db->prepare('SELECT * FROM projekt.Goscie') ;
      $this->sth->execute() ;
      $result = $this->sth->fetchAll() ;
      return $result ;
   }

   public function listaHoteli()
   {
      $this->sth = self::$db->prepare('SELECT * FROM projekt.hotele') ;
      $this->sth->execute() ;
      $result = $this->sth->fetchAll() ;
      return $result ;
   }

   public function listaRezerwacji()
   {
      $this->sth = self::$db->prepare('SELECT * FROM projekt.rezerwacja') ;
      $this->sth->execute() ;
      $result = $this->sth->fetchAll() ;
      return $result ;
   }

   public function dodajNowaRezerwacja($obj)
   {
   $this->sth = self::$db->prepare('SELECT nowa_rezerwacja(:fname, :lname, :phone, :mail, :idh, :nr, :dataod, :datado, :typ )');
   $this->sth->bindValue(':fname',$obj->fname,PDO::PARAM_STR) ; 
   $this->sth->bindValue(':lname',$obj->lname,PDO::PARAM_STR) ; 
   $this->sth->bindValue(':phone',$obj->phone,PDO::PARAM_STR) ; 
   $this->sth->bindValue(':mail',$obj->mail,PDO::PARAM_STR) ; 
   $this->sth->bindValue(':idh',$obj->idh,PDO::PARAM_INT) ; 
   $this->sth->bindValue(':nr',$obj->nr,PDO::PARAM_INT) ; 
   $this->sth->bindValue(':dataod',$obj->dataod,PDO::PARAM_STR) ; 
   $this->sth->bindValue(':datado',$obj->datado,PDO::PARAM_STR) ;
   $this->sth->bindValue(':typ',$obj->typ,PDO::PARAM_STR) ;
   $result = $this->sth->execute();
   $resp = (  $result ? 'true' : 'false' ) ;

   if($this->sth->errorCode() != '00000'){
      //echo "\nPDO::errorCode(): ", $this->sth->errorCode();
      if($this->sth->errorCode() == '22007') 
         echo 'Wprowadzono zły format daty! Format, który należy wprowadzić to YYYY-MM-DD!';
      if($this->sth->errorCode() == '00200') 
         echo 'Nie ma hotelu o takim ID!';
      if($this->sth->errorCode() == '00201') 
         echo 'Data wymeldowania musi być wcześniejsza niż data zameldowania! Proszę sprawdzić wprowadzone dane.';
   }

   return $resp ; 
   }


   public function doOplata($obj)
   {
   $this->sth = self::$db->prepare('SELECT * FROM projekt.oplata_za_pobyt(:id)');
   $this->sth->bindValue(':id',$obj->id,PDO::PARAM_INT) ; 
   $this->sth->execute() ;

   if($this->sth->errorCode() != '00000'){
      //echo "\nPDO::errorCode(): ", $this->sth->errorCode();
      if($this->sth->errorCode() == '00200'){
         
         return false;
      }
   }
   $exist = $this->sth->fetch();
   
   $resp = ( $exist ? $exist[0] : 'false' ) ;
   return $resp ; 
   }

   public function checkFreeRooms($obj)
   {
     
   $this->sth = self::$db->prepare('SELECT * FROM projekt.wolne_pokoje( :id_hotel, :losob, :dataod, :datado)');
   $this->sth->bindValue(':id_hotel',$obj->id_hotel,PDO::PARAM_INT) ; 
   $this->sth->bindValue(':losob',$obj->losob,PDO::PARAM_INT) ; 
   $this->sth->bindValue(':dataod',$obj->dataod,PDO::PARAM_STR) ; 
   $this->sth->bindValue(':datado',$obj->datado,PDO::PARAM_STR) ;
   $this->sth->execute() ;
    if($this->sth->errorCode() != '00000'){
      //echo "\nPDO::errorCode(): ", $this->sth->errorCode();
      if($this->sth->errorCode() == '22007') 
         echo 'Wprowadzono zły format daty! Format, który należy wprowadzić to YYYY-MM-DD!';
      if($this->sth->errorCode() == '00200') 
         echo 'Nie ma hotelu o takim ID!';
      if($this->sth->errorCode() == '00201') 
         echo 'Data wymeldowania musi być wcześniejsza niż data zameldowania! Proszę sprawdzić wprowadzone dane.';
      
   }

   else{
   echo '<table border=1>';
   echo '<tr><td>'.'Numer pokoju'.' </td>';
      echo '<td>'.'Typ pokoju'.' </td>';
      echo '<td>'.'Pietro'.' </td>';
      echo '<td>'.'Cena'.' </td>';
      echo '<td>'.'Dla palacych'.' </td></tr>';
   while($exist = $this->sth->fetch()){
      if($exist[4] == 1){
         $palenie = 'tak';
      }
      else{
         $palenie = 'nie';
      }
      echo '<tr><td>'.$exist[0].' </td>';
      echo '<td>'.$exist[1].' </td>';
      echo '<td>'.$exist[2].' </td>';
      echo '<td>'.$exist[3].' </td>';
      echo '<td>'.$palenie.' </td></tr>';
   
   }
   echo'</table>';
}
   }

   public function checkReservation($obj)
   {
   $this->sth = self::$db->prepare('SELECT * FROM projekt.rezerwacjananazwisko(:fname, :lname)');
   $this->sth->bindValue(':fname',$obj->fname,PDO::PARAM_STR) ; 
   $this->sth->bindValue(':lname',$obj->lname,PDO::PARAM_STR) ; 
   $this->sth->execute() ;
  
   if($this->sth->errorCode() != '00000'){
      echo "\nPDO::errorCode(): ", $this->sth->errorCode(); 
   }
   else{
   echo '<table border=1>';
   echo '<tr><td>'.'Imie'.' </td>';
      echo '<td>'.'Nazwisko'.' </td>';
      echo '<td>'.'Data zameldowania'.' </td>';
      echo '<td>'.'Data wymeldowania'.' </td>';
      echo '<td>'.'Status rezerwacji'.' </td></tr>';
   while($exist = $this->sth->fetch()){
      echo '<tr><td>'.$exist[0].' </td>';
      echo '<td>'.$exist[1].' </td>';
      echo '<td>'.$exist[2].' </td>';
      echo '<td>'.$exist[3].' </td>';
      echo '<td>'.$exist[4].' </td></tr>';
   
   }
   echo'</table>';
   }
   }
 
}
?>