<?php

$pathToMySQL = "C:/xampp/mysql/bin/"

$conn = mysqli_connect("localhost", "root", "");

$sql = "CREATE DATABASE geometrija;";
$res = mysqli_query($conn, $sql);
mysqli_close($conn);

$archive = __DIR__ . "\arhiv.sql";
//$res = mysqli_query($conn, $sql);

$result = exec($pathToMySQL . 'mysql.exe --password="" --user=root geometrija < '.$archive, $output);

if (empty($output)) {
    var_dump($result);
    var_dump($output);
} else {
    var_dump($result);
    var_dump($output);
}
