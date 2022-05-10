#!/usr/bin/env nextflow

nextflow.enable.dsl=2

str = Channel.from('hello', 'hola', 'bonjour')

process printHello {
	tag  "${str_in}"

  	input:
   	val str_in

   	output:
   	stdout

   	script:
   	"""
   		echo ${str_in} in Italian is ciao
   	"""
}

/*
 * A workflow can be named as a function and receive an input using the take keyword while the processing part is described by the main keyword
 */


workflow first_pipeline {
   take: str_input

   main:
   printHello(str_input).view()
}

/*
 * You can re-use the previous processes and combine as you prefer
 */


workflow second_pipeline {
    take: str_input

    main:
    printHello(str_input.collect()).view()
}

/*
 * You can then invoke the different named workflows in this way
* passing the same input channel `str` to both
*/

workflow {
    first_pipeline(str)
    second_pipeline(str)
}
