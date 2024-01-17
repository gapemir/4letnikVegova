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
        table,td,th{
            border: 1px solid black;
            border-collapse: collapse;
        }
        td,th{
            text-align: center;
        }
</style>
<?php
echo "<table><tr><td>Leto je prestopno</td><td>Leto ni prestopno</td></tr>";
for($leto = 1990; $leto < 2012; $leto++){
    if($leto%4==0 && (($leto%100==0 && $leto%400==0) || ($leto%100!=0 && $leto%400!=0)))
        echo "<tr><td><red>".$leto."</red></td><td></td></tr>";
    else
        echo "<tr><td></td><td><blue>".$leto."</blue></td></tr>";
}
?>
</body>
</html>
