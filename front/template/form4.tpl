<form name="form">            
  
    ID hotelu: <br/>
    <input value="<?php if(isset($formData)) echo $formData['id_hotel']; ?>" type="text" id="id_hotel" name="id_hotel" /><br/>
    Ile osob w pokoju:<br/>
    <input value="<?php if(isset($formData)) echo $formData['losob']; ?>" type="text" id="losob" name="losob" /><br/>
    Data od:<br/>
    <input value="<?php if(isset($formData)) echo $formData['dataod']; ?>" type="date" id="dataod" name="dataod" /><br/>
    Data do:<br/>
    <input value="<?php if(isset($formData)) echo $formData['datado']; ?>" type="date" id="datado" name="datado" /><br/><br/>
    <input type="button" value="Sprawdz" onclick="fn_checkFreeRooms()" />
  
</form> 
<br/><br/>
    <span id="response"></span></td>
    <br/><br/>

