<?php

$mysqli = new mysqli("193.2.190.23", "gasper2112", "testtesttest", "R4_Nemgar30", "3306");

$stmt = $mysqli->prepare("INSERT INTO obisk(opomba) VALUES(?);");

for ($i = 0; $i < 20; $i++) {
    $stmt->bind_param("s", createText());
    $stmt->execute();
    usleep(20000);
}

function createText()
{
    $t = "";
    $abc = "abcdefghijklmnoqprstuvwxyz";
    $lim = rand(5, 10);
    for ($i = 0; $i < $lim; $i++) {
        $t .= $abc[rand(0, 26)];
    }
    return $t;
}
