.. _nextflow_2-page:

*******************
Nextflow 2
*******************

During this day we will make more complex pipelines and separate the main code from the configuration. Then we will focus on how to reuse and share your code.

.. image:: images/nextflow_logo_deep.png
  :width: 300


Decoupling resources, parameters and nextflow script
=======================

When making a complex pipelines it is convenient to keep the definition of resources needed, the default parameters and the main script separately from each other.
This can be achieved using two additional files:

- nextflow.config
- params.config

The **nextflow.config** file allows to indicate resources needed for each class of processes.
This is achieved labeling processes in the nextflow.config file:

.. code-block:: groovy

	includeConfig "$baseDir/params.config"

	process {
	     memory='0.6G'
	     cpus='1'
	     time='6h'

	     withLabel: 'onecpu'
		{
			memory='0.6G'
			cpus='1'
		}

	}

	process.container = 'biocorecrg/c4lwg-2018:latest'
	singularity.cacheDir = "$baseDir/singularity"


The first row indicates to use the information stored in the **params.config** file (described later). Then follows the definition of the default resources for a process:

.. code-block:: groovy
	process {
	     memory='0.6G'
	     cpus='1'
	     time='6h'
	...

Then we specify resources needed for a class of processes labeled **bigmem** (i.e., the default options will be overridden for these processes):

.. code-block:: groovy

	withLabel: 'bigmem'
	{
		memory='0.7G'
		cpus='1'
	}

In the script **test2.nf file**, there are two processes to run two programs:

- `fastQC <https://www.bioinformatics.babraham.ac.uk/projects/fastqc/>`__ - a tool that calculates a number of quality control metrics on single fastq files;
- `multiQC <https://multiqc.info/>`__ - an aggregator of results from bioinformatics tools and samples for generating a single html report.

You can see that the process **fastQC** is labeled 'bigmem':

.. code-block:: groovy

	/*
	 * Process 1. Run FastQC on raw data.
	 */
	process fastQC {

	    publishDir fastqcOutputFolder
	    tag { "${reads}" }
	    label 'bigmem'

	    input:
	    path reads
	...


The last two rows of the config file indicate which containers to use.
In this example, -- and by default, if the repository is not specified, -- a container is pulled from the DockerHub.
In case of using a singularity container, you can indicate where to store the local image using the **singularity.cacheDir** option:

.. code-block:: groovy

	process.container = 'biocorecrg/c4lwg-2018:latest'
	singularity.cacheDir = "$baseDir/singularity"


Let's now launch the script **test2.nf**.

.. code-block:: console

	cd test2;
	nextflow run test2.nf

	N E X T F L O W  ~  version 20.07.1
	Launching `test2.nf` [distracted_edison] - revision: e3a80b15a2
	BIOCORE@CRG - N F TESTPIPE  ~  version 1.0
	=============================================
	reads                           : /home/ec2-user/git/CoursesCRG_Containers_Nextflow_May_2021/nextflow/nextflow/test2/../testdata/*.fastq.gz
	executor >  local (2)
	[df/2c45f2] process > fastQC (B7_input_s_chr19.fastq.gz) [  0%] 0 of 2
	[-        ] process > multiQC                            -
	Error executing process > 'fastQC (B7_H3K4me1_s_chr19.fastq.gz)'

	Caused by:
	  Process `fastQC (B7_H3K4me1_s_chr19.fastq.gz)` terminated with an error exit status (127)

	Command executed:

	  fastqc B7_H3K4me1_s_chr19.fastq.gz

	Command exit status:
	  127

	executor >  local (2)
	[df/2c45f2] process > fastQC (B7_input_s_chr19.fastq.gz) [100%] 2 of 2, failed: 2 ✘
	[-        ] process > multiQC                            -
	Error executing process > 'fastQC (B7_H3K4me1_s_chr19.fastq.gz)'

	Caused by:
	  Process `fastQC (B7_H3K4me1_s_chr19.fastq.gz)` terminated with an error exit status (127)

	Command executed:

	  fastqc B7_H3K4me1_s_chr19.fastq.gz

	Command exit status:
	  127

	Command output:
	  (empty)

	Command error:
	  .command.sh: line 2: fastqc: command not found

	Work dir:
	  /home/ec2-user/git/CoursesCRG_Containers_Nextflow_May_2021/nextflow/nextflow/test2/work/c5/18e76b2e6ffd64aac2b52e69bedef3

	Tip: when you have fixed the problem you can continue the execution adding the option `-resume` to the run command line


We will get a number of errors since no executable is found in our environment / path. This is because the executables are stored in our docker image and we have to tell Nextflow to use the docker image, using the `-with-docker` parameter.


.. code-block:: console

	nextflow run test2.nf -with-docker

	nextflow run test2.nf -with-docker
	N E X T F L O W  ~  version 20.07.1
	Launching `test2.nf` [boring_hamilton] - revision: e3a80b15a2
	BIOCORE@CRG - N F TESTPIPE  ~  version 1.0
	=============================================
	reads                           : /home/ec2-user/git/CoursesCRG_Containers_Nextflow_May_2021/nextflow/nextflow/test2/../testdata/*.fastq.gz
	executor >  local (3)
	[22/b437be] process > fastQC (B7_H3K4me1_s_chr19.fastq.gz) [100%] 2 of 2 ✔
	[1a/cfe63b] process > multiQC                              [  0%] 0 of 1
	executor >  local (3)
	[22/b437be] process > fastQC (B7_H3K4me1_s_chr19.fastq.gz) [100%] 2 of 2 ✔
	[1a/cfe63b] process > multiQC                              [100%] 1 of 1 ✔


This time it worked because Nextflow used the image specified in the **nextflow.config** file and containing the executables.

Now let's take a look at the **params.config** file:

.. code-block:: groovy

	params {
		reads		= "$baseDir/../testdata/*.fastq.gz"
		email		= "myemail@google.com"
	}


As you can see, we indicated two pipeline parameters, `reads` and `email`; when running the pipeline, they can be overridden using `\-\-reads` and `\-\-email`.

Now, let's examine the folders generated by the pipeline.

.. code-block:: console

	ls  work/2a/22e3df887b1b5ac8af4f9cd0d88ac5/

	total 0
	drwxrwxr-x 3 ec2-user ec2-user  26 Apr 23 13:52 .
	drwxr-xr-x 2 root     root     136 Apr 23 13:51 multiqc_data
	drwxrwxr-x 3 ec2-user ec2-user  44 Apr 23 13:51 ..


We observe that Docker runs as "root". This can be problematic and generates security issues. To avoid this we can add this line of code within the process section of the config file:

.. code-block:: groovy

	containerOptions = { workflow.containerEngine == "docker" ? '-u $(id -u):$(id -g)': null}


This will tell Nextflow that if it is run with Docker, it has to produce files that belong to a user rather than the root.

Publishing final results
========================

The script **test2.nf** generates two new folders, **output_fastqc** and **output_multiQC**, that contain the result of the pipeline output.
We can indicate which process and output can be considered the final output of the pipeline using the **publishDir** directive that has to be specified at the beginning of a process.

In our pipeline we define these folders here:

.. code-block:: groovy

	/*
 	 * Defining the output folders.
 	 */

	fastqcOutputFolder    = "output_fastqc"
	multiqcOutputFolder   = "output_multiQC"

	[...]

	/*
	 * Process 1. Run FastQC on raw data. A process is the element for executing scripts / programs etc.
	 */

	process fastQC {
	    publishDir fastqcOutputFolder  			// where (and whether) to publish the results

	[...]

	/*
	 * Process 2. Run multiQC on fastQC results
	 */

	process multiQC {
	    publishDir multiqcOutputFolder, mode: 'copy' 	// this time do not link but copy the output file


You can see that the default mode to publish the results in Nextflow is soft linking. You can change this behaviour specifying the mode as indicated in the **multiQC** process.

**IMPORTANT: You can also "move" the results but this is not suggested for files that will be needed for other processes. This will likely disrupt your pipeline.**

To access the output files via the web they can be copied to your `S3 bucket <https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingBucket.html>`__ . Your bucket is mounted in **/mnt**:

.. code-block:: console

	ls /mnt

	/mnt/class-bucket-1



**Note:** In this class, each student has its own bucket, with the number correponding to the number of the AWS instance.

Let's copy the **multiqc_report.html** file in the S3 bucket and change the privileges:

.. code-block:: console

	cp output_multiQC/multiqc_report.html /mnt/class-bucket-1

	sudo chmod 775 /mnt/class-bucket-1/multiqc_report.html


Now you will be able to see this html file via the browser (change the bucket number to correspond to your instance):

.. code-block:: console

	http://class-bucket-1.s3.eu-central-1.amazonaws.com/multiqc_report.html





Adding help section to a pipeline
=============================================

Here we describe another good practice: the use of the `\-\-help` parameter. At the beginning of the pipeline we can write:

.. code-block:: groovy

	params.help             = false    // this prevents a warning of undefined parameter

	// this prints the input parameters
	log.info """
	BIOCORE@CRG - N F TESTPIPE  ~  version ${version}
	=============================================
	reads                           : ${params.reads}
	"""

	// this prints the help in case you use --help parameter in the command line and it stops the pipeline
	if (params.help) {
	    log.info 'This is the Biocore\'s NF test pipeline'
	    log.info 'Enjoy!'
	    log.info '\n'
	    exit 1
	}

so that launching the pipeline with `\-\-help` will show you just the parameters and the help.

.. code-block:: console

	nextflow run test2.nf --help

	N E X T F L O W  ~  version 20.07.1
	Launching `test2.nf` [mad_elion] - revision: e3a80b15a2
	BIOCORE@CRG - N F TESTPIPE  ~  version 1.0
	=============================================
	reads                           : /home/ec2-user/git/CoursesCRG_Containers_Nextflow_May_2021/nextflow/nextflow/test2/../testdata/*.fastq.gz
	This is the Biocore's NF test pipeline
	Enjoy!

EXERCISE
===============

- Look at the very last EXERCISE of the day before. Change the script and the config file using the label for handling failing processes.

.. raw:: html

   <details>
   <summary><a>Solution</a></summary>

The process should become:

.. code-block:: groovy

	process reverseSequence {

	    tag { "${seq}" }
	    publishDir "output"
	    label 'ignorefail'

	    input:
	    path seq

	    output:
	    path "all.rev"

	    script:
	    """
	    cat ${seq} | AAAAA '{if (\$1~">") {print \$0} else system("echo " \$0 " |rev")}' > all.rev
	    """
	}


and the nextflow.config file would become:

.. code-block:: groovy

	process {
		withLabel: 'ignorefail'
		{
			errorStrategy = 'ignore'
	    	}
	}


.. raw:: html

   </details>
|
|

- Now look at **test2.nf**.
Change this script and the config file using the label for handling failing processes by retrying 3 times and incrementing time.

You can specify a very low time (5, 10 or 15 seconds) for the fastqc process so it would fail at beginning.

.. raw:: html

   <details>
   <summary><a>Solution</a></summary>


The process should become:

.. code-block:: groovy

	process fastQC {

		publishDir fastqcOutputFolder	// where (and whether) to publish the results
		tag { "${reads}" } 	// during the execution prints the indicated variable for follow-up
		label 'keep_trying'

		input:
		path reads   	// it defines the input of the process. It sets values from a channel

		output:			// It defines the output of the process (i.e. files) and send to a new channel
   		path "*_fastqc.*"

    		script:			// here you have the execution of the script / program. Basically is the command line
    		"""
        	fastqc ${reads}
   		"""
	}


while the nextflow.config file would be:

.. code-block:: groovy

	includeConfig "$baseDir/params.config"


	process {
	     //containerOptions = { workflow.containerEngine == "docker" ? '-u $(id -u):$(id -g)': null}
	     memory='0.6G'
	     cpus='1'
	     time='6h'

	     withLabel: 'keep_trying'
	     {
		time = { 10.second * task.attempt }
		errorStrategy = 'retry'
		maxRetries = 3
	     }
	}

	process.container = 'biocorecrg/c4lwg-2018:latest'
	singularity.cacheDir = "$baseDir/singularity"

.. raw:: html

   </details>
|
|

Using public pipelines
=============================================
As an example, we will use our pipeline `Master Of Pores <https://github.com/biocorecrg/mop2>`__ published in `2019 in Frontiers in Genetics <https://www.frontiersin.org/articles/10.3389/fgene.2020.00211/full>`__ .

This repository contains a collection of pipelines for processing nanopore's raw data (both cDNA and dRNA-seq), detecting putative RNA modifications and estimating RNA polyA tail sizes.

Clone the pipeline together with the submodules. The submodules contain **Nextflow modules** that will be described later.

.. code-block:: console

	git clone --depth 1 --recurse-submodules https://github.com/biocorecrg/MOP2.git

	Cloning into 'MoP2'...
	remote: Enumerating objects: 113, done.
	remote: Counting objects: 100% (113/113), done.
	remote: Compressing objects: 100% (99/99), done.
	remote: Total 113 (delta 14), reused 58 (delta 3), pack-reused 0
	Receiving objects: 100% (113/113), 21.87 MiB | 5.02 MiB/s, done.
	Resolving deltas: 100% (14/14), done.
	Submodule 'BioNextflow' (https://github.com/biocorecrg/BioNextflow) registered for path 'BioNextflow'
	Cloning into '/Users/lcozzuto/aaa/MoP2/BioNextflow'...
	remote: Enumerating objects: 971, done.
	remote: Counting objects: 100% (641/641), done.
	remote: Compressing objects: 100% (456/456), done.
	remote: Total 971 (delta 393), reused 362 (delta 166), pack-reused 330
	Receiving objects: 100% (971/971), 107.51 MiB | 5.66 MiB/s, done.
	Resolving deltas: 100% (560/560), done.
	Submodule path 'BioNextflow': checked out '0473d7f177ce718477b852b353894b71a9a9a08b'


Let's inspect the folder **MoP2**.

.. code-block:: console

	ls MoP2

	BioNextflow		conf			docs			mop_preprocess
	INSTALL.sh		conf.py			img			mop_tail
	README.md		data			local_modules.nf	nextflow.global.config
	TODO.md			deeplexicon		mop_consensus		outdirs.nf
	anno			docker			mop_mod			requirements.txt

There are different pipelines bundled in a single repository: **mop_preprocess**, **mop_mod**, **mop_tail** and **mop_consensus**. Let's inspect the folder **mop_preprocess** that contains the Nextflow pipeline **mop_preprocess.nf**. This pipeline allows to pre-process raw fast5 files that are generated by a Nanopore instruments. Notice the presence of the folder **bin**. This folder contains the number of custom scripts that can be used by the pipeline without storing them inside containers. This provides a practical solution for using programs with restrictive licenses that prevent the code redistribution.

.. code-block:: console

	cd MoP2
	ls mop_preprocess/bin/

	bam2stats.py			fast5_to_fastq.py
	extract_sequence_from_fastq.py	fast5_type.py

The basecaller **Guppy** cannot be redistributed, so we had to add an **INSTALL.sh** script that has to be run by the user for downloading the Guppy executable and placing it inside the **bin** folder.

.. code-block:: console

	sh INSTALL.sh

	INSTALLING GUPPY VERSION 3.4.5
	[...]
	ont-guppy_3.4.5_linux64.tar. 100%[============================================>] 363,86M  5,59MB/s    in 65s

	2021-11-04 18:38:58 (5,63 MB/s) - ‘ont-guppy_3.4.5_linux64.tar.gz’ saved [381538294/381538294]

	x ont-guppy/bin/
	x ont-guppy/bin/guppy_basecall_server
	x ont-guppy/bin/guppy_basecaller
	[...]

We can check what is inside **bin**.

.. code-block:: console

	cd mop_preprocess

	ls bin/

	MINIMAP2_LICENSE			libboost_system.so.1.66.0
	bam2stats.py				libboost_thread.so
	extract_sequence_from_fastq.py		libboost_thread.so.1.66.0
	fast5_to_fastq.py			libcrypto.so
	fast5_type.py				libcrypto.so.1.0.1e
	guppy_aligner				libcrypto.so.10
	guppy_barcoder				libcurl.so
	[...]

It is always a good idea to bundle your pipeline with a little test dataset so that other can test the pipeline once it is installed. This also useful for continuous integration (CI), when each time when a commit to GitHub triggers a test run that sends you an alert in case of failure.
Let's inspect the **params.config** file that points to a small dataset contained in the repository (the **data** and **anno** folders):

.. code-block:: groovy

	params {
	    conffile            = "final_summary_01.txt"
	    fast5               = "$baseDir/../data/**/*.fast5"
	    fastq               = ""

	    reference           = "$baseDir/../anno/curlcake_constructs.fasta.gz"
	    annotation          = ""
	    ref_type            = "transcriptome"

	    pars_tools          = "drna_tool_splice_opt.tsv"
	    output              = "$baseDir/output"
	    qualityqc           = 5
	    granularity         = 1

	    basecalling         = "guppy"
	    GPU                 = "OFF"
	    demultiplexing      = "NO"
	    demulti_fast5       = "NO"

	    filtering           = "NO"

	    mapping             = "minimap2"
	    counting            = "nanocount"
	    discovery           = "NO"

	    cram_conv           = "YES"
	    subsampling_cram    = 50

	    saveSpace           = "NO"

	    email               = ""
	}

Let's now run the pipeline:

.. code-block:: console

	nextflow run mop_preprocess.nf -with-docker -bg > log.txt

	tail -f log.txt

	N E X T F L O W  ~  version 21.04.3
	Launching `mop_preprocess.nf` [adoring_allen] - revision: 7457956da7


	╔╦╗╔═╗╔═╗  ╔═╗┬─┐┌─┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐┌─┐
	║║║║ ║╠═╝  ╠═╝├┬┘├┤ ├─┘├┬┘│ ││  ├┤ └─┐└─┐
	╩ ╩╚═╝╩    ╩  ┴└─└─┘┴  ┴└─└─┘└─┘└─┘└─┘└─┘

	====================================================
	BIOCORE@CRG Master of Pores 2. Preprocessing - N F  ~  version 2.0
	====================================================

	conffile	          : final_summary_01.txt

	fast5                     : /Users/lcozzuto/aaa/MoP2/mop_preprocess/../data/**/*.fast5
	fastq                     :

	reference                 : /Users/lcozzuto/aaa/MoP2/mop_preprocess/../anno/curlcake_constructs.fasta.gz
	annotation                :

	granularity		  : 1

	ref_type                  : transcriptome
	pars_tools		  : drna_tool_splice_opt.tsv

	output                    : /Users/lcozzuto/aaa/MoP2/mop_preprocess/output
	qualityqc                 : 5

	GPU                       : OFF

	basecalling               : guppy
	demultiplexing            : NO
	demulti_fast5		  : NO

	filtering                 : NO
	mapping                   : minimap2

	counting                  : nanocount
	discovery		  : NO

	cram_conv           	  : YES
	subsampling_cram	  : 50


	saveSpace   		  : NO

	email                     :

	Skipping the email

	----------------------CHECK TOOLS -----------------------------
	basecalling : guppy
	> demultiplexing will be skipped
	mapping : minimap2
	> filtering will be skipped
	counting : nanocount
	> discovery will be skipped
	--------------------------------------------------------------
	[bd/bd8dcf] Submitted process > preprocess_flow:checkRef (Checking curlcake_constructs.fasta.gz)
	[7a/1d2244] Submitted process > FILTER_VER:getVersion
	[26/dbd3f2] Submitted process > GRAPHMAP_VER:getVersion
	[11/84981d] Submitted process > BWA_VER:getVersion
	[03/2b6939] Submitted process > DEMULTIPLEX_VER:getVersion
	[38/ec6382] Submitted process > BAMBU_VER:getVersion
	[63/a2a072] Submitted process > SAMTOOLS_VERSION:getVersion
	[75/0a1e9e] Submitted process > NANOPLOT_VER:getVersion
	[4f/b50c2a] Submitted process > MULTIQC_VER:getVersion
	[7c/de96a4] Submitted process > NANOCOUNT_VER:getVersion
	[79/a56c5f] Submitted process > GRAPHMAP2_VER:getVersion
	[14/b52ead] Submitted process > HTSEQ_VER:getVersion
	[60/aaad30] Submitted process > MINIMAP2_VER:getVersion
	[de/7077d4] Submitted process > FASTQC_VER:getVersion
	[18/403b7d] Submitted process > flow1:GUPPY_BASECALL:baseCall (multifast---1)
	[f8/8973d4] Submitted process > preprocess_flow:MINIMAP2:map (multifast---1)
	[8e/d31464] Submitted process > preprocess_flow:concatenateFastQFiles (multifast)
	[1e/37d8c5] Submitted process > preprocess_flow:MinIONQC (multifast)
	[d3/eafd5e] Submitted process > preprocess_flow:FASTQC:fastQC (multifast.fq.gz)
	[fb/a1a7ca] Submitted process > preprocess_flow:SAMTOOLS_CAT:catAln (multifast)
	[3b/ee710f] Submitted process > preprocess_flow:SAMTOOLS_SORT:sortAln (multifast)
	[19/172450] Submitted process > preprocess_flow:bam2stats (multifast)
	[bc/9bc0d6] Submitted process > preprocess_flow:AssignReads (multifast)
	[b8/d65861] Submitted process > preprocess_flow:NANOPLOT_QC:MOP_nanoPlot (multifast)
	[cc/5d50c4] Submitted process > preprocess_flow:SAMTOOLS_INDEX:indexBam (multifast)
	[ce/990016] Submitted process > preprocess_flow:NANOCOUNT:nanoCount (multifast)
	[3a/27a47a] Submitted process > preprocess_flow:countStats (multifast)
	[96/c53238] Submitted process > preprocess_flow:joinAlnStats (joining aln stats)
	[93/7de48e] Submitted process > preprocess_flow:bam2Cram (multifast)
	[8e/3c1454] Submitted process > preprocess_flow:joinCountStats (joining count stats)
	[a9/c6149b] Submitted process > preprocess_flow:MULTIQC:makeReport
	Pipeline BIOCORE@CRG Master of Pore - preprocess completed!
	Started at  2021-11-04T19:08:12.706+01:00
	Finished at 2021-11-04T19:11:54.580+01:00
	Time elapsed: 3m 42s
	Execution status: OK


EXERCISE
------------------

- Look at the documentation of `Master Of Pores <https://github.com/biocorecrg/mop2>`__ and change the default mapper, skip the filtering and enable the demultiplexing.

.. raw:: html

   <details>
   <summary><a>Solution</a></summary>

The params can be set on the fly like this

.. code-block:: console

	nextflow run mop_preprocess.nf -with-docker -bg --mapping graphmap --filtering nanofilt --demultiplexing deeplexicon > log.txt


.. raw:: html

   </details>
|
|

Using Singularity
=======================

We recommend to use Singularity instead of Docker in a HPC environments.
This can be done using the Nextflow parameter `-with-singularity` without changing the code.

Nextflow will take care of **pulling, converting and storing the image** for you. This will be done only once and then Nextflow will use the stored image for further executions.

Within an AWS main node both Docker and Singularity are available. While within the AWS batch system only Docker is available.

.. code-block:: console
	nextflow run test2.nf -with-singularity -bg > log

		tail -f log
		N E X T F L O W  ~  version 20.10.0
		Launching `test2.nf` [soggy_miescher] - revision: 5a0a513d38

	BIOCORE@CRG - N F TESTPIPE  ~  version 1.0
	=============================================
	reads                           : /home/ec2-user/git/CoursesCRG_Containers_Nextflow_May_2021/nextflow/test2/../../testdata/*.fastq.gz

	Pulling Singularity image docker://biocorecrg/c4lwg-2018:latest [cache /home/ec2-user/git/CoursesCRG_Containers_Nextflow_May_2021/nextflow/test2/singularity/biocorecrg-c4lwg-2018-latest.img]
	[da/eb7564] Submitted process > fastQC (B7_H3K4me1_s_chr19.fastq.gz)
	[f6/32dc41] Submitted process > fastQC (B7_input_s_chr19.fastq.gz)
	...


Let's inspect the folder `singularity`:

.. code-block:: console

	ls singularity/
	biocorecrg-c4lwg-2018-latest.img


This singularity image can be used to execute the code outside the pipeline **exactly the same way** as inside the pipeline.

Sometimes we can be interested in launching only a specific job, because it might failed or for making a test. For that, we can go to the corresponding temporary folder; for example, one of the fastQC temporary folders:

.. code-block:: console

	cd work/da/eb7564*/


Inspecting the `.command.run` file shows us this piece of code:

.. code-block:: groovy

	...

	nxf_launch() {
	    set +u; env - PATH="$PATH" SINGULARITYENV_TMP="$TMP" SINGULARITYENV_TMPDIR="$TMPDIR" singularity exec /home/ec2-user/git/CoursesCRG_Containers_Nextflow_May_2021/nextflow/test2/singularity/biocorecrg-c4lwg-2018-latest.img /bin/bash -c "cd $PWD; /bin/bash -ue /home/ec2-user/git/CoursesCRG_Containers_Nextflow_May_2021/nextflow/test2/work/da/eb756433aa0881d25b20afb5b1366e/.command.sh"
	}
	...


This means that Nextflow is running the code by using the **singularity exec** command.

Thus we can launch this command outside the pipeline (locally):

.. code-block:: console

	bash .command.run

	Started analysis of B7_H3K4me1_s_chr19.fastq.gz
	Approx 5% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 10% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 15% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 20% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 25% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 30% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 35% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 40% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 45% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 50% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 55% complete for B7_H3K4me1_s_chr19.fastq.gz
	Approx 60% complete for B7_H3K4me1_s_chr19.fastq.gz
	...

If you have to submit a job to a HPC you need to use the corresponding program, **qsub** or **sbatch**.

.. code-block:: console

	qsub .command.run
