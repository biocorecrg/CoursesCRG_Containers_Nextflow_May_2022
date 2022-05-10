#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*
* Let's create the channel `my_files`
* using the method fromFilePairs
*/

Channel
    .fromFilePairs( "aaa_{1,2}.txt" )
    .set {my_files}

my_files.view()
