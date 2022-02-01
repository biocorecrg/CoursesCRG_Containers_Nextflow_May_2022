#!/usr/bin/env nextflow


nextflow.enable.dsl=2



version                 = "1.0"
// this prevents a warning of undefined parameter
params.help             = false

// this prints the input parameters
log.info """
reads                           : ${params.reads}
reference                       : ${params.reference}
"""


/*
 * Defining the output folders.
 */
fastqcOutputFolder    = "ouptut_fastqc"
alnOutputFolder       = "ouptut_aln"
macs2OutputFolder   = "ouptut_macs2"

 
Channel
    .fromPath( params.reads )  											 // read the files indicated by the wildcard                            
    .ifEmpty { error "Cannot find any reads matching: ${params.reads}" } // if empty, complains
    .set {reads} 														 // make the channel "reads_for_fastqc"

reference = file(params.reference)

include { fastqc } from "${baseDir}/modules/fastqc" addParams(OUTPUT: fastqcOutputFolder)
include { BOWTIE } from "${baseDir}/modules/bowtie" addParams(OUTPUT: alnOutputFolder)
include { macs2  } from "${baseDir}/modules/macs2"  addParams(OUTPUT: macs2OutputFolder)

workflow {
	map_res = BOWTIE(reference, reads)
	map_res.sam.view()
	map_res.logs.view()
    fastqc(map_res.sam.mix(reads).collect())
	macs2(map_res.sam)
}




workflow.onComplete { 
    println ( workflow.success ? "\nDone!" : "Oops .. something went wrong" )
    }
