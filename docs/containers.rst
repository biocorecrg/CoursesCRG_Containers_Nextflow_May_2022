.. _first-page:

*******************
Containers
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

The former will end up being named **Apptainer**, and it is currently supported by the Linux Foundation.

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


**Bind paths (aka volumes)**

Paths of host system mounted in the container

* Default ones, no need to mount them explicitly (for 3.6.x): ```$HOME``` , ```/sys:/sys``` , ```/proc:/proc```, ```/tmp:/tmp```, ```/var/tmp:/var/tmp```, ```/etc/resolv.conf:/etc/resolv.conf```, ```/etc/passwd:/etc/passwd```, and ```$PWD``` [https://sylabs.io/guides/3.6/user-guide/bind_paths_and_mounts.html](https://sylabs.io/guides/3.6/user-guide/bind_paths_and_mounts.html)

For others, need to be done explicitly (syntax: host:container)

.. code-block:: console

    mkdir testdir
    touch testdir/testout
    singularity shell -e -B ./testdir:/scratch fastqc-0.11.9.sif
    > touch /scratch/testin
    > exit
    ls -l testdir


**Singularity recipes**

-Docker bootstrap

.. code-block:: console

  BootStrap: docker
  From: biocontainers/fastqc:v0.11.9_cv7

  %runscript
      echo "Welcome to FastQC Image"
      fastqc --version

  %post
      echo "Image built"


.. code-block:: console

    sudo singularity build fastqc.sif docker.singularity

-Debian bootstrap

.. code-block:: console

  BootStrap: debootstrap
  OSVersion: bionic
  MirrorURL:  http://fr.archive.ubuntu.com/ubuntu/
  Include: build-essential curl python python-dev openjdk-11-jdk bzip2 zip unzip

  %runscript
      echo "Welcome to my Singularity Image"
      fastqc --version
      multiqc --version
      bowtie --version

  %post

      FASTQC_VERSION=0.11.9
      MULTIQC_VERSION=1.9
      BOWTIE_VERSION=1.3.0

      cd /usr/local; curl -k -L https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VERSION}.zip > fastqc.zip
      cd /usr/local; unzip fastqc.zip; rm fastqc.zip; chmod 775 FastQC/fastqc; ln -s /usr/local/FastQC/fastqc /usr/local/bin/fastqc

      cd /usr/local; curl --fail --silent --show-error --location --remote-name https://github.com/BenLangmead/bowtie/releases/download/v$BOWTIE_VERSION/bowtie-${BOWTIE_VERSION}-linux-x86_64.zip
      cd /usr/local; unzip -d /usr/local bowtie-${BOWTIE_VERSION}-linux-x86_64.zip
      cd /usr/local; rm bowtie-${BOWTIE_VERSION}-linux-x86_64.zip
      cd /usr/local/bin; ln -s ../bowtie-${BOWTIE_VERSION}-linux-x86_64/bowtie* .

      curl --fail --silent --show-error --location --remote-name  https://bootstrap.pypa.io/get-pip.py
      python get-pip.py

      pip install numpy matplotlib
      pip install -I multiqc==${MULTIQC_VERSION}

      echo "Biocore image built"

  %labels
      Maintainer Biocorecrg
  Version 0.1.0

.. code-block:: console

    sudo singularity build fastqc-multi-bowtie.sif debootstrap.singularity

**Troubleshooting**

.. code-block:: console

     singularity --help

**Fakeroot**

Singularity permissions are an evolving field. If you don't have access to ``sudo``, it might be worth considering using **--fakeroot/-f** parameter.

* More details at [https://apptainer.org/docs/user/main/fakeroot.html](https://apptainer.org/docs/user/main/fakeroot.html)

**Singularity cache directory**

.. code-block:: console

    $HOME/.singularity

* It stores cached images from registries, instances, etc.
* If problems may be a good place to clean. When running ``sudo``, $HOME is /root.

**Global singularity configuration**

Normally at ``/etc/singularity/singularity.conf`` or similar (e.g preceded by ``/usr/local/``)

* It can only be modified by users with administration permissions
* Worth noting ``bind path`` lines, which point default mounted directories in containers
