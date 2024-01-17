<!DOCTYPE html>
<html>

<head>
</head>
<style>
    td {
        text-align: end;
        border-top: 0;
        border-right: 0;
        border-left: 0;
        border-bottom: 1px solid black;
    }
</style>

<body>
    <?php
    echo "<table>";
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
