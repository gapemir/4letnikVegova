<?php

try {
    $conn = mysqli_connect('localhost', 'root', '', 'merilniktemp');
} catch (\Throwable $th) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
    $conn = mysqli_connect("localhost", "root", "");
    $sql = "CREATE DATABASE MerilnikTemp;
        USE MerilnikTemp;
        CREATE TABLE MerilnikTemp(
            ID int not null auto_increment PRIMARY KEY,
            zeljena float not null,
            realna float not null,
            cas timestamp
        );";
    mysqli_multi_query($conn, $sql);
    mysqli_close($conn);
    require_once("start.php");
}

$data = json_decode(file_get_contents("php://input"), 1);

$id = $data['id'];
$zel = $data['zel'];
$real = $data['real'];


$sql = "UPDATE merilniktemp
SET zeljena=$zel,
 realna=$real,
 cas=CURRENT_TIMESTAMP()
WHERE ID=$id";

$res = mysqli_query($conn, $sql);
//$res1 = mysqli_query($conn,$sql1);

//var_dump($res);
//var_dump($res1);
echo $id;
