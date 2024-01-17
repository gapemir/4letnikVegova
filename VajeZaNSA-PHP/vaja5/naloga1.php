<?php 

function narediNiz($n){
    $c = "abcdefghijklmnopqrstuvwxyz";
    $t="";
    for($i=0;$i<$n;$i++){
        $t.=$c[rand(0,25)];
    }
    return $t;
}
function izpisiPrafaktorje($n){
    echo "$n<br>";
    $pra=[2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59];
    for($i=count($pra)-1;$i>=0;$i--){
        if($n%$pra[$i]==0){
            $n/=$pra[$i];
            echo $pra[$i]." ";
            $i++;
        }
        if(in_array($n,$pra)){
            echo $n;
            return;
        }
    }
    echo "nisem mogel priti do konca";
}
function stakniTabele($tab1,$tab2) {
    $t=[];
    if(!is_array($tab1)OR!is_array($tab2))
        return $t;
    for($i=0;$i<count($tab1);$i++)
        $t[] = $tab1[$i];
    for($i=0;$i<count($tab2);$i++)
        $t[] = $tab2[$i];
    return $t;
}
function jeUrejenaNarascajoce($t){
    if(!is_array($t))
        return 0;
    $a = array_values($t)[0];
    foreach ($t as $key => $value) {
        if($value<$a)
            return false;
        $a = $value;
    }
    return true;
}
function jeUrejena($t) {
    if(!is_array($t))
        return 0;
    $mod="";
    $mix=array_values($t)[0];
    foreach($t as $key => $value) {
        if($mix == $value)
            continue;
        if($mix>$value AND $mod=="")
            $mod=">";
        else if($mix<$value AND $mod=="")
            $mod="<";
        if($mod==">"){
            if($mix<$value)
                return 0;
        }
        else{
            if($mix>$value)
            return 0;
        }
    }
    return 1;
}
function zlij($t1,$t2){
    $t = stakniTabele($t1,$t2);
    sort($t);
    return $t;
}

?>
