#!/usr/bin/env nextflow

/*
 * Copyright (c) 2013-2020, Centre for Genomic Regulation (CRG).
 *
 *   This file is part of 'CRG_Containers_NextFlow'.
 *
 *   CRG_Containers_NextFlow is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   CRG_Containers_NextFlow is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with CRG_Containers_NextFlow.  If not, see <http://www.gnu.org/licenses/>.
 */


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

include { fastqc } from "${baseDir}/modules/fastqc" addParams(OUTPUT: fastqcOutputFolder)
include { BOWTIE } from "${baseDir}/modules/bowtie" addParams(OUTPUT: alnOutputFolder)
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

