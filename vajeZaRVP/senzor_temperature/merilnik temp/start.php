<?php

$conn = mysqli_connect('localhost', 'root', '', 'merilniktemp');

$data = json_decode(file_get_contents("php://input"), 1);
$st = 50;
if (isset($data['st']))
    $st = $data['st'];

$sql = "DELETE FROM merilniktemp";
$res = mysqli_query($conn, $sql);


for ($i = 1; $i <= $st; $i++) {
    $sql = "INSERT INTO merilniktemp VALUES($i,0,0,'DATEADD(year,-1,CURRENT_TIMESTAMP()')";
    $res = mysqli_query($conn, $sql);
}

if ($res == true)
    echo "succesfull";
else
    print_r($res);
//var_dump($res1);
