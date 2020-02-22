function fn_dodaj()
 {
     var fname = document.getElementById("fname").value ;
     var lname = document.getElementById("lname").value ;
     var phone  = document.getElementById("phone").value ;
     var mail = document.getElementById("mail").value ;
     var idh = document.getElementById("idh").value ;
     var nr = document.getElementById("nr").value ;
     var dataod  = document.getElementById("dataod").value ;
     var datado = document.getElementById("datado").value ;
     var typ = document.getElementById("typ").value ;
     
     var json_data = "{\"fname\":\"" + fname + "\",\"lname\":\"" + lname + "\",\"phone\":\"" + phone + "\",\"mail\":\"" + mail + "\",\"idh\":\"" + idh +"\",\"nr\":\"" + nr +"\",\"dataod\":\"" + dataod +"\",\"datado\":\"" + datado +"\",\"typ\":\"" + typ +"\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=baza&action=dodajNowaRezerwacja" ;
     resp = function(response) {
        // alert ( response ) ;
        document.getElementById("response").innerHTML = response ; 
      }
      xmlhttpPost (url, msg, resp) ;                          
}  


function fn_oplata()
 {
     var id = document.getElementById("id").value ;
     
     var json_data = "{\"id\":\"" + id + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=baza&action=doOplata" ;
     resp = function(response) {
        // alert ( response ) ;
        
        document.getElementById("response").innerHTML = response ; 
      }
      xmlhttpPost (url, msg, resp) ;                          
}

function fn_checkFreeRooms()
{
  var id_hotel = document.getElementById("id_hotel").value ;
  var losob = document.getElementById("losob").value ;
  var dataod  = document.getElementById("dataod").value ;
  var datado = document.getElementById("datado").value ;
  
  var json_data = "{\"id_hotel\":\"" + id_hotel + "\",\"losob\":\"" + losob + "\",\"dataod\":\"" + dataod + "\",\"datado\":\"" + datado + "\"}" ;
  var msg = "data=" + encodeURIComponent(json_data) ;
  var url = "index.php?sub=baza&action=checkFreeRooms" ;
  resp = function(response) {
     // alert ( response ) ;
     document.getElementById("response").innerHTML = response ; 
   }
   xmlhttpPost (url, msg, resp) ;                          
}  

function fn_checkReservation()
{
  var fname = document.getElementById("fname").value ;
  var lname = document.getElementById("lname").value ;
  
  var json_data = "{\"fname\":\"" + fname + "\",\"lname\":\"" + lname + "\"}" ;
  var msg = "data=" + encodeURIComponent(json_data) ;
  var url = "index.php?sub=baza&action=checkReservation" ;
  resp = function(response) {
     // alert ( response ) ;
     document.getElementById("response").innerHTML = response ; 
   }
   xmlhttpPost (url, msg, resp) ;                          
}

function xmlhttpPost(strURL, mess, respFunc) {
    var xmlHttpReq = false;
    var self = this;
    // Mozilla/Safari
    if (window.XMLHttpRequest) {
        self.xmlHttpReq = new XMLHttpRequest();
    }
    // IE
    else if (window.ActiveXObject) {
        self.xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
    }
    self.xmlHttpReq.onreadystatechange = function() {
    if(self.xmlHttpReq.readyState == 4){
        // alert ( self.xmlHttpReq.status ) ;
        if ( self.xmlHttpReq.status == 200 ) {    
           // document.getElementById("data").innerHTML = http_request.responseText;
          respFunc( self.xmlHttpReq.responseText ) ;
        }
        else if ( self.xmlHttpReq.status == 401 ) {
           window.location.reload() ;
        } 
      }
    }
    self.xmlHttpReq.open('POST', strURL);
    self.xmlHttpReq.setRequestHeader("X-Requested-With","XMLHttpRequest");
    self.xmlHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded; ");
    self.xmlHttpReq.setRequestHeader("Content-length", mess.length);
    self.xmlHttpReq.send(mess);        
}