<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <style>
        red{
            color:red;
        }
        blue{
            color:blue;
        }
</style>
<?php
$leto = rand(1500,2100);
$prestopno = false;

/*if($leto%4==0){
    if($leto%100==0){
        if($leto%400==0)
            $prestopno = true;
        }
    else if($leto%400!=0){
        $prestopno = true;
    }
}*/
if($leto%4==0 && (($leto%100==0 && $leto%400==0) || ($leto%100!=0 && $leto%400!=0)))
    $prestopno = true;

if($prestopno)
    echo "<blue>Leto " . $leto . " <b>je</b> prestopno</blue>";
else 
    echo "<red>Leto " . $leto . " <b>ni</b> prestopno</red>";
?>
</body>
</html>
