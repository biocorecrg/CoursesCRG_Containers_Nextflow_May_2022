/*
*  fastqc module
*/

params.CONTAINER = "quay.io/biocontainers/fastqc:0.11.9--0"
params.OUTPUT = "fastqc_output"
params.LABEL = ""


process fastqc {
    publishDir(params.OUTPUT, mode: 'copy')
    tag { "${reads}" }
    container params.CONTAINER
    label (params.LABEL)

    input:
    path(reads)

    output:
    path("*_fastqc*")

    script:
    """
        fastqc -t ${task.cpus} ${reads}
    """
}
