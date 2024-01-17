<html>
  <head>
   <title>
     Osnovna telovadba s spremenljivkami
   </title>
  </head>
 <body>
 <?php
  $a="1";
  echo "a...".var_dump($a)."<br/ >";
  echo is_bool($a)."<br/ >";
  echo is_double($a)."<br/ >";
  echo is_float($a)."<br/ >";
  echo is_int($a)."<br/ >";
  echo is_long($a)."<br/ >";
  echo is_null($a)."<br/ >"; 
  echo is_numeric($a)."<br/ >"; 
  echo is_string($a)."<br/ >";
  $b=1;
  echo "b...".var_dump($b)."<br/ >";
  echo is_bool($b)."<br/ >";
  echo is_double($b)."<br/ >";
  echo is_float($b)."<br/ >";
  echo is_int($b)."<br/ >";
  echo is_long($b)."<br/ >";
  echo is_null($b)."<br/ >"; 
  echo is_numeric($b)."<br/ >"; 
  echo is_string($b)."<br/ >";
  $c=1.0;
  echo "c...".var_dump($c)."<br/ >";
  echo is_bool($c)."<br/ >";
  echo is_double($c)."<br/ >";
  echo is_float($c)."<br/ >";
  echo is_int($c)."<br/ >";
  echo is_long($c)."<br/ >";
  echo is_null($c)."<br/ >"; 
  echo is_numeric($c)."<br/ >"; 
  echo is_string($c)."<br/ >";
  $d=true;
  echo "d...".var_dump($d)."<br/ >";  
  echo is_bool($d)."<br/ >";
  echo is_double($d)."<br/ >";
  echo is_float($d)."<br/ >";
  echo is_int($d)."<br/ >";
  echo is_long($d)."<br/ >";
  echo is_null($d)."<br/ >"; 
  echo is_numeric($d)."<br/ >"; 
  echo is_string($d)."<br/ >";
  ?>
 </body>
</html>

