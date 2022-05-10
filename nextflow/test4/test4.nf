#!/usr/bin/env nextflow

/* 
 * This code enables the new dsl of Nextflow. 
 */

nextflow.enable.dsl=2


/* 
 * NextFlow test pipe
 * @authors
 * Luca Cozzuto <lucacozzuto@gmail.com>
 * 
 */

/*
 * Input parameters: read pairs
 * Params are stored in the params.config file
 */

version                 = "1.0"
// this prevents a warning of undefined parameter
params.help             = false

// this prints the input parameters
log.info """
BIOCORE@CRG - N F TESTPIPE  ~  version ${version}
=============================================
reads                           : ${params.reads}
"""

// this prints the help in case you use --help parameter in the command line and it stops the pipeline
if (params.help) {
    log.info 'This is the Biocore\'s NF test pipeline'
    log.info 'Enjoy!'
    log.info '\n'
    exit 1
}

/*
 * Defining the output folders.
 */
fastqcOutputFolder    = "ouptut_fastqc"
multiqcOutputFolder   = "ouptut_multiQC"

 
Channel
    .fromPath( params.reads )  											 // read the files indicated by the wildcard                            
    .ifEmpty { error "Cannot find any reads matching: ${params.reads}" } // if empty, complains
    .set {reads_for_fastqc} 											 // make the channel "reads_for_fastqc"


include { multiqc } from "${baseDir}/modules/multiqc" addParams(OUTPUT: multiqcOutputFolder)
include { fastqc } from "${baseDir}/modules/fastqc" addParams(OUTPUT: fastqcOutputFolder, LABEL="twocpus")
 
workflow {
	fastqc_out = fastqc(reads_for_fastqc)
	multiqc(fastqc_out.collect())
}


workflow.onComplete { 
	println ( workflow.success ? "\nDone! Open the following report in your browser --> ${multiqcOutputFolder}/multiqc_report.html\n" : "Oops .. something went wrong" )
}

