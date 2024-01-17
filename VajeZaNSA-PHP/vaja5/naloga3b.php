<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <style>
        table,
        tr,
        td {
            border: 1px solid black;
        }

        .italic {
            font-style: italic;
            background-color: lime;
        }

        .bold {
            font-weight: bald;
            background-color: red;
        }
    </style>
    <?php
    $bin = "";
    for ($i = 0; $i < 8; $i++)
        $bin .= rand(0, 1);
    $dec = bindec($bin);
    if ($bin[0] == 1) 
        $dec = ($dec - 127) * -1;
    echo "<table style=\"text-align:center;\"><tr><td>Dvojisko stevilo</td><td>Desetisko stevilo</td></tr>";
    echo "<tr><td>$bin</td><td>$dec</td></tr></table>";

    ?>
</body>

</html>
<?php
/*****************For Programmers************************/
$imageWidth = 300;                             //image width 
$imageHeight = 300;                            //image height
$diameter = 150;                               //pie diameter 
$centerX = 150;                                //pie center pixels x
$centerY = 150;                                //pie center pixels y
$labelWidth = 10;                              //label width, no need to change 
/*************************End****************************/

createPieChart($imageWidth, $imageHeight, $diameter, $centerX, $centerY, $dec);

function createPieChart($imageWidth, $imageHeight, $diameter, $centerX, $centerY, $dec)
{

    $im = ImageCreate($imageWidth, $imageHeight);

    $color[] = ImageColorAllocate($im, 153, 204, 0); //green
    $color[] = ImageColorAllocate($im, 255, 0, 0); //red
    $white = ImageColorAllocate($im, 255, 255, 255);
    $black = ImageColorAllocate($im, 0, 0, 0);
    $grey = ImageColorAllocate($im, 215, 215, 215);

    if ($dec < 0)
        $dec = ($dec * -1) + 128;
    $x2 = $dec / 255 * 200 + 50;
    $y2 = 200 - sqrt((100 * 100) - (abs(150 - $x2) * abs(150 - $x2)));

    ImageFill($im, 0, 0, $black);
    imagearc($im, $centerX, $centerY + 25, $imageWidth - 100, $imageHeight - 100, 180, 0, $color[1]);
    //imageline($im,$centerX,$centerY+25,$x2,$y2,$color[0]);
    imageline($im, $x2, $y2, 150, 150, $color[0]);

    imagepng($im, "image.png");
    echo "<img src=\"image.png\">";
}

