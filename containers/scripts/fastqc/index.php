<?php

/** Simple PHP interface web script **/
$path = "/scratch";

if ( array_key_exists( "file", $_REQUEST ) ) {

  $file = $_REQUEST["file"];
  $modifile = str_replace(".fastq", "_fastqc", $file);

  if ( ! file_exists( $path."/".$modifile.".html" ) ) {

    if ( file_exists( $path."/".$file.".gz" ) ) {

      shell_exec("cd $path; fastqc $file.gz");

      printHtml( $path."/".$modifile.".html" );

    } else {

      echo "Error processing FASTQ $path/$file";
    }

  } else {

    printHtml( $path."/".$modifile.".html" );

  }

} else {

    echo "Nothing to see here";

}

function printHtml( $htmlfile ) {

  header('Content-type: text/html');
  $html = file_get_contents( $htmlfile );
  echo $html;

}
