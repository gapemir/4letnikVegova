<!DOCTYPE html>
<html>

<head>
</head>

<body>
    <?php
    echo "<table border=\"1\">";
    $a = 0;
    for ($x = 1; $x <= 10; $x++) {
        echo "<tr>";
        for ($y = 1; $y <= 10; $y++, $a++)
            echo "<td>$a</td>";
        echo "</tr>";
    }
    echo "</table>";

    ?>
</body>

</html>
