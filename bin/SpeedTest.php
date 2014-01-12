<?php
/*
if ($_FILES["file"]["error"] > 0)
  {
  echo "Error: " . $_FILES["file"]["error"] . "<br>\n";
  }
else
  {
  echo "Upload: " . $_FILES["file"]["name"] . "<br>\n";
  echo "Type: " . $_FILES["file"]["type"] . "<br>\n";
  echo "Size: " . ($_FILES["file"]["size"] / 1024) . " kB<br>\n";
  echo "Stored in: " . $_FILES["file"]["tmp_name"];
  }
 */
	$postdata = file_get_contents("php://input");
	echo strlen( $postdata );


?>