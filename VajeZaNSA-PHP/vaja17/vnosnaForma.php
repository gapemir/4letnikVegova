<?php
require_once "./lokal/si.php";
$def = "si";
$lokalFiles = scandir("./lokal/");
unset($lokalFiles[0]);
unset($lokalFiles[1]);
foreach ($lokalFiles as $key => $file)
    $lokalFiles[$key] = substr($file, 0, 2);
if (isset($_GET['lang']) && in_array($_GET['lang'], $lokalFiles)) {
    require_once "./lokal/" . $_GET['lang'] . ".php";
    $def = "";
}
?>
<form action="">
    <select name="lang">
        <?php
        foreach ($lokalFiles as $file)
            if ($_GET['lang'] == $file || $def == $file)
                echo "<option value=\"" . $file . "\" selected>" . $file . "</option>";
            else
                echo "<option value=\"" . $file . "\">" . $file . "</option>";
        ?>
    </select>
    <input type="submit" value="<?= $submit ?>">
</form>
<form>
    <table>
        <tr>
            <td><?= $ime ?></td>
            <td><input type="text" name="ime"></td>
        </tr>
        <tr>
            <td><?= $priimek ?></td>
            <td><input type="text" name="priimek"></td>
        </tr>
        <tr>
            <td><?= $spol ?></td>
            <td><input type="text" name="spol"></td>
        </tr>
        <tr>
            <td><?= $tel ?></td>
            <td><input type="tel" name="tel"></td>
        </tr>
        <tr>
            <td><?= $email ?></td>
            <td><input type="email" name="email"></td>
        </tr>
        <tr>
            <td><?= $kraj ?></td>
            <td><input type="text" name="kraj"></td>
        </tr>
        <tr>
            <td><input type="submit" value="<?= $submit ?>"></td>
        </tr>
    </table>
</form>