<?php

$conn = mysqli_connect("localhost", "root", "", "geometrija");

/*izpis forme*/
$sql = "SELECT * FROM barve";
$res = mysqli_query($conn, $sql);
$barve = mysqli_fetch_all($res, MYSQLI_ASSOC);

echo '<form action=""><table>';
echo '<tr><td>Izberi barvo:</td><td><select name="barva">';
foreach ($barve as $barva) {
    echo '<option value="' . $barva['barvaID'] . '">' . $barva['barva'] . '</option>';
}
echo '</select></td></tr>';
echo '<tr><td><input type="submit"></td></tr></table></form>';


/*proc $_GET*/
if (isset($_REQUEST['barva'])) {
    $ok = true;
    $sql = "SELECT x,y FROM tocke2d WHERE BarvaID = " . $_REQUEST['barva'];
    $res = mysqli_query($conn, $sql);
    $tocke = mysqli_fetch_all($res, MYSQLI_ASSOC);

    $st = true;
    echo '<table id="tabelaRes">';
    foreach ($tocke as $tocka) {
        if ($st === true) {
            echo '<tr><th>X</th><th>Y</th></tr>';
            $st = false;
        }
        echo '<tr><td>' . $tocka['x'] . '</td><td>' . $tocka['y'] . '</td></tr>';
    }
    echo '</table><style>#tabelaRes,#tabelaRes tr,#tabelaRes td,#tabelaRes th{border:1px solid black;}#tabelaRes{border-collapse:collapse}</style>';
}
