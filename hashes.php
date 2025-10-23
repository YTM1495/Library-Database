<?php
$passwords = ['libpass1','libpass2','libpass3','libpass4','libpass5','libpass6','libpass7','libpass8','libpass9','libpass10','libpass11','libpass12','libpass13','libpass14','libpass15'];

foreach($passwords as $p){
    echo $p . " => " . password_hash($p, PASSWORD_DEFAULT) . "<br>";
}
?>
