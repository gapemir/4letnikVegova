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
            text-align: center;
        }

        table {
            border-collapse: collapse;
        }
    </style>
</head>

<body>
    <?php
    $data = array("ime" => "Luka", "vzdevek" => "Lukec", "starost" => 16, "spol" => "M");
    $data['datumPrijave'] = date("d.m.Y");

    izpArr($data);
    $int = 0;
    $str = 0;
    foreach ($data as $e) {
        if (is_int($e))
            $int++;
        else if (is_string($e))
            $str++;
    }
    echo "$str elementov je tipa string, $int elementov je tipa integer.";

    function izpArr($arr)
    {
        echo "<table><tr>";
        foreach ($arr as $key => $e) {
            echo "<th>$key</th>";
        }
        echo "</tr><tr>";
        foreach ($arr as $key => $e) {
            echo "<td>$e</td>";
        }
        echo "</tr></table>";
    }

    ?>
</body>

</html>
