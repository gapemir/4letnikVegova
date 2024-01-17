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
<form action="rezultatNaloga3.php">
    <div class="row">
        <input type="radio" name="field" value="program" required checked>program
        <input type="radio" name="field" value="ime" required>ime
        <input type="radio" name="field" value="priimek" required>priimek
        <br>
        <input type="text" name="s" required>
        <input type="submit">
        <input type="text" name="zbirka" value="<?= $zbirka ?>" hidden>
</form>