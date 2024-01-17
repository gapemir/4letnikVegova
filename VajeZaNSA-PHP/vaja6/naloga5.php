<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        table,
        td {
            border: 1px solid black;
        }

        tr:nth-child(even) {
            background-color: blue;
        }

        tr:nth-child(odd) {
            background-color: lightblue;
        }

        table {
            border-collapse: collapse;
        }
    </style>
</head>

<body>
    <?php
    $tab = [
        "Januar"    => [],
        "Februar" => [],
        "Marec" => [],
        "April" => [],
        "Maj" => [],
        "Junij" => []
    ];
    $tab = napolni($tab);
    izpisiTab($tab);
    $tab = izbrisiNajmanjso($tab);
    izpisiTab($tab);
    $tab2 = eee($tab);
    izpisiTab($tab2);
    $tab1 = fff($tab, $tab2);
    izpisiTab($tab);
    izpisiTab($tab1);
    izpisiTab($tab2);

    function napolni($tab)
    {
        foreach ($tab as $key => $e) {
            for ($i = 0; $i < 6; $i++)
                $tab[$key][] = rand(10, 20);
        }
        return $tab;
    }
    function izpisiTab($tab)
    {
        echo "<table>";
        foreach ($tab as $key => $e) {
            echo "<tr><td>$key</td>";
            foreach ($e as $f)
                echo "<td>$f</td>";
            echo "</tr>";
        }
        echo "</table><br>";
    }
    function izbrisiNajmanjso($tab)
    {
        foreach ($tab as $key => $e) {
            $min = array_values($tab)[0];
            foreach ($e as $f)
                if ($min > $f)
                    $min = $f;
            foreach ($e as $key1 => $f)
                if ($f == $min)
                    unset($tab[$key][$key1]);
        }
        return $tab;
    }
    function povp($tab)
    {
        $vs = 0;
        foreach ($tab as $e) {
            foreach ($e as $f)
                $vs += $f;
        }
        return (int)$vs / count($tab);
    }
    function vsota($tab)
    {
        $vs = 0;
        foreach ($tab as $e) {
            $vs += $e;
        }
        return $vs;
    }
    function eee($tab)
    {
        $tab2 = [];
        $povp = povp($tab);
        foreach ($tab as $key => $e) {
            if (vsota($e) < $povp)
                $tab2[$key] = $e;
        }
        return $tab2;
    }
    function fff($tab, $tab2)
    {
        $tab1 = $tab;
        foreach ($tab1 as $key => $e) {
            foreach ($tab2 as $key2 => $e2)
                if ($e == $e2)
                    unset($tab1[$key]);
        }
        return $tab1;
    }
    ?>
</body>

</html>
