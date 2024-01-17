<?php

function genOseba(): array
{
    $moski = ['pepi', 'vid', 'črt', 'tonči', 'robert', 'aleks', 'poldi'];
    $zenske = ['stana', 'eva', 'tjaša', 'brina', 'katja', 'špela', 'nina'];
    $crke = "abcčdefghijklmnoprsštuvzž";
    $frm = "%02d%02d%03d50%01d%03d";

    $priimek = "";
    $len = rand(5, 25);
    for ($i = 0; $i < $len; $i++) {
        $priimek .= mb_substr($crke, rand(0, 24), 1);
    }

    $star = rand(0, 128);
    $spol = rand(0, 1);
    $dan = rand(1, 31);
    $mesec = rand(1, 12);
    $f = true;
    while ($f) {
        if ($dan > 28 && $mesec == 2) {
            $mesec = rand(1, 12);
            continue;
        } else if ($dan > 30 && ($mesec == 4 || $mesec == 6 || $mesec == 9 || $mesec == 11)) {
            $mesec = rand(1, 12);
            continue;
        }
        $f = false;
    }
    $letoR = 1024 - $star;
    if ($letoR > 1000)
        $letoR = $letoR - 1000;
    $o = [
        'emso'     => sprintf($frm, $dan, $mesec, $letoR, $spol * 5, rand(0, 999)),
        'ime'      => $spol == 0 ? $moski[rand(0, count($moski) - 1)] : $zenske[rand(0, count($zenske) - 1)],
        'priimek'  => $priimek,
        'starost'  => $star
    ];
    return $o;
}

function reorganizirajOseba(array $osebe): array
{
    $osebe_a = [];
    foreach ($osebe as $k => $v) {
        $e = $v['emso'];
        unset($v['emso']);
        $osebe_a[$e] = $v;
    }
    return $osebe_a;
}

function vrniHTMLTabelo(array $data): string
{
    $t = "";
    $t .= "<table>";
    foreach ($data as $key => $val) {
        $t .= "<tr>";
        $t .= "<td><a href=\"main.php?table=" . base64_encode(json_encode($data)) . "&emso=" . $key . "\">$key</a></td>";
        foreach ($val as $k => $v) {
            $t .= "<td>$v</td>";
        }
        $t .= "</tr>";
    }
    return $t . "<style>table{border-collapse:collapse;}table,row,td{border:1px solid black;}</style>";
}
