<?php

if (!isset($_GET['table']) || !is_array(json_decode(base64_decode($_GET['table']), 1)) || !isset($_GET['emso']))
    header("location:vaja11.php");
$osebe = json_decode(base64_decode($_GET['table']), 1);
$emso = $_GET['emso'];

$osebe[$emso]['ime'] = $_GET['ime'];
$osebe[$emso]['priimek'] = $_GET['priimek'];
$osebe[$emso]['starost'] = $_GET['starost'];

header("location:vaja11.php?table=" . base64_encode(json_encode($osebe)));
