<?php

for($i=1990;$i<2012;$i++){
    $leto = $i;
    $prestopno = false;
    
    if($leto%4==0 && (($leto%100==0 && $leto%400==0) || ($leto%100!=0 && $leto%400!=0)))
        $prestopno = true;
    if($prestopno)
        echo $i . " je prestopno<br>";
    else 
        echo $i . " ni prestopno<br>";
}
?>
