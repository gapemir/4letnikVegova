<?php

if (!isset($_GET['table']) || !isset($_GET['emso']))
    header("location:_index.php");

echo "<form action=\"_index.php\">";
echo "emšo:<input name=\"emso\">";
echo "ime:<input name=\"ime\">";
echo "priimek:<input name=\"priimek\">";
echo "starost:<input name=\"starost\">";
echo "<input type=\"hidden\" name=\"table\" value=" . $_GET['table'] . " \">";
echo "<input type=\"submit\" value=\"uveljavi\" />";
echo "</form>";

echo "<style>input{display:block;}.red{color:red;}</style>";
