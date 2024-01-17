<?php

if (!isset($_GET['table']) || !isset($_GET['emso']))
    header("location:_index.php");
$emso = json_decode(base64_decode($_GET['emso']), 1);
$oseba = json_decode(base64_decode($_GET['table']), 1)[$emso];


echo "<form action=\"_index.php\">";
echo "emšo:<input name=\"emso\" value=\"$emso\" readonly>";
echo "ime:<input name=\"ime\" value=" . $oseba["ime"] . " \" >";
echo "priimek:<input name=\"priimek\" value=" . $oseba["priimek"] . " \" >";
echo "starost:<input name=\"starost\" value=" . $oseba["starost"] . " \" >";
echo "<input type=\"hidden\" name=\"table\" value=" . $_GET['table'] . " \">";
echo "<input type=\"submit\" value=\"uveljavi\" />";
echo "</form>";

echo "<style>input{display:block;}</style>";
