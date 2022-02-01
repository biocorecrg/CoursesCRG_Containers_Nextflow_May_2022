GRADING EXERCISE 
================

Make a pipeline that does the following:

- Aligns reads in fastq files (there are two files from a ChIP-seq experiment) in the folder `testdata <https://github.com/biocorecrg/SIB_course_nextflow_Nov_2021/tree/main/testdata/>`__ using Bowtie (as in the course exercises) to the chr19 (file chr19.fasta.gz).
- Runs FastQC on the fastq files and the files produced in the result of the read alignment.
- Calls ChIP-seq peaks for the produced alignments using the MACS2 software (`here is the official container <https://hub.docker.com/r/fooliu/macs2>`__).



(Optional) Make a more complex pipeline that does all the above plus:

- Allows optional (as a parameter) read alignment using Bowtie, Bowtie2 or BWA.
- Compares the number of called peaks for different alignment programs.
- Compares required computational resources and execution time for running the pipeline (all or/and only alignment) for different alignment programs.




Email your full solution (we should be able to run your pipeline) at `BioinformaticsUnit@crg.eu` or, better, do a pull request in this repository. Please use your First and Second name in the name of your folder. 

Deadline: 28 November 2021 23:59
