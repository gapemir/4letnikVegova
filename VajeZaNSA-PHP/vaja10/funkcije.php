<?php

function genOseba(): array
{
    $ime = ['pepi', 'vid', 'stana', 'eva', 'tjaša', 'črt', 'tonči', 'robert', 'aleks', 'poldi', 'pek'];
    $pri = ['kovač', 'pek', 'birt', 'kolar', 'šuštar', 'malnar', 'tišler', 'logar', 'mežnar'];
    $frm = "%02d%02d%03d50%01d%03d";
    $o = [
        'emso'     => sprintf($frm, rand(1, 31), rand(1, 12), rand(900, 999), rand(0, 1) * 5, rand(0, 999)),
        'ime'      => $ime[rand(0, count($ime) - 1)],
        'priimek'  => $pri[rand(0, count($pri) - 1)],
        'starost'  => rand(16, 93)
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

function vrniHTMLTabelo(array $data, string $kam = "ogled"): string
{
    $t = "";
    $t .= "<table>";
    foreach ($data as $key => $val) {
        $t .= "<tr>";
        $t .= "<td><a href=\"$kam.php?table=" . base64_encode(json_encode($data)) . "&emso=" . base64_encode(json_encode($key)) . "\">$key</a></td>";
        foreach ($val as $k => $v) {
            $t .= "<td>$v</td>";
        }
        $t .= "</tr>";
    }
    return $t . "<style>table{border-collapse:collapse;}table,row,td{border:1px solid black;}</style>";
}
