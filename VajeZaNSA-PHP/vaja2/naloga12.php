<html>
<head>
<title>
  Nekaj popravi, nekaj dopiši
</title>
</head>
<body>
<?php
    function sgn($x){
        if($x<0) return -1;
        if($x>0) return 1;
        return 0;
    }

echo "<table><tr><th>x</th><th>sgn(x)</th></tr>";
for($i=-10;$i<=10;$i++){
    echo "<tr><td>" . $i . "</td><td>" . sgn($i) . "</td><tr>";
}

echo "</table>";
?>  
</body>
</html>

