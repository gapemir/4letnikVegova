<?php

if (is_numeric($_GET['ime']) || is_numeric($_GET['priimek']))
    header("location:_index.php");


$ime = $_GET['ime'];
$priimek = $_GET['priimek'];
$program = $_GET['program'];

$zbirka = [];
if (isset($_GET['zbirka']) && is_array(json_decode(base64_decode($_GET['zbirka']), 1)))
    $zbirka = json_decode(base64_decode($_GET['zbirka']), 1);

$zbirka[$program][] = [$ime, $priimek];
print_r($zbirka);


if (starts_with_upper($ime) && starts_with_upper($priimek)) {
    echo "<spam style=\"font-style: italic;\">Ime in Priimek: </spam><spam>" . $ime . " " . $priimek . "</spam>";
    echo "<br>";
    echo "<spam style=\"font-style: italic;\">Program: </spam><spam>" . $program . "</spam>";
} else {
    echo "<spam style=\"font-style: italic;\">Ime: </spam><spam>" . $ime . " (</spam><spam style=\"color:red;\">" . ucfirst($ime) . "</spam>)";
    echo "<br>";
    echo "<spam style=\"font-style: italic;\">Priimek: </spam><spam>" . $priimek . " (</spam><spam style=\"color:red;\">" . ucfirst($priimek) . "</spam>)";
    echo "<br>";
    echo "<spam style=\"font-style: italic;\">Program: </spam><spam>" . $program . "</spam>";
}

echo "<br><a href=\"_index.php?zbirka=" . base64_encode(json_encode($zbirka)) . "\">BACK</a>";
echo "<br><a href=\"Naloga2.php?zbirka=" . base64_encode(json_encode($zbirka)) . "\">VIZUALIZIRAJ</a>";


function starts_with_upper($str)
{
    $chr = mb_substr($str, 0, 1, "UTF-8");
    return mb_strtolower($chr, "UTF-8") != $chr;
}
