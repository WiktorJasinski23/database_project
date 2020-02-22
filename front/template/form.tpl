<form name="form">            

    Imie:<br/>
    <input value="<?php if(isset($formData)) echo $formData['fname']; ?>" type="text" id="fname" name="fname" /><br/>
    Nazwisko:<br/>
    <input value="<?php if(isset($formData)) echo $formData['lname']; ?>" type="text" id="lname" name="lname" /><br/>
    Telefon:<br/>
    <input value="<?php if(isset($formData)) echo $formData['phone']; ?>" type="text" id="phone" name="phone" /><br/>
    Adres mailowy:<br/>
    <input value="<?php if(isset($formData)) echo $formData['mail']; ?>" type="text" id="mail" name="mail" /><br/>
    ID wybranego hotelu:<br/>
    <input value="<?php if(isset($formData)) echo $formData['idh']; ?>" type="text" id="idh" name="idh" /><br/>
    Numer wybranego pokoju:<br/>
    <input value="<?php if(isset($formData)) echo $formData['nr']; ?>" type="text" id="nr" name="nr" /><br/>
    Data zameldowania:<br/>
    <input value="<?php if(isset($formData)) echo $formData['dataod']; ?>" type="date" id="dataod" name="dataod" /><br/>
    Data wymeldowania:<br/>
    <input value="<?php if(isset($formData)) echo $formData['datado']; ?>" type="date" id="datado" name="datado" /><br/>
    Typ płatności:<br/>
    <select id="typ">
		  <option value="1" type="text" >Gotówka</option>
		  <option value="2" type="text" >Karta kredytowa</option>
          <option value="3" type="text" >Czek</option>
          <option value="4" type="text" >Przelew</option>
	  </select><br/>
    <input type="button" value="Zapisz" onclick="fn_dodaj()" />
 
</form> 
<br/><br/>
    <td><span id="response"></span></td></tr>
    <br/><br/>