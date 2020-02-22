<table border="1">
 <?php 
    if ($data) { 
       echo '<tr><th> id hotelu</th><th> nazwa</th><th>kraj</th><th>miasto</th><th>adres</th><th>telefon</th><th>strona www</th><th>mail</th></tr>';
       foreach ( $data as $row ) { 
       echo '<tr><td>'.$row['id_hotel'].'</td><td>'.$row['nazwa'].'</td><td>'.$row['kraj'].'</td><td>'.$row['miasto'].'</td><td>'.$row['adres'].'</td><td>'.$row['telefon'].'</td><td>'.$row['www'].'</td><td>'.$row['mail'].'</td></tr>' ;
    }}
 ?> 