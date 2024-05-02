<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IZPIS PO STANJU</title>
</head>

<body>

    <?php
    $conn = new mysqli("localhost", "root", "", "servisi");

    $query = "SELECT DISTINCT stanjeVozila FROM vozilo";
    $result = $conn->query($query);


    ?>
    <form method="post">
        stanje vozila:
        <?php
        while ($row = $result->fetch_assoc()) {
            echo '<input type="radio" id="' . $row['stanjeVozila'] . '" name="stanje" value="' . $row['stanjeVozila'] . '">';
            echo '<label for="' . $row['stanjeVozila'] . '">' . $row['stanjeVozila'] . '</label>';
        }
        ?>
        <input type="submit" name="submit" value="izpisi">
    </form>

    <?php
    if (isset($_POST["stanje"])) {
        $stanje = $_POST["stanje"];

        $query = "SELECT ime, priimek FROM Oseba JOIN Vozilo ON Oseba.davSt=Vozilo.lastnik WHERE stanjeVozila='$stanje'";
        $result = $conn->query($query);
        if ($result->num_rows > 0) {
            echo "<h3>Rezultati iskanja za <i>$stanje</i>:</h3>";
            echo "<table border='1'>
        <tr>
        <th>Ime</th>
        <th>Priimek</th>
        </tr>";
            while ($row = $result->fetch_assoc()) {
                echo "<tr>";
                echo "<td>" . $row['ime'] . "</td>";
                echo "<td>" . $row['priimek'] . "</td>";
                echo "</tr>";
            }
            echo "</table>";
        } else {
            echo "Ni rezultatov.";
        }
    } else {
        echo "Izberi željeno stanje";
    }
    $conn->close();
    ?>

</body>

</html>