/*
*  macs2 module
*/

params.CONTAINER = "fooliu/macs2:latest"
params.OUTPUT = "macs2_output"

process macs2CallPeak {
    publishDir(params.OUTPUT, mode: 'copy')
    tag { "${samFile}" }
    container params.CONTAINER

    input:
    path(samFile)

    output:
    path("*${samFile}.log")

    script:
    """
        macs2 callpeak -t ${samFile} -f SAM --nomodel 2> ${samFile}.log
    """
}

workflow macs2{
    take:
        samFile

    main:
        macs2CallPeak(samFile)

}


