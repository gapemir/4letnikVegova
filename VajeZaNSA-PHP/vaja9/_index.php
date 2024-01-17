<?php

require_once('generator.php');
require_once('funkcije.php');


$tab = [];
$tabDavcna = [];
genOseba($tab, $tabDavcna);
genOseba($tab, $tabDavcna);
genOseba($tab, $tabDavcna);

echo izpisiHorizontalno($tab);
$tab = mySort($tab);
echo "<br>";
echo izpisiHorizontalno($tab, 1);


echo (getNPeopleOlderThan($tab, 40));
