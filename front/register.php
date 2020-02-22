<?php
class register {
protected $data = array();
function __construct() {
}

function _read() {
        $this->data['login'] = $_POST['login'] ;
        $this->data['pass'] = $_POST['pass'] ;
}

}
?>
