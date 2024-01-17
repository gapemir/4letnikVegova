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
            text-align: center;
        }

        table,
        tr,
        td {
            border: 1px solid black;
        }
    </style>
    <?php
    require_once "funkcije.php";
    $tab = napolni(6);
    izpisi1($tab);
    echo izpisi2($tab);
    ?>
</body>

</html>