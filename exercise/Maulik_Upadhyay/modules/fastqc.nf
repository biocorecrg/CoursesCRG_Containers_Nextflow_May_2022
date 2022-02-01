/*
*  fastqc module
*/

params.CONTAINER = "quay.io/biocontainers/fastqc:0.11.9--0"
//params.CONTAINER = "/home/maulik/data/Shared/tools/containers/fastqc_v0.11.9.sif"
params.OUTPUT = "fastqc_output"

process fastqc {
    publishDir(params.OUTPUT, mode: 'copy')
    tag { "${reads}" }
    container params.CONTAINER
    //singularity.enabled = true

    input:
    path(reads)

    output:
    path("*_fastqc*")

    script:
    """
        fastqc ${reads}
    """
}
