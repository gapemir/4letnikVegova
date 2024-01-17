<?php
$x = 19;

echo "V Ljubljani je " . $x . "°C";
echo "<br>";
echo "V Ljubljani je " . number_format($x + 273.15,2,",") . "K";
echo "<br>";
echo "V Ljubljani je " . number_format(($x * 9/5)+32,1,",") . "F";

?>
