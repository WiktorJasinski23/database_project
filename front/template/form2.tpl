<form name="form">            
  
    Imię: <br/>
    <input value="<?php if(isset($formData)) echo $formData['fname']; ?>" type="text" id="fname" name="fname" /><br/>
    Nazwisko:<br/>
    <input value="<?php if(isset($formData)) echo $formData['lname']; ?>" type="text" id="lname" name="lname" /><br/>
    <input type="button" value="Sprawdz" onclick="fn_checkReservation()" />
  
</form> 
<br/><br/>
    <span id="response"></span></td>
    <br/><br/>

