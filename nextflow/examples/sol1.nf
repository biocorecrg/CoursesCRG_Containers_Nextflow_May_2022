#!/usr/bin/env nextflow

nextflow.enable.dsl=2

Channel
    .fromPath("{aa,bb,cc}.txt")
    .set {my_files}

my_files
    .collect()
    .view()

// You can also write it as: my_files.collect().view()

my_files
    .combine(my_files)
    .view()

my_files
    .collect()
    .map{
		["custom id", it]
}.view()
