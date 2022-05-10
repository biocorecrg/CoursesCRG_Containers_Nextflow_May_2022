#!/usr/bin/env nextflow

nextflow.enable.dsl=2

str = Channel.from('hello', 'hola', 'bonjour')

/*
 * Creates a process which receives an input channel containing values
 * Each value emitted by the channel triggers the execution
 * of the process. The process stdout is captured and sent over
 * the another channel.
 */

process printHello {
    // this is for displaying the content of `str_in` in the log file
    tag { "${str_in}" } 

    input:
    val str_in

    output:
    stdout

    script:
    """
    echo ${str_in} in Italian is ciao
    """
}
