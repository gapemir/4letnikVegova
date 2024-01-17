<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        table,
        th,
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
    $tab = array(13, 22, 40, 55, 2, 19, 18, 29, 35, 44);

    unset($tab[rand(0, 9)]);
    unset($tab[rand(0, 9)]);
    $tab["prvi"] = 1;
    $tab["drugi"] = 2;

    /*echo "<table><tr>";
    foreach ($tab as $key => $e) {
        echo "<td>$e</td>";
    }
    echo "</tr></table>";*/
    izpArr($tab);
    izracunajVsoto($tab);
    
    function izpArr($arr)
    {
        echo "<table>";
        foreach ($arr as $key => $e) {
            echo "<tr><th>$key</th><td>$e</td></tr>";
        }
        echo "</table>";
    }
    function izracunajVsoto($arr)
    {
        $vs = 0;
        foreach ($arr as $e) {
            $vs += $e;
        }
        echo "vsota je $vs.";
    }
    ?>
</body>

</html>
