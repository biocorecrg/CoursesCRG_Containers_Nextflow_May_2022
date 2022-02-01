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
 * HERE YOU HAVE THE COMMMENTS
 * NextFlow example from their website 
 */
 
params.inputfile = "$baseDir/../../testdata/test.fa"	// this can be overridden by using --inputfile OTHERFILENAME

sequences_file = file(params.inputfile)				// the "file method" returns a file system object given a file path string  

if( !sequences_file.exists() ) exit 1, "Missing genome file: ${sequences_file}" // check if the file exists


/*
 * split a fasta file in multiple files
 */
 
process splitSequences {

    input:
    path sequencesFile // nextflow creates links to the original files in a temporary folder
 
    output:
    path ('seq_*')    // send output files to a new output channel (in this case is a collection)
 
    // simple awk command

    script:
    """
    awk '/^>/{f="seq_"++d} {print > f}' < ${sequencesFile}
    """ 
}


/*
 * Simple reverse the sequences
 */
 
process reverseSequence {
    tag { "${seq}" }  					// during the execution prints the indicated variable for follow-up
    publishDir "output"
	errorStrategy 'ignore'

    input:
    path seq 

    output:
    path "all.rev" 
 
	script:
    """
    cat ${seq} | awk '{if (\$1~">") {print \$0} else system("echo " \$0 " |rev")}' > all.rev
    """
}

workflow {
    splitted_seq	= splitSequences(sequences_file)
    // Here you have the output channel as a collection
    splitted_seq.view()
    // Here you have the same channel reshaped to send separately each value 
    splitted_seq.flatten().view()
    // DLS2 allows you to reuse the channels! In past you had to create many identical
    // channels for sending the same kind of data to different processes
    rev_single_seq	= reverseSequence(splitted_seq)
}
