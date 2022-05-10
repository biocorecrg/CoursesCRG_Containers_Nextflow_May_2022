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
reference                       : ${params.reference}
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
alnOutputFolder       = "ouptut_aln"
multiqcOutputFolder   = "ouptut_multiQC"

 
Channel
    .fromPath( params.reads )  											 // read the files indicated by the wildcard                            
    .ifEmpty { error "Cannot find any reads matching: ${params.reads}" } // if empty, complains
    .set {reads} 														 // make the channel "reads_for_fastqc"

reference = file(params.reference)

include { fastqc } from "${baseDir}/modules/fastqc" addParams(OUTPUT: fastqcOutputFolder, LABEL="twocpus")
include { BOWTIE } from "${baseDir}/modules/bowtie" addParams(OUTPUT: alnOutputFolder, LABEL="twocpus")
include { multiqc } from "${baseDir}/modules/multiqc" addParams(OUTPUT: multiqcOutputFolder)
 

workflow {
	fastqc_out = fastqc(reads)
	map_res = BOWTIE(reference, reads)
	map_res.sam.view()
	map_res.logs.view()
	multiqc(fastqc_out.mix(map_res.logs).collect())
}



workflow.onComplete { 
	println ( workflow.success ? "\nDone! Open the following report in your browser --> ${multiqcOutputFolder}/multiqc_report.html\n" : "Oops .. something went wrong" )
}

