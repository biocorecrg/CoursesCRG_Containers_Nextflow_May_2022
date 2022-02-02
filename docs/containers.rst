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


  **Docker vocabulary**

  ```bash
  docker
  ```

  <img src="images/docker_vocab.png" width="550/">

  Get help:

  ```bash
  docker run --help
  ```

  <img src="images/docker_run_help.png" width="550/">


  ## Using existing images

  ### Explore Docker hub

  Images can be stored locally or shared in a registry.
  <br>
  [Docker hub](https://hub.docker.com/) is the main public registry for Docker images.
  <br>

  Let's search the keyword **ubuntu**:

  <img src="images/dockerhub_ubuntu.png" width="900/">

  ### docker pull: import image

  * get latest image / latest release

  ```bash
  docker pull ubuntu
  ```

  <img src="images/docker_pull.png" width="650/">


  * choose the version of Ubuntu you are fetching: check the different tags

  <img src="images/dockerhub_ubuntu_1804.png" width="850/">

  ```bash
  docker pull ubuntu:18.04
  ```

  ### Biocontainers

  https://biocontainers.pro/

  Specific directory of Bioinformatics related entries

  * Entries in [Docker hub](https://hub.docker.com/u/biocontainers) and/or [Quay.io](https://quay.io) (RedHat registry)
  * Normally created from [Bioconda](https://bioconda.github.io)

  Example: **FastQC**

  https://biocontainers.pro/#/tools/fastqc

      docker pull biocontainers/fastqc:v0.11.9_cv7

  ### docker images: list images

  ```bash
  docker images
  ```
  <img src="images/docker_images_list.png" width="650/">

  Each image has a unique **IMAGE ID**.

  ### docker run: run image, i.e. start a container

  Now we want to use what is **inside** the image.
  <br>
  **docker run** creates a fresh container (active instance of the image) from a **Docker (static) image**, and runs it.

  <br>
  The format is:<br>
  docker run image:tag **command**

  ```bash
  docker run ubuntu:18.04 /bin/ls
  ```

  <img src="images/docker_run_ls.png" width="200/">

  Now execute **ls** in your current working directory: is the result the same?

  <br>

  You can execute any program/command that is stored inside the image:

  ```bash
  docker run ubuntu:18.04 /bin/whoami
  docker run ubuntu:18.04 cat /etc/issue
  ```

  You can either execute programs in the image from the command line (see above) or **execute a container interactively**, i.e. **"enter"** the container.

  ```bash
  docker run -it ubuntu:18.04 /bin/bash
  ```

  Run container as daemon (in background)

  ```bash
  docker run --detach ubuntu:18.04 tail -f /dev/null
  ```

  Run container as daemon (in background) with a given name

  ```bash
  docker run --detach --name myubuntu ubuntu:18.04 tail -f /dev/null
  ```

  ### docker ps: check containers status

  List running containers:

  ```bash
  docker ps
  ```

  List all containers (whether they are running or not):

  ```bash
  docker ps -a
  ```

  Each container has a unique ID.

  ### docker exec: execute process in running container

  ```bash
  docker exec myubuntu uname -a
  ```

  * Interactively

  ```bash
  docker exec -it myubuntu /bin/bash
  ```

  ### docker stop, start, restart: actions on container

  Stop a running container:

  ```bash
  docker stop myubuntu

  docker ps -a
  ```

  Start a stopped container (does NOT create a new one):

  ```bash
  docker start myubuntu

  docker ps -a
  ```

  Restart a running container:

  ```bash
  docker restart myubuntu

  docker ps -a
  ```

  Run with restart enabled

  ```bash
  docker run --restart=unless-stopped --detach --name myubuntu2 ubuntu:18.04 tail -f /dev/null
  ```
  * Restart policies: no (default), always, on-failure, unless-stopped

  Update restart policy

  ```bash
  docker update --restart unless-stopped myubuntu
  ```

  ### docker rm, docker rmi: clean up!

  ```bash
  docker rm myubuntu
  docker rm -f myubuntu
  ```

  ```bash
  docker rmi ubuntu:18.04
  ```

  #### Major clean

  Check used space
  ```bash
  docker system df
  ```

  Remove unused containers (and others) - **DO WITH CARE**
  ```bash
  docker system prune
  ```

  Remove ALL non-running containers, images, etc. - **DO WITH MUCH MORE CARE!!!**
  ```bash
  docker system prune -a
  ```

  * Reference: https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes

  ## Volumes

  Docker containers are fully isolated. It is necessary to mount volumes in order to handle input/output files.

  Syntax: **--volume/-v** *host:container*

  ```bash
  mkdir datatest
  touch datatest/test
  docker run --detach --volume $(pwd)/datatest:/scratch --name fastqc_container biocontainers/fastqc:v0.11.9_cv7 tail -f /dev/null
  docker exec -ti fastqc_container /bin/bash
  > ls -l /scratch
  > exit
  ```

  * Exercises:
  1. Copy the 2 fastq files from available datasets in Github repository and place them in mounted directory
  2. Run fastqc interactively (inside container): ```fastqc  /scratch/*.gz```
  3. Run fastqc outside the container

  ## Ports

  The same as with volumes, but with ports, to access Internet services.

  Syntax: **--publish/-p** *host:container*


  ```bash
  docker run --detach --name webserver nginx
  curl localhost:80
  docker exec webserver curl localhost:80
  docker rm -f webserver

  ```

  ```bash
  docker run --detach --name webserver --publish 80:80 nginx
  curl localhost:80
  docker rm -f webserver
  ```

  ```bash
  docker run --detach --name webserver -p 8080:80 nginx
  curl localhost:80
  curl localhost:8080
  docker exec webserver curl localhost:80
  docker exec webserver curl localhost:8080
  docker rm -f webserver
  ```

  ## Docker recipes: build your own images

  ### Building recipes

  All commands should be saved in a text file, named by default **Dockerfile**.

  #### Basic instructions

  Each row in the recipe corresponds to a **layer** of the final image.

  **FROM**: parent image. Typically, an operating system. The **base layer**.

  ```docker
  FROM ubuntu:18.04
  ```

  **RUN**: the command to execute inside the image filesystem.
  <br>
  Think about it this way: every **RUN** line is essentially what you would run to install programs on a freshly installed Ubuntu OS.

  ```docker
  RUN apt install wget
  ```

  A basic recipe:

  ```docker
  FROM ubuntu:18.04

  RUN apt update && apt -y upgrade
  RUN apt install -y wget
  ```

  #### More instructions

  **MAINTAINER**

  Who is maintaining the container?

  ```docker
  MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>
  ```

  **WORKDIR**: all subsequent actions will be executed in that working directory

  ```docker
  WORKDIR ~
  ```

  **ADD, COPY**: add files to the image filesystem

  Difference between ADD and COPY explained [here](https://stackoverflow.com/questions/24958140/what-is-the-difference-between-the-copy-and-add-commands-in-a-dockerfile) and [here](https://nickjanetakis.com/blog/docker-tip-2-the-difference-between-copy-and-add-in-a-dockerile)

  **COPY**: lets you copy a local file or directory from your host (the machine from which you are building the image)

  **ADD**: same, but ADD works also for URLs, and for .tar archives that will be automatically extracted upon being copied.


  ```docker
  # COPY source destination
  COPY ~/.bashrc .
  ```

  **ENV, ARG**: run and build environment variables

  Difference between ARG and ENV explained [here](https://vsupalov.com/docker-arg-vs-env/).


  * **ARG** values: available only while the image is built.
  * **ENV** values: available for the future running containers.


  ```bash
  ```

  **CMD, ENTRYPOINT**: command to execute when generated container starts

  The ENTRYPOINT specifies a command that will always be executed when the container starts. The CMD specifies arguments that will be fed to the ENTRYPOINT

  <br>

  In the example below, when the container is run without an argument, it will execute `echo "hello world"`.<br>
  If it is run with the argument **nice** it will execute `echo "nice"`

  ```docker
  FROM ubuntu:18.04
  ENTRYPOINT ["/bin/echo"]
  CMD ["hello world"]
  ```

  A more complex recipe (save it in a text file named **Dockerfile**:

    ```docker
  FROM ubuntu:18.04

  MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>

  WORKDIR ~

  RUN apt-get update && apt-get -y upgrade
  RUN apt-get install -y wget

  ENTRYPOINT ["/usr/bin/wget"]
  CMD ["https://cdn.wp.nginx.com/wp-content/uploads/2016/07/docker-swarm-hero2.png"]
  ```

  ### docker build

  Implicitely looks for a **Dockerfile** file in the current directory:

  ```bash
  docker build .
  ```

  Same as:

  ```bash
  docker build --file Dockerfile .
  ```

  Syntax: **--file / -f**

  **.** stands for the context (in this case, current directory) of the build process. This makes sense if copying files from filesystem, for instance. **IMPORTANT**: Avoid contexts (directories) overpopulated with files (even if not actually used in the recipe).

  You can define a specific name for the image during the build process.

  Syntax: **-t** *imagename:tag*. If not defined ```:tag``` default is latest.

  ```bash
  docker build -t mytestimage .
  ```

  The last line of installation should be **Successfully built ...**: then you are good to go.
  <br>
  Check with ``docker images`` that you see the newly built image in the list...


  Then let's check the ID of the image and run it!

  ```bash
  docker images

  docker run f9f41698e2f8
  docker run mytestimage
  ```

  ```bash
  docker run f9f41698e2f8 https://cdn-images-1.medium.com/max/1600/1*_NQN6_YnxS29m8vFzWYlEg.png
  ```

  ### docker tag

  To tag a local image with ID "e23aaea5dff1" into the "ubuntu_wget" image name repository with version "1.0":

  ```bash
  docker tag e23aaea5dff1 --tag ubuntu_wget:1.0
  ```

  ### Build cache ###

  Every line of a Dockerfile is actually an image/layer by itself.

  Modify for instance the last bit of the previous image (let's change the image URL) and rebuild it (even with a different name/tag):

  ```docker
  FROM ubuntu:18.04

  MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>

  WORKDIR ~

  RUN apt-get update && apt-get -y upgrade
  RUN apt-get install -y wget

  ENTRYPOINT ["/usr/bin/wget"]
  CMD ["https://cdn-images-1.medium.com/max/1600/1*_NQN6_YnxS29m8vFzWYlEg.png"]
  ```

  ```bash
  docker build -t mytestimage2 .
  ```

  It will start from the last line.
  This is OK most of the times and very convenient for testing and trying new steps, but it may lead to errors when versions are updated (either FROM image or included packages). For that it is benefitial to start from scratch with ```--no-cache``` tag.

  ```bash
  docker build --no-cache -t mytestimage2 .
  ```
  ### More advanced image building

  Different ways to build images.

  Know your base system and their packages. Popular ones:
  * [Debian](https://packages.debian.org)
  * [CentOS](https://centos.pkgs.org/)
  * [Alpine](https://pkgs.alpinelinux.org/packages)
  * Conda. [Anaconda](https://anaconda.org/anaconda/repo), [Conda-forge](https://conda-forge.org/feedstocks/), [Bioconda](https://anaconda.org/bioconda/repo), etc.


  ### Additional commands

  * **docker inspect**: Get details from containers (both running and stopped). Things such as IPs, volumes, etc.

  * **docker logs**: Get *console* messages from running containers. Useful when using with web services.

  * **docker commit**: Turn a container into an image. It make senses to use when modifying container interactively. However this is bad for reproducibility if no steps are saved.

  Good for long-term reproducibility and for critical production environments:

  * **docker save**: Save an image into a tar archive.

  * **docker export**: Save a container into a tar archive.

  * **docker import**: Import a tar archive into an image.

  #### Exercises

  We explore interactively the different examples in the container/docker folders.


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

Singularity recipes
-------------------

**Docker bootstrap**

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

**Debian bootstrap**

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

Singularity advanced aspects
============================

**Sandboxing**

.. code-block:: console
  singularity build --sandbox ./sandbox docker://ubuntu:18.04
  touch sandbox/etc/myetc.conf
  singularity build sandbox.sif ./sandbox


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

**Instances**

Also know as **services**. Despite Docker it is still more convenient for these tasks, it allows enabling thing such as webservices (e.g., via APIs) in HPC workflows.

As a simple example, first we create a boostrapped image:

.. code-block:: console

  Bootstrap: docker
  From: library/mariadb:10.3

  %startscript
          mysqld


.. code-block:: console

  sudo singularity build mariadb.sif mariadb.singularity

  mkdir -p testdir
  mkdir -p testdir/db
  mkdir -p testdir/socket

  singularity exec -B ./testdir/db:/var/lib/mysql mariadb.sif mysql_install_db

  singularity instance start -B ./testdir/db:/var/lib/mysql -B ./testdir/socket:/run/mysqld mariadb.sif mydb

  singularity instance list

  singularity exec instance://mydb mysql -uroot

  singularity instance stop mydb

More information:

* `https://apptainer.com/docs/user-guide/running_services.html <https://apptainer.com/docs/user-guide/running_services.html>`
* `https://apptainer.com/docs/user-guide/networking.html <https://apptainer.com/docs/user-guide/networking.html>`


Singularity tips
----------------

**Troubleshooting**

.. code-block:: console

     singularity --help

**Fakeroot**

Singularity permissions are an evolving field. If you don't have access to ``sudo``, it might be worth considering using **--fakeroot/-f** parameter.

* More details at `https://apptainer.org/docs/user/main/fakeroot.html <https://apptainer.org/docs/user/main/fakeroot.html>`

**Singularity cache directory**

.. code-block:: console

    $HOME/.singularity

* It stores cached images from registries, instances, etc.
* If problems may be a good place to clean. When running ``sudo``, $HOME is /root.

**Global singularity configuration**

Normally at ``/etc/singularity/singularity.conf`` or similar (e.g preceded by ``/usr/local/``)

* It can only be modified by users with administration permissions
* Worth noting ``bind path`` lines, which point default mounted directories in containers
