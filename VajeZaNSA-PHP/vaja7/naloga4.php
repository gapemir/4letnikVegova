<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href=https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src=https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>

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
    echo izpis4_a($vrtec);
    echo "<br>";
    echo izpis4_b($vrtec);

    function izpis4_a($vrtec)
    {
        $t = "<table class=\"table table-striped table-hover\">";
        $t .= "<thead class=\"thead-dark\"><th>id</th><th>ime</th><th>igraca</th></thead>";
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
    function izpis4_b($vrtec)
    {
        $t = "<table class=\"table table-striped table-hover\">";
        $t .= "<thead class=\"thead-dark\"><th>id</th><th>ime</th><th>igraca</th></thead>";
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
    ?>
</body>

</html>
