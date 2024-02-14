<?php


$conn = mysqli_connect("localhost", "root", "", "igra");
function makeTable()
{
    global $conn;
    $sql = "CREATE TABLE IF NOT EXISTS belezkaIgre(
        ID int PRIMARY KEY auto_increment,
        imeIgralca varchar(15),
        caszadnjeIgre timestamp not null DEFAULT current_timestamp(),
        stIgranihIger int not null DEFAULT 1,
        najboljsiRezIgre int,
        casNajboljsiRezIgre timestamp not null DEFAULT current_timestamp()
    );";
    $res = mysqli_query($conn, $sql);
    print_r("<br>" . $res);
}

function izpisiTop10()
{
    global $conn;
    $sql = "SELECT * FROM belezkaIgre
            ORDER BY najboljsiRezIgre DESC;";
    $res = mysqli_query($conn, $sql);
    $data = mysqli_fetch_all($res, MYSQLI_ASSOC);

    if (!isset($data[0]))
        return;
    echo "<table><tr>";
    foreach ($data[0] as $key => $value) {
        echo "<th>$key</th>";
    }
    echo "</tr>";
    foreach ($data as  $b) {
        echo "<tr>";
        foreach ($b as $k => $br) {
            echo "<td>";
            echo $br;
            echo "</td>";
        }
        echo "</tr>";
    }
    echo "</table>";
}

function zapisiRezultatForma()
{
    echo '
    <form method="get">
    <input type="text" name="f" value="zapisiRezultat" hidden>
    <input type="text" name="ime" placeholder="ime">
    <input type="text" name="res" placeholder="rezultat">
    <input type="submit" value="SUBMIT">
    </form>';
}

function zapisiRezultat()
{
    global $conn;
    if (!isset($_GET['ime']) || !isset($_GET['res']) || !is_string($_GET['ime']) || !is_numeric($_GET['res']))
        return;
    $ime = $_GET['ime'];
    $rez = $_GET['res'];
    $sql = "SELECT * FROM belezkaIgre WHERE imeIgralca='$ime'";
    $res = mysqli_query($conn, $sql);
    if ($row = mysqli_fetch_assoc($res)) {
        $sql = "UPDATE belezkaIgre SET caszadnjeIgre=null, stIgranihIger=" . $row['stIgranihIger'] + 1 . ", najboljsiRezIgre=$rez, casNajboljsiRezIgre=null WHERE imeIgralca='$ime'";
        if ($row['najboljsiRezIgre'] > $rez)
            $sql = "UPDATE belezkaIgre SET caszadnjeIgre=null, stIgranihIger=" . $row['stIgranihIger'] + 1 . " WHERE imeIgralca='$ime'";
    } else
        $sql = "INSERT INTO belezkaIgre(imeIgralca,najboljsiRezIgre) VALUES('$ime',$rez)";
    $res = mysqli_query($conn, $sql);
    header('location:?');
}

function zapisi10RandomIger()
{
    for ($i = 0; $i < 10; $i++) {
        global $conn;
        $igralci = ["gasper", "tilen", "lovro", "marko", "jaka", "tea", "brina", "matic", "jan", "eva"];
        $rand = rand(0, 9);
        $ime = $igralci[$rand];
        $rez = rand(1, 10);
        $sql = "SELECT * FROM belezkaIgre WHERE imeIgralca='$ime'";
        $res = mysqli_query($conn, $sql);
        if ($row = mysqli_fetch_assoc($res)) {
            $sql = "UPDATE belezkaIgre SET caszadnjeIgre=null, stIgranihIger=" . $row['stIgranihIger'] + 1 . ", najboljsiRezIgre=$rez, casNajboljsiRezIgre=null WHERE imeIgralca='$ime'";
            if ($row['najboljsiRezIgre'] > $rez)
                $sql = "UPDATE belezkaIgre SET caszadnjeIgre=null, stIgranihIger=" . $row['stIgranihIger'] + 1 . " WHERE imeIgralca='$ime'";
        } else
            $sql = "INSERT INTO belezkaIgre(imeIgralca,najboljsiRezIgre) VALUES('$ime',$rez)";
        $res = mysqli_query($conn, $sql);
    }
    header('location:?');
}


izpisiTop10();
echo "<a href=\"?\">REFRESH</a></br>";
echo "<a href=\"?f=zapisiRezultatForma\">VNOS IGRE</a></br>";
echo "<a href=\"?f=zapisi10RandomIger\">10 RANDOM IGER</a></br>";

if (isset($_GET['f']))
    $_GET['f']();
