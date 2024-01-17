<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        table,
        tr,
        td {
            border: 1px solid black;
        }

        table {
            border-collapse: collapse;
        }
    </style>
    </style>
</head>

<body>
    <?php
    $tab = ustvari(100);
    izpisi($tab);

    function izpisi($arr)
    {
        echo "<table>";
        $col = ["#FF0000", "#00FF00", "#0000FF", "#00FFFF"];
        $row = 0;
        foreach ($arr as $e) {
            if ($row % 5 == 0)
                echo "<tr>";
            echo '<td bgcolor="' . $col[rand(0, 3)] . '">' . $e . '</td>';
            if ($row % 5 == 4)
                echo "</tr>";
            $row++;
        }
        echo "</table>";
    }

    function ustvari($n)
    {
        $tab = [];
        for ($i = 0; $i < $n; $i++) {
            $tab[] = makeWord();
        }
        return $tab;
    }
    function makeWord()
    {
        $a = "AEIOU";
        $b = "BCDFGHJKLMNPQRSTVWXYZ";
        $len = rand(5, 12);
        $word = "";
        for ($i = 0; $i < $len; $i++) {
            if ($i % 2 == 0)
                $word .= $b[rand(0, 20)];
            else
                $word .= $a[rand(0, 4)];
        }
        return $word;
    }

    ?>
</body>

</html>
