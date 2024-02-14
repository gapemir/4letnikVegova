<?php

$conn = mysqli_connect("localhost", "root", "", "geometrija");

/*izpis forme*/
$sql = "SELECT * FROM barve";
$res = mysqli_query($conn, $sql);
$barve = mysqli_fetch_all($res, MYSQLI_ASSOC);

echo '<form action=""><table>';
echo '<tr><td>X</td><td><input type="number" name="x" placeholder="x"></td></tr>';
echo '<tr><td>Y</td><td><input type="number" name="y" placeholder="y"></td></tr>';
echo '<tr><td>Barva</td><td><select name="barva">';
foreach ($barve as $barva) {
    echo '<option value="' . $barva['barvaID'] . '">' . $barva['barva'] . '</option>';
}
echo '</select></td></tr>';
echo '<tr><td><input type="submit"></td><td><input type="reset"></td></tr></table></form>';


/*vpis v db*/


if (isset($_REQUEST['x']) && isset($_REQUEST['y']) && isset($_REQUEST['barva'])) {
    $ok = true;
    if ($_REQUEST['x'] < 1 || $_REQUEST['x'] > 200 || $_REQUEST['y'] < 1 || $_REQUEST['y'] > 200)
        $ok = false;
    if ($ok == true)
        try {
            $sql = "INSERT INTO tocke2d VALUES(" . $_REQUEST['x'] . "," . $_REQUEST['y'] . "," . $_REQUEST['barva'] . ")";
            $ok = mysqli_query($conn, $sql);
        } catch (\Throwable $th) {
            $ok = false;
        }
    if ($ok === true) echo 'Zapis dodan';
    else echo 'Prišlo je do napake, zapis NI dodan';
}
