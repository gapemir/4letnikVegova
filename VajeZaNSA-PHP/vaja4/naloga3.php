<?php

$x = rand(1000, 9999);
$M = max([$x % 10, ((int)($x / 10)) % 10, ((int)($x / 100)) % 10, ((int)($x / 1000))]);
$m = min([$x % 10, ((int)($x / 10)) % 10, ((int)($x / 100)) % 10, ((int)($x / 1000))]);
echo $x . "<br>";
echo $M . " ponvi se " . findAcc($x,$M) . "<br>";
echo $m . " ponvi se " . findAcc($x,$m) . "<br>";

function findAcc($x, $f){
    $count = 0;
    while ($x > 0) {
        if ($x % 10 == $f)
            $count++;
        $x = (int)($x / 10);
    }
    return $count;
}

