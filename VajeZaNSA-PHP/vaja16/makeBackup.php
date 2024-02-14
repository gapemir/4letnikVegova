<?php

$pathToMySQL = "C:/xampp/mysql/bin/"

$result = exec($pathToMySQL.'mysqldump geometrija --password="" --user=root > arhiv.sql', $output);
$conn = mysqli_connect("localhost", "root", "");
$sql = "DROP DATABASE geometrija;";
$res = mysqli_query($conn, $sql);

if (empty($output)) {
    var_dump($result);
    var_dump($output);
} else {
    var_dump($result);
    var_dump($output);
}
