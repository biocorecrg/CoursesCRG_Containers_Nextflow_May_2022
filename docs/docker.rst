.. _docker-page:

*******************
Docker
*******************

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


Docker vocabulary
----------------------------

.. code-block:: console

  docker


.. image:: images/docker_vocab.png
  :width: 550

Get help:

.. code-block:: console

  docker run --help


.. image:: images/docker_run_help.png
  :width: 550


Using existing images
---------------------

Explore Docker hub
******************

Images can be stored locally or shared in a registry.


`Docker hub <https://hub.docker.com/>`__ is the main public registry for Docker images.


Let's search the keyword **ubuntu**:

.. image:: images/dockerhub_ubuntu.png
  :width: 900

docker pull: import image
*************************

* get latest image / latest release

.. code-block:: console

  docker pull ubuntu


.. image:: images/docker_pull.png
  :width: 650

* choose the version of Ubuntu you are fetching: check the different tags

.. image:: images/dockerhub_ubuntu_1804.png
  :width: 850

.. code-block:: console

  docker pull ubuntu:18.04


Biocontainers
*************

https://biocontainers.pro/

Specific directory of Bioinformatics related entries

* Entries in `Docker hub <https://hub.docker.com/u/biocontainers>`__ and/or `Quay.io <https://quay.io>`__ (RedHat registry)

* Normally created from `Bioconda <https://bioconda.github.io>`__

Example: **FastQC**

https://biocontainers.pro/#/tools/fastqc


.. code-block:: console

    docker pull biocontainers/fastqc:v0.11.9_cv7

docker images: list images
--------------------------

.. code-block:: console
  docker images

.. image:: images/docker_images_list.png
  :width: 650

Each image has a unique **IMAGE ID**.

docker run: run image, i.e. start a container
---------------------------------------------

Now we want to use what is **inside** the image.


**docker run** creates a fresh container (active instance of the image) from a **Docker (static) image**, and runs it.


The format is:

docker run image:tag **command**

.. code-block:: console
  docker run ubuntu:18.04 /bin/ls


.. image:: images/docker_run_ls.png
  :width: 200

Now execute **ls** in your current working directory: is the result the same?


You can execute any program/command that is stored inside the image:

.. code-block:: console
  docker run ubuntu:18.04 /bin/whoami
  docker run ubuntu:18.04 cat /etc/issue


You can either execute programs in the image from the command line (see above) or **execute a container interactively**, i.e. **"enter"** the container.

.. code-block:: console
  docker run -it ubuntu:18.04 /bin/bash


Run container as daemon (in background)

.. code-block:: console
  docker run --detach ubuntu:18.04 tail -f /dev/null

Run container as daemon (in background) with a given name

.. code-block:: console
  docker run --detach --name myubuntu ubuntu:18.04 tail -f /dev/null


docker ps: check containers status
----------------------------------

List running containers:

.. code-block:: console
  docker ps


List all containers (whether they are running or not):

.. code-block:: console
  docker ps -a


Each container has a unique ID.

docker exec: execute process in running container
-------------------------------------------------

.. code-block:: console
  docker exec myubuntu uname -a


* Interactively

.. code-block:: console
  docker exec -it myubuntu /bin/bash


docker stop, start, restart: actions on container
-------------------------------------------------

Stop a running container:

.. code-block:: console
  docker stop myubuntu

  docker ps -a


Start a stopped container (does NOT create a new one):

.. code-block:: console
  docker start myubuntu

  docker ps -a


Restart a running container:

.. code-block:: console
  docker restart myubuntu

  docker ps -a


Run with restart enabled

.. code-block:: console
  docker run --restart=unless-stopped --detach --name myubuntu2 ubuntu:18.04 tail -f /dev/null

* Restart policies: no (default), always, on-failure, unless-stopped

Update restart policy

.. code-block:: console
  docker update --restart unless-stopped myubuntu


docker rm, docker rmi: clean up!
--------------------------------

.. code-block:: console
  docker rm myubuntu
  docker rm -f myubuntu


.. code-block:: console
  docker rmi ubuntu:18.04


Major clean
***********

Check used space
.. code-block:: console
  docker system df


Remove unused containers (and others) - **DO WITH CARE**
.. code-block:: console
  docker system prune


Remove ALL non-running containers, images, etc. - **DO WITH MUCH MORE CARE!!!**
.. code-block:: console
  docker system prune -a

* Reference: https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes


Exercise
********

* Pull the imagemagick image that is official and that has the highest number of stars

* Check the version of the convert command.

* Start a container interactively.

* Inside the container: download this png image

* Convert it to .jpg using the convert command of imagemagick (format; convert image.png image.jpg).

* Exit the container.

* Copy the jpg image back from the stopped container! Try new command `docker cp`.


.. raw:: html

   <details>
   <summary><a>Suggested solution</a></summary>

.. code-block:: console

  # Pull image
  docker pull acleancoder/imagemagick-full

  # Check version of `convert`
  docker run acleancoder/imagemagick-full convert --version

  # Start interactive container
  docker run -it acleancoder/imagemagick-full
    # fetch png image
    > wget https://pbs.twimg.com/profile_images/1273307847103635465/lfVWBmiW_400x400.png
    # convert to jpg
    > convert lfVWBmiW_400x400.png myimage.jpg
    # exit container

  # fetch container ID with `ps -a` and use `docker cp` to copy jpg file from the stopped container to the host
  docker cp *CONTAINER_ID*:/myimage.jpg .

  .. raw:: html

    </details>

Volumes
=======

Docker containers are fully isolated. It is necessary to mount volumes in order to handle input/output files.

Syntax: **--volume/-v** *host:container*

.. code-block:: console
  mkdir datatest
  touch datatest/test
  docker run --detach --volume $(pwd)/datatest:/scratch --name fastqc_container biocontainers/fastqc:v0.11.9_cv7 tail -f /dev/null
  docker exec -ti fastqc_container /bin/bash
  > ls -l /scratch
  > exit


Exercises
---------

1. Copy the 2 fastq files from available datasets in Github repository and place them in mounted directory

2. Run fastqc interactively (inside container): ```fastqc  /scratch/*.gz```

3. Run fastqc outside the container

Ports
=====

The same as with volumes, but with ports, to access Internet services.

Syntax: **--publish/-p** *host:container*


.. code-block:: console
  docker run --detach --name webserver nginx
  curl localhost:80
  docker exec webserver curl localhost:80
  docker rm -f webserver

.. code-block:: console
  docker run --detach --name webserver --publish 80:80 nginx
  curl localhost:80
  docker rm -f webserver

.. code-block:: console
  docker run --detach --name webserver -p 8080:80 nginx
  curl localhost:80
  curl localhost:8080
  docker exec webserver curl localhost:80
  docker exec webserver curl localhost:8080
  docker rm -f webserver

Docker recipes: build your own images
=====================================

Building recipes
----------------

All commands should be saved in a text file, named by default **Dockerfile**.

Basic instructions
------------------

Each row in the recipe corresponds to a **layer** of the final image.

**FROM**: parent image. Typically, an operating system. The **base layer**.

.. code-block::
  FROM ubuntu:18.04


**RUN**: the command to execute inside the image filesystem.

Think about it this way: every **RUN** line is essentially what you would run to install programs on a freshly installed Ubuntu OS.

.. code-block::
  RUN apt install wget


A basic recipe:

.. code-block::
  FROM ubuntu:18.04

  RUN apt update && apt -y upgrade
  RUN apt install -y wget


More instructions
-----------------

**MAINTAINER**

Who is maintaining the container?

.. code-block::
  MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>


**WORKDIR**: all subsequent actions will be executed in that working directory

.. code-block::
  WORKDIR ~


**ADD, COPY**: add files to the image filesystem

Difference between ADD and COPY explained `here <https://stackoverflow.com/questions/24958140/what-is-the-difference-between-the-copy-and-add-commands-in-a-dockerfile>`__ and `here <https://nickjanetakis.com/blog/docker-tip-2-the-difference-between-copy-and-add-in-a-dockerile>`__

**COPY**: lets you copy a local file or directory from your host (the machine from which you are building the image)

**ADD**: same, but ADD works also for URLs, and for .tar archives that will be automatically extracted upon being copied.


.. code-block::

  # COPY source destination
  COPY ~/.bashrc .


**ENV, ARG**: run and build environment variables

Difference between ARG and ENV explained `here <https://vsupalov.com/docker-arg-vs-env/>`__.


* **ARG** values: available only while the image is built.
* **ENV** values: available for the future running containers.


**CMD, ENTRYPOINT**: command to execute when generated container starts

The ENTRYPOINT specifies a command that will always be executed when the container starts. The CMD specifies arguments that will be fed to the ENTRYPOINT


In the example below, when the container is run without an argument, it will execute `echo "hello world"`.
If it is run with the argument **nice** it will execute `echo "nice"`

.. code-block::

  FROM ubuntu:18.04
  ENTRYPOINT ["/bin/echo"]
  CMD ["hello world"]


A more complex recipe (save it in a text file named **Dockerfile**:

.. code-block::

  FROM ubuntu:18.04

  MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>

  WORKDIR ~

  RUN apt-get update && apt-get -y upgrade
  RUN apt-get install -y wget

  ENTRYPOINT ["/usr/bin/wget"]
  CMD ["https://cdn.wp.nginx.com/wp-content/uploads/2016/07/docker-swarm-hero2.png"]


docker build
------------

Implicitely looks for a **Dockerfile** file in the current directory:

.. code-block:: console
  docker build .

Same as:

.. code-block:: console
  docker build --file Dockerfile .


Syntax: **--file / -f**

**.** stands for the context (in this case, current directory) of the build process. This makes sense if copying files from filesystem, for instance. **IMPORTANT**: Avoid contexts (directories) overpopulated with files (even if not actually used in the recipe).

You can define a specific name for the image during the build process.

Syntax: **-t** *imagename:tag*. If not defined ```:tag``` default is latest.

.. code-block:: console
  docker build -t mytestimage .


The last line of installation should be **Successfully built ...**: then you are good to go.

Check with ``docker images`` that you see the newly built image in the list...


Then let's check the ID of the image and run it!

.. code-block:: console
  docker images

  docker run f9f41698e2f8
  docker run mytestimage


.. code-block:: console
  docker run f9f41698e2f8 https://cdn-images-1.medium.com/max/1600/1*_NQN6_YnxS29m8vFzWYlEg.png

docker tag
-----------

To tag a local image with ID "e23aaea5dff1" into the "ubuntu_wget" image name repository with version "1.0":

.. code-block:: console
  docker tag e23aaea5dff1 --tag ubuntu_wget:1.0


Build cache
------------

Every line of a Dockerfile is actually an image/layer by itself.

Modify for instance the last bit of the previous image (let's change the image URL) and rebuild it (even with a different name/tag):

.. code-block::
  FROM ubuntu:18.04

  MAINTAINER Toni Hermoso Pulido <toni.hermoso@crg.eu>

  WORKDIR ~

  RUN apt-get update && apt-get -y upgrade
  RUN apt-get install -y wget

  ENTRYPOINT ["/usr/bin/wget"]
  CMD ["https://cdn-images-1.medium.com/max/1600/1*_NQN6_YnxS29m8vFzWYlEg.png"]


.. code-block:: console
  docker build -t mytestimage2 .


It will start from the last line.
This is OK most of the times and very convenient for testing and trying new steps, but it may lead to errors when versions are updated (either FROM image or included packages). For that it is benefitial to start from scratch with ```--no-cache``` tag.

.. code-block:: console
  docker build --no-cache -t mytestimage2 .

More advanced image building
----------------------------

Different ways to build images.

Know your base system and their packages. Popular ones:

* `Debian <https://packages.debian.org>`__

* `CentOS <https://centos.pkgs.org/>`__

* `Alpine <https://pkgs.alpinelinux.org/packages>`__

* Conda. `Anaconda <https://anaconda.org/anaconda/repo>`__, `Conda-forge <https://conda-forge.org/feedstocks/>`__, `Bioconda <https://anaconda.org/bioconda/repo>`__, etc.


Additional commands
===================

* **docker inspect**: Get details from containers (both running and stopped). Things such as IPs, volumes, etc.

* **docker logs**: Get *console* messages from running containers. Useful when using with web services.

* **docker commit**: Turn a container into an image. It make senses to use when modifying container interactively. However this is bad for reproducibility if no steps are saved.

Good for long-term reproducibility and for critical production environments:

* **docker save**: Save an image into a tar archive.

* **docker export**: Save a container into a tar archive.

* **docker import**: Import a tar archive into an image.

Exercises
=========

We explore interactively the different examples in the container/docker folders.
