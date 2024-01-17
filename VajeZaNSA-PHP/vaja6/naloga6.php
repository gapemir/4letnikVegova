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

        table {
            border-collapse: collapse;
        }
    </style>
</head>

<body>
    <?php
    $tab = array("bela", "modra", "bela", "rdeča", "zelena", "bela", "rdeča", "zelena", "bela");
    $tab2 = [];
    foreach ($tab as $e) {
        if (!isset($tab2[$e]))
            $tab2[$e] = array(1);
        else {
            $tab2[$e][] = 1;
        }
    }
    $tab3 = [];
    foreach ($tab as $e) {
        if (!isset($tab3[$e]))
            $tab3[$e] = 1;
        else {
            $tab3[$e]++;
        }
    }

    izpisLezeca2($tab2);
    izpisLezeca1($tab3);
    izpisPokoncna2($tab2);
    izpisPokoncna1($tab3);

    function izpisLezeca2($tab)
    {
        echo "<table>";
        foreach ($tab as $key => $e) {
            echo "<tr><td>$key</td>";
            foreach ($e as $f) {
                echo "<td>$f</td>";
            }
            echo "</tr>";
        }
        echo "</table><br>";
    }
    function izpisLezeca1($tab)
    {
        echo "<table>";
        foreach ($tab as $key => $e) {
            echo "<tr><td>$key</td>";
            echo "<td>$e</td></tr>";
        }
        echo "</table><br>";
    }
    function izpisPokoncna2($tab)
    {
        echo "<table><tr>";
        $keys = array_keys($tab);
        for ($i = 0; $i < count($tab); $i++)
            echo "<td>" . $keys[$i] . "</td>";
        for ($i = 0; $i < count($tab); $i++) {
            echo "<tr>";
            for ($j = 0; $j < count($tab); $j++)
                if (isset($tab[$keys[$j]][$i]))
                    echo "<td>" . $tab[$keys[$j]][$i] . "</td>";
                else echo "<td>" . "</td>";
            echo "<tr>";
        }
        echo "</table><br>";
    }
    function izpisPokoncna1($tab)
    {
        echo "<table><tr>";
        $keys = array_keys($tab);
        for ($i = 0; $i < count($tab); $i++)
            echo "<td>" . $keys[$i] . "</td>";
        echo "<tr>";
        for ($i = 0; $i < count($tab); $i++) {
            echo "<td>" . $tab[$keys[$i]] . "</td>";
        }
        echo "</tr>";
        echo "</table><br>";
    }

    ?>
</body>

</html>
