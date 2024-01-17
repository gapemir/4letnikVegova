<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <style> 
        td{
            width:30px;
            height:30px;
        }
        table,tr,td{
            border: 1px solid black;
        }
    </style>
<?php 
    $n = rand(2,8);
    echo("<table><caption>tabela $n x $n </captiono>");
    for($i=0; $i<$n; $i++){
        echo("<tr>");
        for($j=0; $j<$n; $j++){
            echo("<td>");
            if($i==$j)
                echo"*";
            else if($j>$i)
                echo"0";
            else 
                echo"1";
            echo("</td>");
        }
        echo("</tr>");
    }
    echo("</table>");
?>
</body>
</html>
