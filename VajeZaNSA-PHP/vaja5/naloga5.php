<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <style>
        td {
            width: 30px;
            height: 30px;
        }

        table,
        tr,
        td {
            border: 1px solid black;
        }
    </style>

    <?php
    $data = array(
        array('Janez', 'Mitja', 'Darko', 'Luka', 'Andrej'),
        array(4, 3, 3, 4, 6),
        array(5, 5, 3, 6, 4)
    );
    echo '<table cellspacing="0" border="1">';
    for ($i = 0; $i < count($data[0]); $i++) {
        echo "<tr><td>" . $data[0][$i] . "</td><td>" . $data[1][$i] . "</td><td>" . $data[2][$i] . "</td></tr>";
    }
    echo "<tr><td>Skupaj:</td><td>" . array_sum($data[1]) . "</td><td>" . array_sum($data[2]) . "</td></tr>";
    echo '</table>';

    ?>
</body>

</html>
