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

You can use Conda to install nf-core tools, in the command below we create a new named environment that includes nf-core
and then, we activate it.

.. code-block:: console

	conda create --name nf-core nf-core -c bioconda -y 
	conda activate nf-core

.. note::	
	We assume ``Nextflow`` has been installed in your system during the previous sessions of the course and it is available 
	in your path. 

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
	                                          ,--./,-.
	          ___     __   __   __   ___     /,-._.--~\
	    |\ | |__  __ /  ` /  \ |__) |__         }  {
	    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
	                                          `._,._,'

    	nf-core/tools version 2.4.1 - https://nf-co.re


	┏━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━┓
	┃ Pipeline Name          ┃ Stars ┃ Latest Release ┃      Released ┃  Last Pulled ┃ Have latest release? ┃
	┡━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━╇━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━┩
	│ rnafusion              │    70 │          2.0.0 │    5 days ago │            - │ -                    │
	│ fetchngs               │    57 │            1.6 │    1 week ago │            - │ -                    │
	│ atacseq                │   106 │          1.2.2 │   2 weeks ago │  5 hours ago │ Yes (v1.2.2)         │
	│ mhcquant               │    19 │          2.3.1 │   2 weeks ago │            - │ -                    │
	│ hicar                  │     2 │          1.0.0 │   3 weeks ago │            - │ -                    │
	│ rnaseq                 │   460 │            3.7 │   3 weeks ago │ 2 months ago │ No (v3.6)            │
	│ quantms                │     1 │            1.0 │   3 weeks ago │            - │ -                    │
	│ airrflow               │    19 │          2.1.0 │   3 weeks ago │            - │ -                    │
	│ eager                  │    65 │          2.4.4 │  2 months ago │            - │ -                    │
	│ ampliseq               │    88 │          2.3.1 │  2 months ago │            - │ -                    │
	│ viralrecon             │    69 │          2.4.1 │  3 months ago │ 6 months ago │ No (v2.2)            │
	│ cutandrun              │    27 │            1.1 │  4 months ago │            - │ -                    │
	│ epitopeprediction      │    18 │          2.0.0 │  5 months ago │            - │ -                    │
	│ nanoseq                │    73 │          2.0.1 │  6 months ago │            - │ -                    │
	│ mag                    │    88 │          2.1.1 │  6 months ago │            - │ -                    │
	│ bacass                 │    35 │          2.0.0 │  9 months ago │            - │ -                    │
	│ bactmap                │    29 │          1.0.0 │ 11 months ago │            - │ -                    │
	│ smrnaseq               │    39 │          1.1.0 │ 11 months ago │ 6 months ago │ Yes (v1.1.0)         │
	│ sarek                  │   167 │          2.7.1 │ 11 months ago │ 2 months ago │ Yes (v2.7.1)         │
	...

.. tip::
	The pipelines can be sorted by latest release (``-s release``, default), by the last time you pulled a local copy (``-s pulled``), 
	alphabetically (``-s name``) or by the number of GitHub stars (``-s stars``).

Launching pipelines
-------------------

The ``launch`` command enables to launch nf-core, and also Nextflow, pipelines via a web-based graphical interface or an
interactive command-line wizard tool. This command becomes handy for pipelines with a considerable number of parameters 
since it displays the documentation alongside each of the parameters and validate your inputs.

We can now launch an nf-core pipeline:

.. code-block:: console

	$ nf-core launch

.. note::
	The pipelines can be sorted by latest release (``-s release``, default), by the last time you pulled a local copy 
	(``-s pulled``), alphabetically (``-s name``) or by the number of GitHub stars (``-s stars``).

To render the description of the parameters, its grouping and defaults, the tool uses the ``nextflow_schema.json``.

The chosen parameters are dumped into a JSON file called ``nf-params.json``. This file can be provided to new executions using
the ``-params-file`` flag.

.. literalinclude:: ../nf-core/examples/nf-params.json
	:language: json

.. note::
