.. _nf-core_1-page:

.. image:: images/nf-core-logo.png
	:width: 400

Introduction to nf-core
=======================

nf-core is a community effort to collect a curated set of analysis pipelines built using Nextflow. 

Community
---------

Pipelines
---------

Standard
--------

Helper tools
------------

The main nf-core was published in 2020 in `Nature Biotechnology <https://pubmed.ncbi.nlm.nih.gov/32055031/>`__ and describes the community and framework.

.. image:: images/nf-core-paper.png
	:width: 600

Installation
------------

You can use Conda to install nf-core tools, in the command below we create a new named environment with nf-core and activate it. 

.. code-block:: console

	conda create --name nf-core nf-core 
	conda activate nf-core

.. tip::
	
	Find alternative ways of installation on the nf-core `documentation <https://nf-co.re/tools/#installation>`__

We can now check nf-core available commands:

.. code-block:: console

	$ nf-core
                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 2.4.1 - https://nf-co.re


																																			
	Usage: nf-core [OPTIONS] COMMAND [ARGS]...                                                                                                
																																			
	nf-core/tools provides a set of helper tools for use with nf-core Nextflow pipelines.                                                     
	It is designed for both end-users running pipelines and also developers creating new pipelines.                                           
																																			
	╭─ Options ────────────────────────────────────────────────────────────────────────────────────────╮
	│  --version                   Show the version and exit.                                          │
	│  --verbose   -v              Print verbose output to the console.                                │
	│  --log-file  -l  <filename>  Save a verbose log to a file.                                       │
	│  --help      -h              Show this message and exit.                                         │
	╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
	╭─ Commands for users ─────────────────────────────────────────────────────────────────────────────╮
	│  list      List available nf-core pipelines with local info.                                     │
	│  launch    Launch a pipeline using a web GUI or command line prompts.                            │
	│  download  Download a pipeline, nf-core/configs and pipeline singularity images.                 │
	│  licences  List software licences for a given workflow.                                          │
	╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
	╭─ Commands for developers ────────────────────────────────────────────────────────────────────────╮
	│  create        Create a new pipeline using the nf-core template.                                 │
	│  lint          Check pipeline code against nf-core guidelines.                                   │
	│  modules       Commands to manage Nextflow DSL2 modules (tool wrappers).                         │
	│  schema        Suite of tools for developers to manage pipeline schema.                          │
	│  bump-version  Update nf-core pipeline version number.                                           │
	│  sync          Sync a pipeline TEMPLATE branch with the nf-core template.                        │
	╰──────────────────────────────────────────────────────────────────────────────────────────────────╯

As shown in the screenshot, nf-core tools provide with some commands meant for users and with some commands meant
for developers. We will start first discussing how nf-core can be used from a user point of view.

nf-core for users
=================

Listing pipelines
------------------

To show all the nf-core available pipelines, we can use the nf-core list command. This command also
provides some other information as the last version of each of the nf-core pipelines, its publication and
and when you last pulled the pipeline to your local system.


.. code-block:: console

	$ nf-core list
