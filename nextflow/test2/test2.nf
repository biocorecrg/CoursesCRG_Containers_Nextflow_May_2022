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


/* Reading the file list and creating a "Channel": a queue that connects different channels.
 * The queue is consumed by channels, so you cannot re-use a channel for different processes. 
 * If you need the same data for different processes you need to make more channels.
 */
 
Channel
    .fromPath( params.reads )  											 // read the files indicated by the wildcard                            
    .ifEmpty { error "Cannot find any reads matching: ${params.reads}" } // if empty, complains
    .set {reads_for_fastqc} 											 // make the channel "reads_for_fastqc"


/*
 * Process 1. Run FastQC on raw data. A process is the element for executing scripts / programs etc.
 */
process fastQC {
    publishDir fastqcOutputFolder  			// where (and whether) to publish the results
    tag { "${reads}" }  							// during the execution prints the indicated variable for follow-up
    label 'big_mem' 

    input:
    path reads   							// it defines the input of the process. It sets values from a channel

    output:									// It defines the output of the process (i.e. files) and send to a new channel
   	path "*_fastqc.*"

    script:									// here you have the execution of the script / program. Basically is the command line
    """
        fastqc ${reads} 
    """
}

/*
 * Process 2. Run multiQC on fastQC results
 */
process multiQC {
    publishDir multiqcOutputFolder, mode: 'copy' 	// this time do not link but copy the output file

    input:
    path (inputfiles)

    output:
    path("multiqc_report.html") 					// do not send the results to any channel

    script:
    """
    multiqc .
    """
}

workflow {
	fastqc_out = fastQC(reads_for_fastqc)
	multiQC(fastqc_out.collect())
}


workflow.onComplete { 
	println ( workflow.success ? "\nDone! Open the following report in your browser --> ${multiqcOutputFolder}/multiqc_report.html\n" : "Oops .. something went wrong" )
}


