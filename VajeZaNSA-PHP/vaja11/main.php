<link rel="stylesheet" href="css.css">
<?php

if (!isset($_GET['table']) || !is_array(json_decode(base64_decode($_GET['table']), 1)) || !isset($_GET['emso']))
	header("location:vaja11.php");
$osebe = json_decode(base64_decode($_GET['table']), 1);
$emso = $_GET['emso'];

$oseba = $osebe[$emso];

echo "<table>";
echo "<tr><td class=\"tile\">";
//prvi kvadrat
echo '<div class="kartica">
  <div class="ido">id osebe : ' . $emso . '</div>
  <div class="vsebina">
	<div class="podatki">
		<div>' . $oseba['ime'] . '</div>
		<div>' . $oseba['priimek'] . '</div>
		<div>' . $oseba['starost'] . '</div>
	</div>
	<div class="slika">
		<img src="https://thispersondoesnotexist.com/" height="150px">
	</div>
  </div>
</div>';
echo "</td><td class=\"tile\">";
//drugi kvadrat
echo "<div style=\"display:flex;align-items:center;justify-content:center\">";
echo "<form action=\"delete.php\">";
echo "<input type=\"submit\" value=\"DELETE\"/>";
echo '<input type="hidden" name="table" value="' . $_GET['table'] . '"/>';
echo '<input type="hidden" name="emso" value="' . $emso . '"/>';
echo "</form></div>";
echo "</td></tr>";
echo "<tr><td class=\"tile\">";
//tretji kvadrat

echo "<form action=\"azur.php\">";
echo "emšo:<input name=\"emso\" value=\"$emso\" readonly>";
echo "ime:<input name=\"ime\" value=" . $oseba["ime"] . " \" >";
echo "priimek:<input name=\"priimek\" value=" . $oseba["priimek"] . " \" >";
echo "starost:<input name=\"starost\" value=" . $oseba["starost"] . " \" >";
echo "<input type=\"hidden\" name=\"table\" value=" . $_GET['table'] . " \">";
echo "<input type=\"submit\" value=\"uveljavi\" />";
echo "</form>";

echo "</td><td class=\"tile\">";
//setrti kvadrat

echo "<form action=\"vnos.php\">";
echo "emšo:<input name=\"emso\">";
echo "ime:<input name=\"ime\">";
echo "priimek:<input name=\"priimek\">";
echo "starost:<input name=\"starost\">";
echo "<input type=\"hidden\" name=\"table\" value=" . $_GET['table'] . " \">";
echo "<input type=\"submit\" value=\"uveljavi\" />";
echo "</form>";

echo "<style>input{display:block;}.red{color:red;}</style>";


echo "</td></tr>";
echo "</table>";
