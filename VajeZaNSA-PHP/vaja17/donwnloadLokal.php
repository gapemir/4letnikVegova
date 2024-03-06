<?php
$FILE_NAMES = ["si", "hu", "it"];

$conn = mysqli_connect("localhost", "root", "", "lokal");

if (!is_dir("./lokal"))
    mkdir("./lokal");

foreach ($FILE_NAMES as $FILE_NAME) {
    $sql = "SELECT * FROM $FILE_NAME";
    $res = mysqli_query($conn, $sql);
    $t = "<?php\n";
    while ($row = mysqli_fetch_assoc($res)) {
        $t .= '$' . $row['geslo'] . "=\"";
        $t .= $row['vrednost'] . "\";\n";
    }
    file_put_contents("./lokal/" . $FILE_NAME . ".php", $t);
}
