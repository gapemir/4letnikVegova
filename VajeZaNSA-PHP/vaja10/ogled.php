<?php

if (!isset($_GET['table']) || !isset($_GET['emso']))
    header("location:_index.php");
$table = json_decode(base64_decode($_GET['table']), 1);
$emso = json_decode(base64_decode($_GET['emso']), 1);

echo "<form action=\"_index.php\">";
echo "emšo:<input type=\"text\" value=\"$emso\" readonly>";
echo "ime:<input type=\"text\" value=" . $table[$emso]["ime"] . " \" readonly>";
echo "priimek:<input type=\"text\" value=" . $table[$emso]["priimek"] . " \" readonly>";
if (chkLeta($table[$emso]["starost"], $emso))
    echo "starost:<input type=\"text\" value=" . $table[$emso]["starost"] . " \" readonly>";
else
    echo "starost:<input type=\"text\" style=\"color:red;\" value=" . $table[$emso]["starost"] . " \" readonly>";
echo "<input type=\"hidden\" name=\"table\" value=" . $_GET['table'] . " \">";
echo "<input type=\"submit\" value=\"zapri\" />";
echo "</form>";

echo "<style>input{display:block;}.red{color:red;}</style>";



function chkLeta($starost, $emso)
{
    $d = (int)substr($emso, 0, 2);
    $m = (int)substr($emso, 2, 2);
    $l = substr($emso, 4, 3);
    if (substr($l, 0, 1) == "0")
        $l = (int)$l + 2000;
    else
        $l = (int)$l + 1000;
    $curyear = date("Y");
    $curmonth = date("m");
    $curday = date("d");
    if ($curmonth < $m) {
        if ($l + $starost == $curyear - 1)
            return 1;
    } else if ($curmonth == $m && $curday < $d) {
        if ($l + $starost == $curyear - 1)
            return 1;
    } else if ($l + $starost == $curyear)
        return 1;
    return 0;
}
