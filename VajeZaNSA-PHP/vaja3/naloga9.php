<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
<?php
    $s = "ABCDEFGH";
    echo "<table>";
    for($i=0;$i<8;$i++){
        echo "<tr>";
        for($j=0;$j<8;$j++){
            echo "<td>".$s[$i].$j."</td>";
        }
        echo "</tr>";
    }
?>
</body>
</html>
