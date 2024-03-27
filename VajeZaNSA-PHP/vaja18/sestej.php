<?php

if (isset($_GET['podatek1']) && isset($_GET['podatek2']) && isset($_GET['op'])) {
    $mysqli = new mysqli("193.2.190.23", "gasper2112", "testtesttest", "R4_Nemgar30", "3306");
    $stmt = $mysqli->prepare("INSERT INTO operacija(operacija,podatek1,podatek2) VALUES(?,?,?);");

    $stmt->bind_param("sii", $_GET['op'], $_GET['podatek1'], $_GET['podatek2']);
    $stmt->execute();

    if ($_GET['op'] == "sestej")
        $sum = (int)$_GET['podatek1'] + (int)$_GET['podatek2'];
    else
        $sum = (int)$_GET['podatek1'] - (int)$_GET['podatek2'];
}
?>
<form>
    Podatek 1<input type="number" name="podatek1" required></br>
    Podatek 2<input type="number" name="podatek2" required></br>
    <input type="submit" name="op" value="sestej"></br>
    <input type="submit" name="op" value="odstej"></br>
</form>
<?php
if (isset($sum))
    echo $sum;
