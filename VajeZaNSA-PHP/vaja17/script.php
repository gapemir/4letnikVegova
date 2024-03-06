<?php
$FILE_NAME = "si";


$conn = mysqli_connect("localhost", "root", "", "local");

$sql = "SELECT * FROM $FILE_NAME";
$res = mysqli_query($conn, $sql);
$res = mysqli_fetch_assoc($res);
var_dump($res);
