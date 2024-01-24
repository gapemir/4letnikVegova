<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="style.css" rel="stylesheet">
</head>

<body>
    
    <?php
    $predmetnik = ['mat', 'fiz', 'slo', 'nsa'];
    $razredi = [
        'r3a' => [[
            'zap_st' => 1,
            'ime' => 'Milan',
            'pri' => 'Toš',
            'redovalnica' => [
                'mat' => [
                    [3, '05.03.2024'],
                    [4, '12.03.2024']
                ],
                'fiz' => [
                    [2, '01.03.2024']
                ],
            ],
        ], [
            'zap_st' => 2,
            'ime' => 'Franci',
            'pri' => 'Novak',
            'redovalnica' => [
                'mat' => [
                    [
                        [1, '05.03.2024'],
                        [5, '14.03.2024'],
                    ],
                    [4, '12.03.2024']
                ],
                'fiz' => [
                    [2, '10.03.2024'],
                    [4, '17.03.2024']
                ],
            ]
        ]],
        'r3b' => [[
            'zap_st' => 3,
            'ime' => 'Miha',
            'pri' => 'Petek',
            'redovalnica' => [
                'mat' => [
                    [
                        [1, '05.03.2024'],
                        [3, '14.03.2024'],
                    ],
                    [4, '12.03.2024']
                ],
                'fiz' => [
                    [2, '10.03.2024'],
                    [4, '17.03.2024']
                ],
            ],
        ], [
            'zap_st' => 4,
            'ime' => 'Marko',
            'pri' => 'Cigale',
            'redovalnica' => [
                'mat' => [
                    [5, '05.03.2024'],
                    [4, '12.03.2024']
                ],
                'fiz' => [
                    [2, '10.03.2024'],
                    [4, '17.03.2024']
                ],
            ]
        ]]
    ];
    if (isset($_GET['razredi']) && is_array(json_decode(base64_decode($_GET['razredi']), 1))) {
        $razredi = json_decode(base64_decode($_GET['razredi']), 1);
    }
    if (
        isset($_GET['dijak']) && isset($_GET['predmet']) && isset($_GET['ocena']) && isset($_GET['ocenaNovaPrejsnja']) &&
        $_GET['dijak'] != 0 && $_GET['predmet'] != 0 && $_GET['ocena'] != 0
    ) {
        $date = date("d.m.Y");
        $dijakst = $_GET['dijak'];
        $predmet = $_GET['predmet'];
        $ocena = $_GET['ocena'];
        $ocenaNovaPrejsnja = $_GET['ocenaNovaPrejsnja'];
        if ($ocenaNovaPrejsnja == -1) {
            foreach ($razredi as $razredKey => $razred) {
                foreach ($razred as $dijakKey => $dijak) {
                    if ($dijak['zap_st'] == $dijakst) {
                        $razredi[$razredKey][$dijakKey]['redovalnica'][$predmet][] = [$ocena, $date];
                    }
                }
            }
        } else {
            foreach ($razredi as $razredKey => $razred) {
                foreach ($razred as $dijakKey => $dijak) {
                    if ($dijak['zap_st'] == $dijakst) {
                        $tmp = $dijak['redovalnica'][$predmet][$ocenaNovaPrejsnja];
                        if (!is_array($tmp[0]))
                            $razredi[$razredKey][$dijakKey]['redovalnica'][$predmet][$ocenaNovaPrejsnja] = [$tmp, [$ocena, $date]];
                        else
                            $razredi[$razredKey][$dijakKey]['redovalnica'][$predmet][$ocenaNovaPrejsnja][] =  [$ocena, $date];
                    }
                }
            }
        }
    }

    ?>

    <form action="">
        <div class="cont">
            <div class="razdij">
                <label>Razred</label>
                <select id="razred" autocomplete="off">
                    <option value="0" selected="true">--izberi--</option>
                    <?php
                    foreach ($razredi as $key => $bri) {
                        $t = "0,";
                        foreach ($bri as $e) {
                            $t .= $e['zap_st'] . ",";
                        }
                        rtrim($t, ",");
                        echo "<option value=\"$t\">$key</option>";
                    }
                    ?>
                </select>

                <label>Dijak</label>
                <select id="dijak" name="dijak" autocomplete="off">
                    <option value="0" selected>--izberi--</option>
                    <?php foreach ($razredi as $key => $bri) {
                        foreach ($bri as $e) {
                            echo "<option value=" . $e['zap_st'] . ">" . $e['ime'] . " " . $e['pri'] . "</option>";
                        }
                    }
                    ?>
                </select>
            </div>

            <div class="predmet"><label>Predmet</label><select id="predmet" name="predmet">
                    <option value="0" selected>--izberi--</option>
                    <?php foreach ($predmetnik as $bri) {
                        echo "<option value=" . $bri . ">" . $bri . "</option>";
                    }
                    ?>
                </select></div>


            <div class="ocena">
                <input type="radio" name="ocena" id="idNPS" value="NPS" checked="true" /><label for="idNPS">NPS</label>
                <input type="radio" name="ocena" id="id1" value="1" /><label for="id1">1</label>
                <input type="radio" name="ocena" id="id2" value="2" /><label for="id2">2</label>
                <input type="radio" name="ocena" id="id3" value="3" /><label for="id3">3</label>
                <input type="radio" name="ocena" id="id4" value="4" /><label for="id4">4</label>
                <input type="radio" name="ocena" id="id5" value="5" /><label for="id5">5</label>
            </div>
            <input type="submit" />
        </div>
        <div class="popOceneCont">
            <div id="novaOcena" class="PopOcene" hidden="true">
                <input type="radio" name="ocenaNovaPrejsnja" id="novaOcena" value="-1" checked="true" />
                <label for="novaOcena">Nova Ocena</label>
            </div>
            <?php
            foreach ($razredi as $key => $razred) {
                foreach ($razred as $dijak) {
                    foreach ($dijak['redovalnica'] as $predmet => $ocene) {
                        $st = 0;
                        foreach ($ocene as $oc) {
                            if (is_array($oc[0])) {
                                $s = false;
                                foreach ($oc as $o) {
                                    if ($s == false)
                                        echo '<div id=' . $dijak['zap_st'] . $predmet . $st . ' class="PopOcene" hidden="true">
                            <input type="radio" name="ocenaNovaPrejsnja" id="' . $dijak['zap_st'] . $predmet . $st . '" value="' . $st . '" />
                            <label for="' . $dijak['zap_st'] . $predmet . $st . '">' . "" . $o[0] . " (" . $o[1] . ')</label></div>';
                                    else
                                        echo '<div id=' . $dijak['zap_st'] . $predmet . $st . ' class="PopOcene" hidden="true">
                                        <input type="radio" name="ocenaNovaPrejsnja" id="' . $dijak['zap_st'] . $predmet . $st . '" value="' . $st . '" />
                                        <label for="' . $dijak['zap_st'] . $predmet . $st . '">' . "(pop)" . $o[0] . " (" . $o[1] . ')</label></div>';
                                    $s = true;
                                }
                            } else {
                                echo '<div id=' . $dijak['zap_st'] . $predmet . $st . ' class="PopOcene" hidden="true">
                                <input type="radio" name="ocenaNovaPrejsnja" id="' . $dijak['zap_st'] . $predmet . $st . '" value="' . $st . '" />
                                <label for="' . $dijak['zap_st'] . $predmet . $st . '">' . $oc[0] . " (" . $oc[1] . ')</label></div>';
                            }
                            $st++;
                        }
                    }
                }
            }
            ?>
        </div>
        <input type="text" name="razredi" value="<?php echo base64_encode(json_encode($razredi)) ?>" hidden="true">
    </form>
    <?php
    foreach ($razredi as $key => $razred) {
        foreach ($razred as $dijak) {
            echo '<div id="dijak' . $dijak['zap_st'] . '" class="oceneDijaka" hidden>';
            foreach ($dijak['redovalnica'] as $predmet => $ocene) {
                $t = "<p>$predmet: ";
                foreach ($ocene as $oc) {
                    if (is_array($oc[0]))
                        foreach ($oc as $o) {
                            $t .= $o[0];
                        }
                    else
                        $t .= $oc[0];
                    $t .= ",";
                }
                $t = rtrim($t, ",");
                $t .= "</p>";
                echo $t;
            }
            echo "</div>";
        }
    }
    ?>

    <script>
        const beta = document.getElementById('dijak');
        const betaOpts = [...beta.children];
        console.log(betaOpts);

        document.getElementById('razred').addEventListener('change', (e) => {
            beta.innerHTML = betaOpts.filter(
                o => e.target.value.includes(o.value)
            ).map(o => o.outerHTML).join('')
        });
        document.getElementById('dijak').addEventListener('change', (e) => {
            hideAllCurrOcene();
            document.getElementById('dijak' + document.getElementById('dijak').value).hidden = false;
        });
        document.getElementById('predmet').addEventListener('change', (e) => {
            hideAllPopOcene();
            let dij = document.getElementById('dijak').value;
            let pred = document.getElementById('predmet').value;
            let x = document.getElementsByClassName("PopOcene");
            x[0].hidden = false;
            Array.from(x).forEach((el) => {
                if (el.id.includes(dij + pred))
                    el.hidden = false;
            });
        });


        function hideAllPopOcene() {
            let x = document.getElementsByClassName("PopOcene");
            Array.from(x).forEach((el) => {
                el.hidden = true;
            });
        }

        function hideAllCurrOcene() {
            let x = document.getElementsByClassName("oceneDijaka").length;
            for (i = 1; i < x + 1; i++) {
                document.getElementById("dijak" + i).hidden = true;
            }
        }
    </script>
</body>

</html>