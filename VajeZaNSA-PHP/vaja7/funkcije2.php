<?php

function izpisiOtroka($otrok)
{
    echo "<b>" . $otrok["ime"] . ": </b>";
    foreach ($otrok["igraca"] as $igraca) {
        echo $igraca . " ";
    }
    echo "<br>";
}
function izpisiOtrokaCeImaIgraco($vrtec, $igraca)
{
    foreach ($vrtec as $otrok) {
        foreach ($otrok["igraca"] as $igrace)
            if ($igrace == $igraca)
                echo $otrok["ime"] . "<br>";
        //echo $otrok["ime"] . "<br>";
    }
}
function izpisiOtrokaCeNimaIgrace($vrtec, $igraca)
{
    $f = false;
    foreach ($vrtec as $otrok) {
        foreach ($otrok["igraca"] as $igrace)
            if ($igrace == $igraca)
                $f = true;
        if (!$f)
            echo $otrok["ime"] . "<br>";
        $f = false;
    }
}
function preoblikujTabelo($vrtec)
{
    $tab = array();
    foreach ($vrtec as $otrok) {
        foreach ($otrok["igraca"] as $igraca)
            if (isset($tab[$igraca]))
                $tab[$igraca] .= " " . $otrok["ime"];
            else
                $tab[$igraca] = $otrok["ime"];
    }
    return $tab;
}
function izpisiOtrokaCeImaIgraco2($vrtec, $igraca)
{
    echo $vrtec[$igraca];
}
function izpisiOtrokaCeNimaIgrace2($vrtec1, $igraca, $vrtec)
{
    $arr = explode(" ",$vrtec[$igraca]);
    foreach($arr as $e){
        unset($vrtec[$e]);
    }
}
