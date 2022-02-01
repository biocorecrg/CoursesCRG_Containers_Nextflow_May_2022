/*
*  multiqc module
*/

params.CONTAINER = "quay.io/biocontainers/multiqc:1.9--pyh9f0ad1d_0"
params.OUTPUT = "multiqc_output"
params.LABEL = ""

process multiqc {
    publishDir(params.OUTPUT, mode: 'copy')
    container params.CONTAINER
    label (params.LABEL)

    input:
    path (inputfiles)

    output:
    path "multiqc_report.html"

    script:
    """
    multiqc .
    """
}
