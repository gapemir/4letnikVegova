<?php
$ime = "Ime";
$priimek = "Priimek";
echo isset($ime) . "<br/ >";
unset($ime);
echo isset($ime) . "<br/ >";
echo "<span style=\"color:red;font-size:20px;\">Moje ime = " . $ime . "</span><br>";
echo "<span style=\"color:blue;font-size:30px;\">Moj priimek = " . $priimek . "</span><br>";
echo is_bool($ime) . "<br/ >";
echo is_double($ime) . "<br/ >";
echo is_float($ime) . "<br/ >";
echo is_int($ime) . "<br/ >";
echo is_long($ime) . "<br/ >";
echo is_null($ime) . "<br/ >";
echo is_numeric($ime) . "<br/ >";
echo is_string($ime) . "<br/ >";
