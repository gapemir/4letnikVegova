<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <style>
        td,
        td,
        th {
            border: black 1px solid;
        }

        table {
            border-collapse: collapse;
        }
    </style>
    <?php
    require_once "podatki.php";

    $vrtec[13] = array("ime" => "Gašper", "igraca" => array("avti", "kladivo", "spiderman", "kroglice"));
    echo izpis3_2($vrtec);

    function izpis3_2($vrtec)
    {
        $t = "<table>";
        $t .= "<tr><th>id</th><th>ime</th><th>igraca</th></tr>";
        foreach ($vrtec as $key => $otrok) {
            $x = false;
            foreach ($otrok["igraca"] as $igraca) {
                $t .= "<tr>";
                if (!$x)
                    $t .= "<td rowspan=\"" . count($otrok["igraca"]) . "\">$key</td><td rowspan=\"" . count($otrok["igraca"]) . "\">" . $otrok["ime"] . "</td>";
                $t .= "<td>$igraca</td>";
                $x = true;
                $t .= "</tr>";
            }
            $x = false;
        }
        $t .= "<table>";
        return $t;
    }

    function izpis3_1($vrtec)
    {
        $t = "<table>";
        $t .= "<th>id</th><th>ime</th><th>igraca</th>";
        foreach ($vrtec as $key => $otrok) {
            foreach ($otrok["igraca"] as $igraca) {
                $t .= "<tr><td>$key</td><td>" . $otrok["ime"] . "</td>";
                $t .= "<td>$igraca</td>";
            }
            $t .= "</tr>";
        }
        $t .= "<table>";
        return $t;
    }
    ?>
</body>

</html>
