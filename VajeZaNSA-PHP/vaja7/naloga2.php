<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>

    <?php
    require_once "podatki.php";
    require_once "funkcije2.php";

    $vrtec[13] = array("ime" => "Gašper", "igraca" => array("avti", "kladivo", "spiderman", "kroglice"));
    izpisiOtroka($vrtec[14]);
    izpisiOtrokaCeImaIgraco($vrtec, "medvedek");
    echo "<br>";
    izpisiOtrokaCeNimaIgrace($vrtec, "medvedek");
    echo "<br>";
    echo "<br>";
    echo "<br>";
    $vrtec1 = preoblikujTabelo($vrtec);
    izpisiOtrokaCeImaIgraco2($vrtec1, "medvedek", $vrtec);
    

    ?>
</body>

</html>
