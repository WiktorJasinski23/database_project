<table border="1">
 <?php 
    if ($data) { 
       echo '<tr><th>id rezerwacji</th><th> nazwisko</th><th> imie</th><th>Biuro podróży</th><th>nazwa hotelu </th><th>numer pokoju</th><th>Data zameldowania</th><th>Data wymeldowania</th></tr>';
       foreach ( $data as $row ) { 
       echo '<tr><td>'.$row['id_rezerwacji'].'</td><td>'.$row['nazwisko'].'</td><td>'.$row['imie'].'</td><td>'.$row['nazwa_agencji'].'</td><td>'.$row['nazwa'].'</td><td>'.$row['nr_pokoju'].'</td><td>'.$row['dataod'].'</td><td>'.$row['datado'].'</td></tr>' ;
    }}
 ?> 


 SELECT 