<link rel="stylesheet" href="./css.css">
<?php
$prog = [
    'gimnazija',
    'strokovna šola',
    'drugo'
];
include_once("programi.php");
if (isset($programi))
    $prog = $programi;

$zbirka = base64_encode(json_encode([]));
if (isset($_GET['zbirka']))
    $zbirka = $_GET['zbirka'];
?>

<form action="prog.php" class="forma" method="get">
    <fieldset>
        <legend>Vnos Podatkov</legend>
        <div class="line">
            Ime:<input type="text" name="ime" required>
        </div>
        <div class="line">
            Priimek:<input type="text" name="priimek" required>
        </div>
        <div class="row">
            <?php
            foreach ($prog as $key => $bri) {
                echo "<input type=\"radio\" name=\"program\" value=\"$bri\" required " . ($key == 0 ? "checked" : "") . ">$bri";
            }
            ?>
        </div>
        <input type="submit">
        <input type="reset">
        <input type="text" name="zbirka" value="<?= $zbirka ?>" hidden>
    </fieldset>
</form>

<?php
echo "<br><a href=\"iscinaloga3.php?zbirka=" . $zbirka . "\">ISCI</a>";
echo "<br><a href=\"Naloga2.php?zbirka=" . $zbirka . "\">VIZUALIZIRAJ</a>";
echo "<br><a href=\"zapisiVFile.php?zbirka=" . $zbirka . "\">ZAPISI V FILE</a>";
