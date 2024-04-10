<?php
$NAME_OF_DATABASE = "R4_Nemgar30";


//header('Content-type: text/plain; charset=utf-8');
$mysqli = new mysqli("193.2.190.5", "team_16", "m1Dba716", "podatki", "3306");
$mysqli->set_charset('utf8');
$mysqli_moj = new mysqli("193.2.190.23", "gasper2112", "nemga12516", "R4_Nemgar30", "3306");
//$mysqli_moj = new mysqli("localhost", "root", "");

$sql = "SHOW TABLES";
$res = $mysqli->execute_query($sql);
$tables = $res->fetch_all();

$sql = "DROP DATABASE IF EXISTS $NAME_OF_DATABASE; CREATE DATABASE $NAME_OF_DATABASE; USE $NAME_OF_DATABASE;";
$res = $mysqli_moj->multi_query($sql);
while ($mysqli_moj->next_result());


foreach ($tables as $table) {
    echo "-------------------------------------------------------<br>";
    $sql = "SHOW CREATE TABLE " . $table[0];
    $res = $mysqli->execute_query($sql);
    $create = $res->fetch_all(MYSQLI_ASSOC);
    $createTable = $create[0]['Create Table'];
    print_r($createTable);
    echo "<br><br>";
    $res = $mysqli_moj->execute_query($createTable);


    $sql = "SELECT * FROM " . $table[0];
    $res = $mysqli->execute_query($sql);
    $data = $res->fetch_all(MYSQLI_ASSOC);
    print_r($data);
    foreach ($data as $dat) {
        $ins = "INSERT IGNORE INTO " . $table[0] . " VALUES (";
        foreach ($dat as $key => $value) {
            $ins .= "'" . $value . "', ";
        }
        $ins = rtrim($ins, ", ");
        $ins .= ")";
        echo $ins;
        $res = $mysqli_moj->execute_query($ins);
    }
}


/*
drop database podatki;
CREATE database podatki;
*/