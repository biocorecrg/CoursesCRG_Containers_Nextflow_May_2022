#!/usr/bin/env nextflow

nextflow.enable.dsl=2

str = Channel.from('hello', 'hola', 'bonjour')

process printHello {
    tag  "${str_in}"

    input:
    val str_in

    output:
    path("${str_in}.txt")

    script:
    """
    	echo ${str_in} in Italian is ciao > ${str_in}.txt
    """
}
process printHello2 {
    tag  "${str_in}"

    input:
    val str_in

    output:
    path("cheers.txt")

    script:
    """
    	echo ${str_in.join(', ')} in Italian are ciao > cheers.txt
    """
}

/*
 * A workflow can be named as a function and receive an input using the take keyword
 */

workflow first_pipeline {

     take: str_input

     main:
     printHello(str_input)
}

/*
 * You can re-use the previous processes an combine as you prefer
 */

workflow second_pipeline {
    take: str_input

    main:
	printHello2(str_input.collect())

}

/*
 * You can then invoke the different named workflows in this way
 * passing the same input channel `str` to both
 */


workflow {
     first_pipeline(str)
     second_pipeline(str)
}
