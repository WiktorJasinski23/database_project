<form name="form3">            

    ID Rezerwacji:<br/>
    <input value="<?php if(isset($formData)) echo $formData['id']; ?>" type="text" id="id" name="id" /><br/><br/>
    <input type="button" value="Sprawdź" onclick="fn_oplata()" />
  
    
</form> 
  <br/><br/>
    <span id="response"></span>
  <br/><br/>
