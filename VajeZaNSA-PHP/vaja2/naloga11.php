<html>

<head>
    <title>
        Nekaj popravi, nekaj dopiši
    </title>
</head>

<body>
    <?php
    $stara_cena_kave = 100;
    $tecaj = 239.64; // zadnji uradni tečaj za tolarje
    // vpišite formulo, ki bo izračunala staro ceno kave v EUR
    $Kava_EUR = $stara_cena_kave / $tecaj;
    echo "Stara cena kave v EUR " . number_format($Kava_EUR, 2, ",");
    ?>
</body>

</html>