/*
*  fastqc module
*/

params.CONTAINER = "quay.io/biocontainers/fastqc:0.11.9--0"
params.OUTPUT = "fastqc_output"

process fastqc {
    publishDir(params.OUTPUT, mode: 'copy')
    tag { "${reads}" }
    container params.CONTAINER

    input:
    path(reads)

    output:
    path("*_fastqc*")

    script:
    """
        fastqc ${reads}
    """
}
