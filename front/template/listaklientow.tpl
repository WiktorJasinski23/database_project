<table border="1">
 <?php 
    if ($data) { 
       echo '<tr><th>Imię</th><th>Nazwisko</th><th>telefon</th><th>mail</th></tr>';
       foreach ( $data as $row ) { 
       echo '<tr><td>'.$row['imie'].'</td><td>'.$row['nazwisko'].'</td><td>'.$row['telefon'].'</td><td>'.$row['mail'].'</td></tr>' ;
    }}
 ?> 