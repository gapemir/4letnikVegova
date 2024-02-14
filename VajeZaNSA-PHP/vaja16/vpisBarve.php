<?php

$conn = mysqli_connect("localhost", "root", "", "geometrija");

echo '<form action=""><table>';
echo '<tr><td>ID</td><td><input type="number" name="id" placeholder="celo Število"></td></tr>';
echo '<tr><td>Barva</td><td><input type="text" name="barva" placeholder="vnesi barvo z besedo"></td></tr>';
echo '<tr><td><input type="submit"></td><td><input type="reset"></td></tr></table></form>';

$numbers = array_map(function ($n) {
    return (string)$n;
}, range(0, 9));
$ok = true;
if (isset($_REQUEST['id']) && isset($_REQUEST['barva'])) {
    for ($i = 0; $i <= strlen($_REQUEST['barva']) - 1; $i++) {
        $char = $_REQUEST['barva'][$i];
        $ok = in_array($char, $numbers) ? false : true;
        if (!$ok)
            break;
    }
    if ($ok) {
        try {
            $sql = "INSERT INTO barve VALUES(" . $_REQUEST['id'] . ",'" . $_REQUEST['barva'] . "');";
            $ok = mysqli_query($conn, $sql);
        } catch (\Throwable $th) {
            $ok = false;
        }
    }
    if ($ok === true) echo 'Zapis dodan';
    else echo 'Prišlo je do napake, zapis NI dodan';
}