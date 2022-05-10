#!/usr/bin/env nextflow

// enable DSL2
nextflow.enable.dsl=2

/*
* Let's create the channel `my_files`
* using the method fromPath
*/

Channel
    .fromPath( "*.txt" )
    .set {my_files}

// We can use the view() operator again to see the content of channel "my_files"

my_files.view()
