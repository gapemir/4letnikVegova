<?php

if (!isset($_GET['table']) || !is_array(json_decode(base64_decode($_GET['table']), 1)) || !isset($_GET['emso']))
    header("location:vaja11.php");
$osebe = json_decode(base64_decode($_GET['table']), 1);
$emso = $_GET['emso'];


unset($osebe[$emso]);

header("location:vaja11.php?table=" . base64_encode(json_encode($osebe)));
