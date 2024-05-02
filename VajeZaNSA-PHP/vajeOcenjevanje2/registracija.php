<html>

<head>
    <title>REGISTRACIJA SERVISERJA</title>
</head>

<body>
    <form method="POST">
        <h3>REGISTRACIJA SERVISERJA</h3> <br>
        id:<input type="number" name="id" required><br>
        ime:<input type="text" name="ime" required><br>
        priimek:<input type="text" name="priimek" required><br>
        geslo:<input type="text" name="geslo" required><br>
        <input type="submit" value="Registriraj">
    </form>
    <?php
    $conn = new mysqli("localhost", "root", "", "servisi");

    if (isset($_POST["ime"]) && isset($_POST["ime"]) && isset($_POST["priimek"]) && isset($_POST["geslo"])) {
        $prep = $conn->prepare("INSERT INTO Serviser VALUES(?, ?, ?, ?)");
        $geslo = hash("sha1", $_POST["geslo"]);
        $id = $_POST['id'];
        $ime = $_POST['ime'];
        $priimek = $_POST['priimek'];
        $prep->bind_param("isss", $id, $ime, $priimek, $geslo);
        try {
            $prep->execute();
            $conn->close();
            session_start();
            $_SESSION['prijavaServiserja'] = true;
            header('location:vnos.php');
        } catch (Exception $e) {
            echo "nekaj je slo hudo narobe<br/>";
            print_r($e); //samo za development potrebe
        }
    }
    ?>


</body>

</html>