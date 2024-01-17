<?php
require_once("funkcije.php");

$tabela = [];
if (isset($_GET['table']))
    $tabela = json_decode(base64_decode($_GET['table']), 1);
else {
    for ($i = 0; $i < 10; $i++)
        $tabela[] = genOseba();
    $tabela = reorganizirajOseba($tabela);
}
if (isset($_GET["emso"]) && isset($_GET["ime"]) && isset($_GET["priimek"]) && isset($_GET["starost"]))
    $tabela[$_GET["emso"]] = ["ime" => $_GET["ime"], "priimek" => $_GET["priimek"], "starost" => $_GET["starost"]];

echo vrniHTMLTabelo($tabela, "ogled");
