<?php

$conn = mysqli_connect('localhost', 'root', '', 'merilniktemp');

$data = json_decode(file_get_contents("php://input"),1);
$from = $data["from"];
$to = $data["to"];

$sql = "SELECT * FROM merilniktemp WHERE cas BETWEEN '$from' AND '$to'";

$res = mysqli_query($conn, $sql);
echo json_encode(mysqli_fetch_all($res, MYSQLI_ASSOC));
