<?php
session_start();
if (!isset($_SESSION["prijavaServiserja"]) || $_SESSION["prijavaServiserja"] == false)
    header("location:registracija.php");
?>
<!DOCTYPE html>

<head>
    <title>VNOS SERVISA</title>
</head>

<body>

    <form method="post">
        registerska oznaka:<select name="regOznaka">
            <option value="0">IZBERI REGISTERSKO</option>
            <?php
            $conn = new mysqli("localhost", "root", "", "servisi");
            $res = $conn->execute_query("SELECT regOznaka FROM vozilo");
            while ($row = $res->fetch_assoc()) {
                echo '<option value="' . $row['regOznaka'] . '">' . $row['regOznaka'] . '</option>';
            }
            ?>
        </select><br />
        datum:<input type="date" name="datum" required="true"><br>
        cena:<input type="number" name="cena" required="true"><br>
        opombe:<input type="text" name="opombe" pattern="[a-zA-Z\s]+"><br>
        <input type="submit" name="submit" value="vnesi">
    </form>

    <?php
    if ($_SERVER['REQUEST_METHOD'] == 'POST')
        if (isset($_POST["regOznaka"]) && isset($_POST["datum"]) && isset($_POST["cena"])) {
            $prep = $conn->prepare("insert into servis values(?, ?, ?, ?)");
            $regOznaka = $_POST["regOznaka"];
            $datum = $_POST["datum"];
            $cena = $_POST["cena"];
            $opombe = $_POST["opombe"];
            if ($regOznaka == 0) {
                echo "Napaka pri dodajanju-izberi registersko";
                return;
            }
            if ($cena < 0) {
                echo "Napaka pri dodajanju-cena mora biti >= 0";
                return;
            }
            try {
                $prep->bind_param("ssis", $regOznaka, $datum, $cena, $opombe);
                $prep->execute();
                echo "Vozilo je dodano";
                $conn->close();
            } catch (Exception $e) {
                echo "nekaj je slo hudo narobe<br/>";
                print_r($e);//samo za development potrebe
            }
        }
    ?>

</body>

</html>