#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// this can be overridden by using --inputfile OTHERFILENAME
params.inputfile = "$baseDir/testdata/test.fa"

// the "file method" returns a file system object given a file path string
sequences_file = file(params.inputfile)

// check if the file exists
if( !sequences_file.exists() ) exit 1, "Missing genome file: ${genome_file}"

/*
 * Process 1 for splitting a fasta file in multiple files
 */
process splitSequences {
    input:
    path sequencesFile

    output:
    path ('seq_*')

    // simple awk command
    script:
    """
    awk '/^>/{f="seq_"++d} {print > f}' < ${sequencesFile}
    """
}

/*
 * Process 2 for reversing the sequences
 */
process reverseSequence {
    tag { "${seq}" }

    publishDir "output"

    input:
    path seq

    output:
    path "all.rev"

    script:
    """
    	cat ${seq} | awk '{if (\$1~">") {print \$0} else system("echo " \$0 " |rev")}' > all.rev
    """
}

workflow flow1 {
    take: sequences

    main:
    splitted_seq        = splitSequences(sequences)
    rev_single_seq      = reverseSequence(splitted_seq)
}

workflow flow2 {
    take: sequences

    main:
    splitted_seq        = splitSequences(sequences).flatten()
    rev_single_seq      = reverseSequence(splitted_seq)
}

workflow {
   flow1(sequences_file)
   flow2(sequences_file)
}
