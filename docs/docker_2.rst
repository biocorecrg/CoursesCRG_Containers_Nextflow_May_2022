.. _docker_2-page:

*******************
Docker 2
*******************

Docker recipes: build your own images
=====================================

OS commands in image building
-----------------------------

Depending on the underlying OS, there are different ways to build images.

Know your base system and their packages. Popular ones:

* `Debian <https://packages.debian.org>`__

* `CentOS <https://centos.pkgs.org/>`__

* `Alpine <https://pkgs.alpinelinux.org/packages>`__

* Conda. `Anaconda <https://anaconda.org/anaconda/repo>`__, `Conda-forge <https://conda-forge.org/feedstocks/>`__, `Bioconda <https://anaconda.org/bioconda/repo>`__, etc.


Update and upgrade packages
***************************

* In **Ubuntu**:

.. code-block::

  apt-get update && apt-get upgrade -y


In **CentOS**:

.. code-block::

  yum check-update && yum update -y


Search and install packages
***************************

* In **Ubuntu**:

.. code-block::

  apt search libxml2
  apt install -y libxml2-dev


* In **CentOS**:

.. code-block::

  yum search libxml2
  yum install -y libxml2-devel.x86_64


Note the **-y** option that we set for updating and for installing.<br>
It is an important option in the context of Docker: it means that you *answer yes to all questions* regarding installation.


Building recipes
----------------

All commands should be saved in a text file, named by default **Dockerfile**.

Basic instructions
******************

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


docker build
************

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
  # Same as:
  docker build -t mytestimage:latest .


* IMPORTANT: Avoid contexts (directories) over-populated with files (even if not actually used in the recipe).
In order to avoid that some directories or files are inspected or included (e.g, with COPY command in Dockerfile), you can use .dockerignore file to specify which paths should be avoided. More information at: https://codefresh.io/docker-tutorial/not-ignore-dockerignore-2/


The last line of installation should be **Successfully built ...**: then you are good to go.

Check with ``docker images`` that you see the newly built image in the list...

Then let's check the ID of the image and run it!

.. code-block:: console

  docker images

  docker run f9f41698e2f8
  docker run mytestimage


More instructions
*****************

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

If we have a file, let's say ```example.jpg```, we can copy it.

.. code-block::

  # COPY source destination
  COPY example.jpg .

A more sophisticated case:

.. code-block::

  FROM ubuntu:18.04

  RUN apt update && apt -y upgrade
  RUN apt install -y wget

  RUN mkdir -p /data

  WORKDIR /data

  COPY example.jpg .


**ENV, ARG**: run and build environment variables

Difference between ARG and ENV explained `here <https://vsupalov.com/docker-arg-vs-env/>`__.

* **ARG** values: available only while the image is built.
* **ENV** values: available during the image build process but also for the future running containers.
  * It can be checked in a resulting running container by running ``env``.

In the case below **UbuntuVersion** argument is provided with a default value.

.. code-block::

  ARG UbuntuVersion=18.04

  FROM ubuntu:${UbuntuVersion}


Override the value for **UbuntuVersion** as you build the image with --build-arg:

.. code-block::

  docker build --build-arg UbuntuVersion=20.04 .


We try a simple example with ENV

.. code-block::

  FROM ubuntu:18.04

  ENV PLANET="Earth"

  RUN echo ${PLANET}

Enter in the container interactively and check variable ``${PLANET}``

You can pass variable through commandline as well (with ``--env``/``-e``) during running process:

.. code-block:: console

  docker run -ti --env PLANET=Mars test


Try to replace the examples above of **ENV** with **ARG** and see what happens.


**CMD, ENTRYPOINT**: command to execute when generated container starts

The ENTRYPOINT specifies a command that will always be executed when the container starts. The CMD specifies arguments that will be fed to the ENTRYPOINT

In the example below, when the container is run without an argument, it will execute `echo "hello world"`.
If it is run with the argument **hello moon** it will execute `echo "hello moon"`

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



.. code-block:: console

  docker run f9f41698e2f8 https://cdn-images-1.medium.com/max/1600/1*_NQN6_YnxS29m8vFzWYlEg.png


docker tag
-----------

To tag a local image with ID "e23aaea5dff1" into the "ubuntu_wget" image name repository with version "1.0":

.. code-block:: console

  docker tag e23aaea5dff1 ubuntu_wget:1.0


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

Build exercise
--------------

* Random numbers

* Copy the following short bash script in a file called random_numbers.bash.

.. code-block:: console

  #!/usr/bin/bash
  seq 1 1000 | shuf | head -$1


This script outputs random intergers from 1 to 1000: the number of integers selected is given as the first argument.

* Write a recipe for an image:

  * Based on centos:7

  * That will execute this script (with bash) when it is run, giving it 2 as a default argument (i.e. outputs 2 random integers): the default can be changed as the image is run.

  * Build the image.

  * Start a container with the default argument, then try it with another argument.

.. raw:: html

  <details>
  <summary><a>Suggested solution</a></summary>

.. code-block::

  FROM centos:7

  MAINTAINER Name Surname <name.surname@mail.com>

  # Copy script from host to image
  COPY random_numbers.bash .

  # Make script executable
  RUN chmod +x random_numbers.bash

  # As the container starts, "random_numbers.bash" is run
  ENTRYPOINT ["/usr/bin/bash", "random_numbers.bash"]

  # default argument (that can be changed on the command line)
  CMD ["2"]

Build and run:

.. code-block:: console

  docker build -f Dockerfile_RN -t random_numbers .
  docker run random_numbers
  docker run random_numbers 10

.. raw:: html

  </details>

Additional commands
===================

* **docker inspect**: Get details from containers (both running and stopped). Things such as IPs, volumes, etc.

* **docker logs**: Get *console* messages from running containers. Useful when using with web services.

* **docker commit**: Turn a container into an image. It make senses to use when modifying container interactively. However this is bad for reproducibility if no steps are saved.

Good for long-term reproducibility and for critical production environments:


* **docker save**: Save an image into an image tar archive.

* **docker load**: Load an image tar archive to become an image.

* **docker export**: Save a container filesystem into a tar archive.

* **docker import**: Import a filesystem tar archive into an image (you need to specify a target tag).


Example dealing with tar images
-------------------------------

.. code-block:: console

  # Let's save the image in a tar
  docker save -o random_numbers.tar random_numbers

  # Remove the original image
  docker rmi random_numbers

  # Check existing images now
  docker images

  # Recover it
  docker load < random_numbers.tar

  # Check now images
  docker images


Note about the tar formats
--------------------------

* If you check the tar archives generated thanks to **save** with the ones using export, you will notice they do not look the same.

* The former ones ressemble more what you will find in ``/var/lib/docker`` (that is where Docker daemon stores its data) and it includes metadata information (so it is not necessary to specify an image tag).

* On the other hand, tar files generated with **export** they simply contantain the image filesystem. You lost that way a lot of metadata associated to the original image, such as the tags, but also things such as ENTRYPOINT and CMD instructions.


Exercises
=========

We explore interactively the different examples in the containers/docker folders.
