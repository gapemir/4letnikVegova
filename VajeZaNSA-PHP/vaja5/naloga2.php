<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <style> 
        table,tr,td{border:1px solid black;}
        .italic{font-style: italic; background-color:lime;}
        .bold{font-weight: bald; background-color:red;}
    </style>
<?php 
$t=[];
for($i=0;$i<10;$i++){
    $t[]=(rand(100,399));
    if($t[$i]%2==0)
        $t[$i]+=1;
}
echo "<table class=\"italic\"><caption>Originalni podatki</caption><tr>";
for($i=0;$i<10;$i++){
    echo "<td>".$t[$i]."</td>";
}
echo "</tr></table>";

$t = mySort($t);

for($i=0;$i<10;$i++){
    $t[]=(rand(100,399));
    if($t[$i]%2==0)
        $t[$i]+=1;
}
echo "<table class=\"bold\"><caption>Originalni podatki</caption><tr>";
for($i=0;$i<10;$i++){
    echo "<td>".$t[$i]."</td>";
}
echo "</tr></table>";

function mySort($t){
    foreach($t as $k1 => $v1){
        foreach($t as $k2 =>$v2){
            if($v1>$v2){
                $x = $t[$k2];
                $t[$k2] = $t[$k1] ;
                $t[$k1] = $x;
            }
        }
    }
    return $t;
}

?>
    
</body>
</html>
