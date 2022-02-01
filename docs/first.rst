.. _first-page:

*******************
First Day
*******************

Introduction to Linux containers.
=================================

What are containers?
---------------------

.. image:: https://www.synopsys.com/blogs/software-security/wp-content/uploads/2018/04/containers-rsa.jpg
  :width: 700

A Container can be seen as a **minimal virtual environment** that can be used in any Linux-compatible machine (and beyond).

Using containers is time- and resource-saving as they allow:

* Controlling for software installation and dependencies.
* Reproducibility of the analysis.

Containers allow us to use **exactly the same versions of the tools**.

Virtual machines or containers ?
----------------------------------

=====================================================  =====================================================
Virtualisation                                         Containerisation (aka lightweight virtualisation)
=====================================================  =====================================================
Abstraction of physical hardware                       Abstraction of application layer
Depends on hypervisor (software)                       Depends on host kernel (OS)
Do not confuse with hardware emulator                  Application and dependencies bundled all together
Enable virtual machines                                Every virtual machine with an OS (Operating System)
=====================================================  =====================================================


Virtualisation
----------------------------------

* Abstraction of physical hardware
* Depends on hypervisor (software)
* Do not confuse with hardware emulator
* Enable virtual machines:
	* Every virtual machine with an OS (Operating System)

Containerisation (aka lightweight virtualisation)
-------------------------------------------------

* Abstraction of application layer
* Depends on host kernel (OS)
* Application and dependencies bundled all together

Virtual machines vs containers
----------------------------------------

.. image:: https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/vm-docker5.png
  :width: 800

`Source <https://dockerlabs.collabnix.com/beginners/difference-docker-vm.html>`__


**Pros and cons**

===== ===================================================== =====================================================
ADV   Virtualisation                                        Containerisation
===== ===================================================== =====================================================
PROS. * Very similar to a full OS.     			     * No need of full OS installation (less space).
      * High OS diversity       			     * Better portability
      							     * Faster than virtual machines.
							     * Easier automation.
							     * Easier distribution of recipes.
							     * Better portability.

      
CONS. * Need more space and resources.                       * Some cases might not be exactly the same as a full OS.
      * Slower than containers.                              * Still less OS diversity, even with current solutions
      * Not that good automation.
===== ===================================================== =====================================================


History of containers
----------------------

**chroot**

* chroot jail (BSD jail): first concept in 1979
* Notable use in SSH and FTP servers
* Honeypot, recovery of systems, etc.

.. image:: https://sysopsio.files.wordpress.com/2016/09/linux-chroot-jail.png
  :width: 550

**Additions in Linux kernel**

* First version: 2008
* cgroups (control groups), before "process containers"
	* isolate resource usage (CPU, memory, disk I/O, network, etc.) of a collection of processes
* Linux namespaces
	* one set of kernel resources restrict to one set of processes

.. image:: images/linux-vs-docker-comparison-architecture-docker-lxc.png
  :width: 600

Introduction to Docker
========================

.. image:: https://connpass-tokyo.s3.amazonaws.com/thumbs/80/52/80521f18aec0945dfedbb471dad6aa1a.png
  :width: 400


What is Docker?
-------------------

* Platform for developing, shipping and running applications.
* Infrastructure as application / code.
* First version: 2013.
* Company: originally dotCloud (2010), later named Docker.
* Established [Open Container Initiative](https://www.opencontainers.org/).

As a software:

* `Docker Community Edition <https://www.docker.com/products/container-runtime>`__.
* Docker Enterprise Edition.

There is an increasing number of alternative container technologies and providers. Many of them are actually based on software components originally from the Docker stack and they normally try to address some specific use cases or weakpoints. As a example, **Singularity**, that we introduce later in this couse, is focused in HPC environments. Another case, **Podman**, keeps a high functional compatibility with Docker but with a different focus on technology (not keeping a daemon) and permissions.


Docker components
--------------------

.. image:: http://apachebooster.com/kb/wp-content/uploads/2017/09/docker-architecture.png
  :width: 700

* Read-only templates.
* Containers are run from them.
* Images are not run.
* Images have several layers.

.. image:: https://i.stack.imgur.com/vGuay.png
  :width: 700

Images versus containers
----------------------------

* **Image**: A set of layers, read-only templates, inert.
* An instance of an image is called a **container**.

When you start an image, you have a running container of this image. You can have many running containers of the same image.

*"The image is the recipe, the container is the cake; you can make as many cakes as you like with a given recipe."*

https://stackoverflow.com/questions/23735149/what-is-the-difference-between-a-docker-image-and-a-container

.. image:: images/singularity_logo.svg
  :width: 300

Introduction to Singularity
=============================


* Focus:
	* Reproducibility to scientific computing and the high-performance computing (HPC) world.
* Origin: Lawrence Berkeley National Laboratory. Later spin-off: Sylabs
* Version 1.0 -> 2016
* More information: `https://en.wikipedia.org/wiki/Singularity_(software) <https://en.wikipedia.org/wiki/Singularity_(software)>`__

Singularity architecture
---------------------------

.. image:: images/singularity_architecture.png
  :width: 800


===================================================== =====================================================
Strengths                                             Weaknesses
===================================================== =====================================================
No dependency of a daemon                             At the time of writing only good support in Linux
Can be run as a simple user                           Mac experimental. Desktop edition. Only running
Avoids permission headaches and hacks                 For some features you need root account (or sudo)
Image/container is a file (or directory)
More easily portable

Two types of images: Read-only (production)
Writable (development, via sandbox)

===================================================== =====================================================

**Trivia**

Nowadays, there may be some confusion since there are two projects:

* `HPCng Singularity <https://singularity.hpcng.org/>`__
* `Sylabs Singularity <https://sylabs.io/singularity/>`__

They "forked" not long ago. So far they share most of the codebase, but eventually this might be different, and software might have different functionality.

Container registries
====================

Container images, normally different versions of them, are stored in container repositories.

These repositories can be browser or discovered within, normally public, container registries.

**Docker Hub**

It is the first and most popular public container registry (which provides also private repositories).

* `Docker Hub <https://hub.docker.com>`__

Example:

`https://hub.docker.com/r/biocontainers/fastqc <https://hub.docker.com/r/biocontainers/fastqc>`__

.. code-block:: console

	singularity build fastqc-0.11.9_cv7.sif docker://biocontainers/fastqc:v0.11.9_cv7


**Biocontainers**

* `Biocontainers <https://biocontainers.pro>`__

Website gathering Bioinformatics focused container images from different registries.

Originally Docker Hub was used, but now other registries are preferred.

Example: `https://biocontainers.pro/tools/fastqc <https://biocontainers.pro/tools/fastqc>`__

*Via quay.io*

`https://quay.io/repository/biocontainers/fastqc <https://quay.io/repository/biocontainers/fastqc)>`__

.. code-block:: console

	singularity build fastqc-0.11.9.sif docker://quay.io/biocontainers/fastqc:0.11.9--0


*Via Galaxy project prebuilt images*

.. code-block:: console

	singularity pull --name fastqc-0.11.9.sif https://depot.galaxyproject.org/singularity/fastqc:0.11.9--0


Galaxy project provides all Bioinformatics software from the BioContainers initiative as Singularity prebuilt images. If download and conversion time of images is an issue, this might be the best option for those working in the biomedical field.


Running and executing containers
--------------------------------

Once we have some image files (or directories) ready, we can run processes.

**Singularity shell**

The straight-forward exploratory approach is equivalent to ``docker run -ti biocontainers/fastqc:v0.11.9_cv7 /bin/shell`` but with a more handy syntax.

.. code-block:: console

	singularity shell fastqc-0.11.9.sif


Move around the directories and notice how the isolation approach is different in comparison to Docker. You can access most of the host filesystem.

**Singularity exec**

That is the most common way to execute Singularity (equivalent to ``docker exec``). That would be the normal approach in a HPC environment.

.. code-block:: console

    singularity exec fastqc-0.11.9.sif fastqc

Test a processing of a file from *testdata* directory:

.. code-block:: console

    singularity exec fastqc-0.11.9_cv7.sif fastqc B7_input_s_chr19.fastq.gz


**Singularity run**

This executes runscript from recipe definition (equivalent to ``docker run``). Not so common for HPC uses. More common for instances (servers).

.. code-block:: console

    singularity run fastqc-0.11.9.sif


**Environment control**

By default Singularity inherits a profile environment (e.g., PATH environment variable). This may be convenient in some circumstances, but it can also lead to unexpected problems when your own environment clashes with the default one from the image.

.. code-block:: console

    singularity shell -e fastqc-0.11.9.sif
    singularity exec -e fastqc-0.11.9.sif fastqc
    singularity run -e fastqc-0.11.9.sif


Compare ``env`` command with and without -e modifier.

.. code-block:: console

    singularity exec fastqc-0.11.9.sif env
    singularity exec -e fastqc-0.11.9.sif env

**Exercise**

* Generate a Singularity image of the last *samtools* version
	* Consider and compare different registry sources
* Explore the inside contents of the image
* Execute in different ways ``samtools`` program (e. g., using *fqidx* option)


Introduction to Nextflow
========================
DSL for data-driven computational pipelines. `www.nextflow.io <https://www.nextflow.io>`_.

.. image:: images/nextflow_logo_deep.png
  :width: 400


What is Nextflow?
-----------------

.. image:: images/nextf_groovy.png
  :width: 600

`Nextflow <https://www.nextflow.io>`__ is a domain specific language (DSL) for workflow orchestration that stems from `Groovy <https://groovy-lang.org/>`__. It enables scalable and reproducible workflows using software containers.
It was developed at the `CRG <www.crg.eu>`__ in the Lab of Cedric Notredame by `Paolo Di Tommaso <https://github.com/pditommaso>`__.
The Nextflow documentation is `available here <https://www.nextflow.io/docs/latest/>`__ and you can ask help to the community using their `gitter channel <https://gitter.im/nextflow-io/nextflow>`__

In 2020, Nextflow has been upgraded from DSL1 version to DSL2. In this course we will use exclusively DSL2.

What is Nextflow for?
---------------------

It is for making pipelines without caring about parallelization, dependencies, intermediate file names, data structures, handling exceptions, resuming executions, etc.

It was published in `Nature Biotechnology in 2017 <https://pubmed.ncbi.nlm.nih.gov/28398311/>`__.

.. image:: images/NF_pub.png
  :width: 600


There is a growing number of `PubMed <https://pubmed.ncbi.nlm.nih.gov/?term=nextflow&timeline=expanded&sort=pubdate&sort_order=asc>`__ publications citing Nextflow.

.. image:: images/NF_mentioning.png
  :width: 600


A curated list of `Nextflow pipelines <https://github.com/nextflow-io/awesome-nextflow>`__.

Many pipelines written collaboratively are provided by the `NF-core <https://nf-co.re/pipelines>`__ project.

Some pipelines written in Nextflow have been used for the SARS-Cov-2 analysis, for example:

- The `artic Network <https://artic.network/ncov-2019>`__ pipeline `ncov2019-artic-nf <https://github.com/connor-lab/ncov2019-artic-nf>`__.
- The `CRG / EGA viral Beacon <https://covid19beacon.crg.eu/info>`__ pipeline `Master of Pores <https://github.com/biocorecrg/master_of_pores>`__.
- The nf-core pipeline `viralrecon <https://nf-co.re/viralrecon>`__.


Main advantages
----------------


- **Fast prototyping**

You can quickly write a small pipeline that can be **expanded incrementally**.
**Each task is independent** and can be easily added to other. You can reuse scripts without re-writing or adapting them.

- **Reproducibility**

Nextflow supports **Docker** and **Singularity** containers technology. Their use will make the pipelines reproducible in any Unix environment. Nextflow is integrated with **GitHub code sharing platform**, so you can call directly a specific version of a pipeline from a repository, download and use it on-the-fly.

- **Portability**

Nextflow can be executed on **multiple platforms** without modifiying the code. It supports several schedulers such as **SGE, LSF, SLURM, PBS, HTCondor** and cloud platforms like **Kubernetes, Amazon AWS, Google Cloud**.


.. image:: images/executors.png
  :width: 600

- **Scalability**

Nextflow is based on the **dataflow programming model** which simplifies writing complex pipelines.
The tool takes care of **parallelizing the processes** without additionally written code.
The resulting applications are inherently parallel and can scale-up or scale-out transparently; there is no need to adapt them to a specific platform architecture.

- **Resumable, thanks to continuous checkpoints**

All the intermediate results produced during the pipeline execution are automatically tracked.
For each process **a temporary folder is created and is cached (or not) once resuming an execution**.

Workflow structure
==================

The workflows can be represented as graphs where the nodes are the **processes** and the edges are the **channels**.
The **processes** are blocks of code that can be executed - such as scripts or programs - while the **channels** are asynchronous queues able to **connect processes among them via input / output**.


.. image:: images/wf_example.png
  :width: 600


Processes are independent from each another and can be run in parallel, depending on the number of elements in a channel.
In the previous example, processes **A**, **B** and **C** can be run in parallel and only when they **ALL** end the process **D** is triggered.

Installation
============

.. note::
  Nextflow is already installed on the machines provided for this course.
  You need at least the Java version 8 for the Nextflow installation.

.. tip::
  You can check the version fo java by typing::

    java -version

Then we can install Nextflow with::

  curl -s https://get.nextflow.io | bash

This will create the ``nextflow`` executable that can be moved, for example, to ``/usr/local/bin``.

We can test that the installation was successful with:

.. code-block:: console

  nextflow run hello

  N E X T F L O W  ~  version 20.07.1
  Pulling nextflow-io/hello ...
  downloaded from https://github.com/nextflow-io/hello.git
  Launching `nextflow-io/hello` [peaceful_brahmagupta] - revision: 96eb04d6a4 [master]
  executor >  local (4)
  [d7/d053b5] process > sayHello (4) [100%] 4 of 4 ✔
  Ciao world!
  Bonjour world!
  Hello world!
  Hola world!


This command downloads and runs the pipeline ``hello``.

We can now launch a test pipeline:

.. code-block:: console

  nextflow run nextflow-io/rnaseq-nf -with-singularity

This command will automatically pull the pipeline and the required test data from the `github repository <https://github.com/nextflow-io/rnatoy>`__
The command ``-with-singularity`` will automatically trigger the download of the image ``nextflow/rnatoy:1.3`` from DockerHub and convert it on-the-fly into a singularity image that will be used for running each step of the pipeline.
The pipeline can also recognize the queue system which is used on the machine where it is launched. In the following examples, I launched the same pipeline both on the CRG high performance computing (HPC) cluster and on my MacBook:

The result from CRG HPC:

.. code-block:: console

	nextflow run nextflow-io/rnaseq-nf -with-singularity

	N E X T F L O W  ~  version 21.04.3
	Pulling nextflow-io/rnaseq-nf ...
	downloaded from https://github.com/nextflow-io/rnaseq-nf.git
	Launching `nextflow-io/rnaseq-nf` [serene_wing] - revision: 83bdb3199b [master]
	R N A S E Q - N F   P I P E L I N E
	 ===================================
	transcriptome: /users/bi/lcozzuto/.nextflow/assets/nextflow-io/rnaseq-nf/data/ggal/ggal_1_48850000_49020000.Ggal71.500bpflank.fa
	reads        : /users/bi/lcozzuto/.nextflow/assets/nextflow-io/rnaseq-nf/data/ggal/*_{1,2}.fq
	outdir       : results

	[-        ] process > RNASEQ:INDEX  -
	[-        ] process > RNASEQ:FASTQC -
	executor >  crg (6)
	[cc/dd76f0] process > RNASEQ:INDEX (ggal_1_48850000_49020000) [100%] 1 of 1 ✔
	[7d/7a96f2] process > RNASEQ:FASTQC (FASTQC on ggal_liver)    [100%] 2 of 2 ✔
	[ab/ac8558] process > RNASEQ:QUANT (ggal_gut)                 [100%] 2 of 2 ✔
	[a0/452d3f] process > MULTIQC                                 [100%] 1 of 1 ✔

	Pulling Singularity image docker://quay.io/nextflow/rnaseq-nf:v1.0 [cache /nfs/users2/bi/lcozzuto/aaa/work/singularity/quay.io-nextflow-rnaseq-nf-v1.0.img]
	WARN: Singularity cache directory has not been defined -- Remote image will be stored in the path: /nfs/users2/bi/lcozzuto/aaa/work/singularity -- Use env  variable NXF_SINGULARITY_CACHEDIR to specify a different location
		Done! Open the following report in your browser --> results/multiqc_report.html

	Completed at: 01-Oct-2021 12:01:50
	Duration    : 3m 57s
	CPU hours   : (a few seconds)
	Succeeded   : 6


The result from my MacBook:

.. code-block:: console

	nextflow run nextflow-io/rnaseq-nf -with-docker

	N E X T F L O W  ~  version 21.04.3
	Launching `nextflow-io/rnaseq-nf` [happy_torvalds] - revision: 83bdb3199b [master]
	R N A S E Q - N F   P I P E L I N E
	===================================
	transcriptome: /Users/lcozzuto/.nextflow/assets/nextflow-io/rnaseq-nf/data/ggal/ggal_1_48850000_49020000.Ggal71.500bpflank.fa
	reads        : /Users/lcozzuto/.nextflow/assets/nextflow-io/rnaseq-nf/data/ggal/*_{1,2}.fq
	outdir       : results

	executor >  local (6)
	[37/933971] process > RNASEQ:INDEX (ggal_1_48850000_49020000) [100%] 1 of 1 ✔
	[fe/b06693] process > RNASEQ:FASTQC (FASTQC on ggal_gut)      [100%] 2 of 2 ✔
	[73/84b898] process > RNASEQ:QUANT (ggal_gut)                 [100%] 2 of 2 ✔
	[f2/917905] process > MULTIQC                                 [100%] 1 of 1 ✔

	Done! Open the following report in your browser --> results/multiqc_report.html
