<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
<?php
    echo '<div class="parent">';
    for($i=0;$i<200;$i++){
        echo '<div class="child" style="height:'.rand(2,90).'px;width:'.rand(2,90).
        'px;background-color:rgb('.rand(0,255).','.rand(0,255).','.rand(0,255).');
        left:'.rand(0,800).'px;top:'.rand(0,600).'px;"></div>';
    }
    echo "</div>";
?>
</body>
</html>
