<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <?php
    $d = array(
        "1431" => array("ime" => "Rok", "natocenoGorivo" => array(55, 54, 36, 45, 41)),
        "1488" => array("ime" => "Vid", "natocenoGorivo" => array(70, 72)),
        "1492" => array("ime" => "Luka", "natocenoGorivo" => array(38, 42, 46, 37, 40, 40))
    );
    $d["2231"] = array("ime" => "Gasper", "natocenoGorivo" => array(30));
    $d["2231"]["natocenoGorivo"][] = 41;
    izpisiGorivo($d);

    function izpisiGorivo($d)
    {
        foreach ($d as $key => $e) {
            echo "Šifra kupca=$key ";
            echo "Ime=" . $e["ime"] . " ";
            echo "Natočeno gorivo= ";
            foreach ($e["natocenoGorivo"] as $f) {
                echo "$f ";
            }
            echo "<br>";
        }
    }

    ?>
</body>

</html>
