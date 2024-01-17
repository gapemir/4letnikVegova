<?php
require_once('podatki.php');

function genOseba(&$tab, &$tabDavcna)
{
    $spol = rand(0, 1); //0=zenska, 1=moski
    $mestoposta = genMestoPosta();
    $oseba = [
        'Ime' => genIme($spol),
        'Priimek' => genPri(),
        'Naslavljanje' => genNasljavljanje($spol),
        'Emso' => genEMSO($tab, $spol),
        'Davcna' => genDavcna($tabDavcna),
        'Naslov' => [
            'Ulica' => genUlico(),
            'Hišna' => rand(0, 250),
            'Mesto' => $mestoposta[1],
            'Posta' => $mestoposta[0],
            'Pokrajina' => genPokrajina(),
            'Drzava' => 'Slovenija'
        ],
        'Kontakt' => [
            'Tel' => genTel($mestoposta[0]),
            'Mobi' => genMobTel(),
        ],
        'Sluzba' => [
            'Podjetje' => genPodjetje(),
            'Naslov' => genUlico(),
            'Tel' => genTel(rand(0, 9)),
            'Mobi' => genMobTel()
        ],
        'Ostalo' => [
            'DomacaZival' => [],
            'Pijaca' => []
        ]
    ];
    $oseba['Kontakt']['Email'] = genEmail($oseba['Ime'], $oseba['Priimek'], "gmail");
    $oseba['Sluzba']['Email'] = genEmail($oseba['Ime'], $oseba['Priimek'], $oseba['Sluzba']['Podjetje']);
    $tab[genId($oseba['Davcna'])] = $oseba;
    return $oseba;
}
function genPokrajina()
{
    global $pokrajina;
    return $pokrajina[rand(0, count($pokrajina) - 1)];
}
function genNasljavljanje($spol)
{
    $x = [["gdč.", "ga.", "gospa", "dr.", "mag."], ["g.", "gospod", "dr.", "mag."]];
    return $x[$spol][rand(0, count($x[$spol]) - 1)];
}
function genEmail($ime, $pri, $domena)
{
    $x = str_replace(' ', '', strtolower($ime . "." . $pri . "@" . $domena . ".si"));
    return str_replace('č', 'c', str_replace('š', 's', str_replace('ž', 'z', $x)));
}
function genPodjetje()
{
    global $podjetje;
    return $podjetje[rand(0, count($podjetje) - 1)];
}
function genMobTel()
{
    $x = ["030", "040", "068", "069", "031", "041", "051", "065", "070", "071", "064", "065"];
    return $x[rand(0, count($x) - 1)] . rand(0, 999999);
}
function genTel($posta)
{
    return "0" . $posta / 1000 . rand(0, 999999);
}
function genUlico()
{
    global $ulica;
    return $ulica[rand(0, count($ulica) - 1)];
}
function genMestoPosta()
{
    global $posta;
    return $posta[rand(0, count($posta) - 1)];
}
function genId($davcna)
{
    return "F-SI" . $davcna;
}
function genDavcna(&$tabDavcna)
{
    $dav = "";
    for ($i = 0; $i < 8; $i++)
        $dav .= rand(0, 9);
    if (isset($tabDavcna[$dav]))
        $dav = genDavcna($tabDavcna);
    $tabDavcna[$dav] = true;
    return $dav;
}
function genIme($spol)
{
    global $imena;
    return $imena[$spol][rand(0, count($imena[$spol]) - 1)];
}
function genPri()
{
    global $priimki;
    return $priimki[rand(0, count($priimki) - 1)];
}
function genEMSO(array $tab, bool $spol)
{

    $frm = "%02d%02d%03d50%01d%03d";
    $leto = (int)date("Y") - rand(0, 90) - 1000;
    $emso = sprintf($frm, rand(1, 31), rand(1, 12), $leto, 5 - $spol * 5, rand(0, 999));
    if (isset($tab[$emso]))
        $emso = genEMSO($tab, $spol);
    return $emso;
}
