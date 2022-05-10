/*
*  multiqc module
*/

params.CONTAINER = "quay.io/biocontainers/multiqc:1.9--pyh9f0ad1d_0"
params.OUTPUT = "multiqc_output"

process multiqc {
    publishDir(params.OUTPUT, mode: 'copy')
    container params.CONTAINER

    input:
    path (inputfiles)

    output:
    path "multiqc_report.html"

    script:
    """
    multiqc .
    """
}
