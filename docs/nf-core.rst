.. _nf-core-page:

.. image:: images/nf-core-logo.png
	:width: 400

*******
nf-core
*******

Introduction to nf-core
=======================

nf-core is a community effort to collect a curated set of analysis pipelines built using Nextflow. As such nf-core is:

* A community of users and developers.

* A curated set of analysis pipelines build using Nextflow.

* A set of guidelines (standard).

* A set of helper tools.

Community
---------

The nf-core community is a collaborative effort that has been growing since its creation in early 2018, as you can check on
the `nf-core stats site <https://nf-co.re/stats/>`__.

.. image:: images/nfcore_community.png
	:width: 600

.. image:: images/nfcore_community_map.png
	:width: 600

Pipelines
---------

Currently, there are 66 pipelines that are available as part of nf-core (37 released, 23 under development and 6 archived). 
You can browse all of them on this `link <https://nf-co.re/pipelines>`__.

Guidelines
----------

All nf-core pipelines must meet a series of requirements or guidelines. These guidelines ensure that all nf-core pipelines
follow the same standard and stick to current computational standards to achieve reproducibility, interoperability and 
portability. The guidelines are make available on `this <https://nf-co.re/docs/contributing/guidelines>`__ link.

Helper tools
------------

To ease the use and development of nf-core pipelines, the community makes available a set of helper tools that we will
introduce on this tutorial.

Paper
-----

The main nf-core paper was published in 2020 in `Nature Biotechnology <https://pubmed.ncbi.nlm.nih.gov/32055031/>`__ and 
describes the community and the nf-core framework.

.. image:: images/nf-core-paper.png
	:width: 600


Installation
------------

You can use Conda to install nf-core tools. In the command below we create a new named environment that includes nf-core
and then, we activate it.

.. code-block:: console

	conda create --name nf-core nf-core=2.4.1 -c bioconda -c conda-forge -y 
	conda activate nf-core

.. note::	
	You will need to install again Nextflow in the instances using ``curl -s https://get.nextflow.io | bash`` and move the
	executable to ``sudo mv nextflow /usr/local/bin``

.. tip::
	Find alternative ways of installation on the nf-core `documentation <https://nf-co.re/tools/#installation>`__

We can now check the nf-core available commands:

.. code-block:: console

	$ nf-core -h
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

As shown in the screenshot, nf-core tools provides with some commands meant for users and with some commands meant
for developers. We will start first discussing how nf-core can be used from a user point of view.

nf-core for users
=================

Listing pipelines
-----------------

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
	│ airrflow               │    19 │          2.2.0 │    2 days ago │            - │ -                    │
	│ circdna                │     4 │          1.0.0 │    5 days ago │            - │ -                    │
	│ smrnaseq               │    39 │          2.0.0 │    5 days ago │ 7 months ago │ No (v1.1.0)          │
	│ rnaseq                 │   465 │          3.8.1 │   1 weeks ago │   6 days ago │ Yes (v3.8.1)         │
	│ ampliseq               │    88 │          2.3.2 │   1 weeks ago │            - │ -                    │
	│ mnaseseq               │     7 │          1.0.0 │   2 weeks ago │            - │ -                    │
	│ rnafusion              │    71 │          2.0.0 │   3 weeks ago │            - │ -                    │
	│ fetchngs               │    58 │            1.6 │   3 weeks ago │  2 weeks ago │ No (v1.5)            │
	│ atacseq                │   107 │          1.2.2 │   3 weeks ago │  2 weeks ago │ Yes (v1.2.2)         │
	│ mhcquant               │    19 │          2.3.1 │   4 weeks ago │            - │ -                    │
	│ hicar                  │     2 │          1.0.0 │  1 months ago │            - │ -                    │
	│ quantms                │     1 │            1.0 │  1 months ago │            - │ -                    │
	│ eager                  │    66 │          2.4.4 │  2 months ago │            - │ -                    │
	│ viralrecon             │    70 │          2.4.1 │  3 months ago │ 7 months ago │ No (v2.2)            │
	│ cutandrun              │    27 │            1.1 │  5 months ago │            - │ -                    │
	│ epitopeprediction      │    18 │          2.0.0 │  6 months ago │            - │ -                    │
	│ nanoseq                │    76 │          2.0.1 │  6 months ago │            - │ -                    │
	│ mag                    │    88 │          2.1.1 │  6 months ago │            - │ -                    │
	│ bacass                 │    35 │          2.0.0 │  9 months ago │            - │ -                    │
	│ bactmap                │    29 │          1.0.0 │ 12 months ago │            - │ -                    │
	│ sarek                  │   168 │          2.7.1 │ 12 months ago │ 2 months ago │ Yes (v2.7.1)         │
	[..truncated..]

.. tip::
	The pipelines can be sorted by latest release (``-s release``, default), by the last time you pulled a local copy 
	(``-s pulled``), alphabetically (``-s name``) or by the number of GitHub stars (``-s stars``).

Filtering available nf-core pipelines
-------------------------------------

It is also possible to use keywords after the ``list`` command so that the list of pipelines is shortened to those
matching the keywords or including them in the description. We can use the command below to filter on the **rna**
and **rna-seq** keywords:

.. code-block:: console
	
	$ nf-core list rna rna-seq

                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 2.4.1 - https://nf-co.re

	┏━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━┓
	┃ Pipeline Name          ┃ Stars ┃ Latest Release ┃    Released ┃  Last Pulled ┃ Have latest release? ┃
	┡━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━╇━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━╇━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━┩
	│ smrnaseq               │    39 │          2.0.0 │  5 days ago │ 7 months ago │ No (v1.1.0)          │
	│ rnaseq                 │   465 │          3.8.1 │ 1 weeks ago │   6 days ago │ Yes (v3.8.1)         │
	│ rnafusion              │    71 │          2.0.0 │ 3 weeks ago │            - │ -                    │
	│ dualrnaseq             │     7 │          1.0.0 │ 1 years ago │            - │ -                    │
	│ circrna                │    18 │            dev │           - │            - │ -                    │
	│ lncpipe                │    23 │            dev │           - │            - │ -                    │
	│ scflow                 │    12 │            dev │           - │            - │ -                    │
	│ spatialtranscriptomics │     3 │            dev │           - │            - │ -                    │
	└────────────────────────┴───────┴────────────────┴─────────────┴──────────────┴──────────────────────┘

Pulling pipelines
-----------------

Once we have identified the nf-core pipeline we want to use we can pull it using the Nextflow `built-in functionality <https://www.nextflow.io/docs/latest/sharing.html#pulling-or-updating-a-project>`__.

.. code-block:: console

	nextflow pull nf-core/<PIPELINE>

.. tip::
	Nextflow will also automatically pull a project if you use ``nextflow run nf-core/<PIPELINE>``

Launching pipelines
-------------------

The ``launch`` command enables to launch nf-core, and also Nextflow, pipelines via a web-based graphical interface or an
interactive command-line wizard tool. This command becomes handy for pipelines with a considerable number of parameters 
since it displays the documentation alongside each of the parameters and validate your inputs.

We can now launch an nf-core pipeline:

.. code-block:: console

	nf-core launch

.. note::
	The pipelines can be sorted by latest release (``-s release``, default), by the last time you pulled a local copy 
	(``-s pulled``), alphabetically (``-s name``) or by the number of GitHub stars (``-s stars``).

To render the description of the parameters, its grouping and defaults, the tool uses the ``nextflow_schema.json``. This
JSON file is bundled with the pipeline and includes all the information mentioned above, see an example `here <https://github.com/nf-core/rnaseq/blob/03d17893618c44075e4c91d83dc0e72b58f6f0f7/nextflow_schema.json>`__.

The chosen not default parameters are dumped into a JSON file called ``nf-params.json``. This file can be provided to new 
executions using the ``-params-file`` flag. See below an example:

.. literalinclude:: ../nf-core/examples/nf-params.json
	:language: json

It is a good practice in terms of reproducibility to explicitly indicate the version (revision) of the pipeline that 
you want to use, this can be indicated using the ``-r`` flag e.g. ``nf-core launch rnaseq -r 3.8.1``.

Exercise
********

Pull version ``3.8.1`` of the nf-core/rnaseq pipeline, run it using the ``nf-core launch`` command and produce the ``nf-params.json``.

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. code-block:: console

	nextflow pull nf-core/rnaseq -r 3.8.1
	nf-core launch rnaseq -r 3.8.1

.. raw:: html

	</details>
|


nf-core configs and profiles
----------------------------

nf-core configs
***************

We have already introduced Nextflow configuration files and profiles during the course. Config files are used by 
nf-core pipelines to specify the computational requirements of the pipeline, define custom parameters and set which 
software management system to be used (Docker, Singularity or Conda). As an example take a look to the `base.config <https://github.com/nf-core/smrnaseq/blob/master/conf/base.config>`__
that is used to set sensible defaults for the computational resources needed by the pipeline. 

nf-core core profiles
*********************

nf-core pipelines use profiles to bundle a set of configuration attributes. By doing so, we can activate these 
attributes by using the ``-profile`` Nextflow command line option.  All nf-core pipelines come along with a set of common 
"Core profiles" that include the ``conda``, ``docker`` and ``singularity`` that define which software manager to use and the
``test`` profile that specifies a minimal test dataset to check that the pipelines works properly.

.. note:: 
	Each configuration file can include one or several profiles

Institutional profiles
**********************

Institutional profiles are profiles where you can specify the configuration attributes for your institution system. They are
hosted in https://github.com/nf-core/configs and all pipelines pull this repository when a pipeline is run. The idea is that
these profiles set the custom config attributes to run nf-core pipelines in your institution (scheduler, container technology,
resources, etc.). This way all the users in a cluster can make use of the profile just setting the profile of your institution 
(``-profile institution``).

.. tip::
	You can use more than profile at a time by separating them by a comma without space, e.g. ``-profile test,docker``

Custom config
*************

If you need to provide any custom parameter or setting when running a nf-core pipeline, you can do it by creating a local custom 
config file and add it to your command with the ``-c`` flag.

.. image:: images/nfcore_config.png
	:width: 600

*Image from `https://carpentries-incubator.github.io/workflows-nextflow <https://carpentries-incubator.github.io/workflows-nextflow/>`__.

.. note::	
	Profiles will be prioritized from left to right in case conflicting settings are found.	 

Exercise
********

* Create a custom config that sets ``params.email`` to your email address and try to run the pipeline.

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. code-block:: console

	echo 'params.email = "youremail@address.com"' > mycustom.config
	nextflow run nf-core/rnaseq -r 3.8.1 -profile test,docker -c mycustom.config --outdir results


.. raw:: html

	</details>

* Create a custom config that sets the process cpus to 2 and the memory to 8 Gb.

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. literalinclude:: ../nf-core/examples/mycustom.config
	:language: groovy

.. code-block:: console	
	nextflow run nf-core/rnaseq -r 3.8.1 -profile test,docker -c mycustom.config --outdir results

.. raw:: html

	</details>
|
|

Running pipelines with test data
--------------------------------

All nf-core pipelines include a special configuration named ``test``. This configuration defines all the files and parameters to test
all pipeline functionality with a minimal dataset. Thus, although the functionality of the pipeline is maintained often the results
are not meaningful. As an example, find on the snippet below the test configuration of the `nf-core/rnaseq <https://github.com/nf-core/rnaseq/>`__.
pipeline.

.. literalinclude:: ../nf-core/examples/test.config
	:language: groovy

.. tip::
	You can find the current version of the above config above `here <https://github.com/nf-core/rnaseq/blob/master/conf/test.config>`__

Downloading pipelines
---------------------

If your HPC system or server does not have an internet connection you can still run nf-core pipelines by fetching the
pipeline files first and then, manually transferring them to your system. 

The ``nf-core download`` option simplifies this process and ensures the correct versioning of all the code and containers
needed to run the pipeline. By default, the command will download the pipeline code and the institutional `nf-core/configs <https://github.com/nf-core/configs>`__ 
files. Again, the ``-r`` flag allows to fetch a given revision of the pipeline.

Finally, you can also download any singularity image files required by the pipeline, if you specify the ``--singularity`` flag.

.. tip::
	If you don't provide any option to ```nf-core download`` an interactive prompt will ask you for the required options.

We can now try to download the rnaseq pipeline using the command below:

.. code-block:: console

	nf-core download rnaseq

Now we can inspect the structure of the downloaded directory:

.. code-block:: console

	$ tree -L 2 nf-core-rnaseq-3.8.1/

	nf-core-rnaseq-3.8.1/
	├── configs
	│   ├── ..truncated..
	│   ├── nextflow.config
	│   ├── nfcore_custom.config
	│   └── pipeline
	├── singularity-images
	│   ├── depot.galaxyproject.org-singularity-bbmap-38.93--he522d1c_0.img
	│   ├── ..truncated..
	│   └── depot.galaxyproject.org-singularity-umi_tools-1.1.2--py38h4a8c8d9_0.img
	└── workflow
		├── CHANGELOG.md
		├── ..truncated..
		├── main.nf
		├── modules
		└── workflows

Pipeline output
---------------

nf-core pipelines produce a `MultiQC <https://multiqc.info/>`__ report which summarises results at the end of the execution 
along with software versions of the different tools used, nf-core pipeline version and Nextflow version itself.

Each pipeline provides an example of a MultiQC report from a real execution in the nf-core website. For instance you can find
the report corresponding to the current version of nf-core/rnaseq `here <https://nf-co.re/rnaseq/results#rnaseq>`__.

nf-core for developers
======================

nf-core tools provide with a bunch of helper commands targeted to help developers implement pipelines following nf-core guidelines. 
You can use them to contribute to the nf-core repository or use them to implement your own pipelines following nf-core standards.

Creating pipelines
------------------

The ``nf-core create`` command generates a pipeline based on the nf-core template. During the process you will need to provide some
information as the pipeline name, description and author name either using the flags or answering the questions in the interactive prompt.
With this information, the pipeline will be initialized following the nf-core standards.

Besides creating the files, the command initializes the folder containing the new pipeline as a git repository and makes and initial
commit. This first commit is identical to the nf-core template and it is important since it enables to keep your pipeline in sync with
the nf-core template when it is updated (new tool releases).

Exercise
********

Try to create your own pipeline using ``nf-core create``

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. code-block:: console

	nf-core create -n "toy" -d "My awesome nf-core pipeline" -a "Your name"


.. note:: 
	As shown in the message returned by the ``nf-core create`` if you plan to contribute your pipeline to nf-core, it is 
	highly advisable to drop a message on the nf-core before starting to write any code, read more `here <https://nf-co.re/developers/adding_pipelines#join-the-community>`__

.. raw:: html

	</details>
|
|

Linting pipelines
-----------------

To make sticking to nf-core guidelines easier, nf-core includes the ``lint`` command. This command checks that the pipeline 
is following some of the nf-core standards. Interestingly, the command is the same that is used in the automated continuous 
integration tests.

Let's try to run this command on the pipeline we have just created.

.. code-block:: console

	cd nf-core-<your_pipeline_name>
	nf-core lint

.. tip::
	You can use :kbd:`ctrl` + :kbd:`click` to navigate the documentation of each of the lint results. Otherwise, 
	the complete list of the lint tests can be found `here <https://nf-co.re/tools-docs/lint_tests/index.html>`__.

To run only a specific nf-core lint test you can use the ``-k`` / ``--key`` option, this enables to run for example
only a certain test that has failed, e.g. ``nf-core lint -k files_exist -k files_unchanged``.

nf-core schema
--------------

As we discussed before, nf-core pipelines include a ``nextflow_schema.json`` that it is used to describe the parameters
of the pipelines and validate them when provided as input. Since the creation of this file could be very error prompt, 
nf-core tools provide with a command to create ``build``, ``validate`` and ``lint`` the nextflow_schema.json.

We will see an example of how to use this command on the final exercise.

.. note::
	You can find more documentation about the ``nf-core schema`` on the `nf-core website <https://nf-co.re/tools/#pipeline-schema>`__.

nf-core modules
===============

Since the introduction of `Nextflow DSL2 <https://www.nextflow.io/blog/2020/dsl2-is-here.html>`__, nf-core pipelines have, 
and still are, been ported to DSL2 syntax. One of the paramount features of the DSL2 syntax is the possibility of creating 
modules and sub-workflows, as we have already discussed during this course. For this reason, the nf-core community has created
a centralised repository to host modules and sub-workflows (the latter is still WIP). This enables multiple pipelines to use
the same process defined as a module improving the developing speed and the robustness of pipelines by using tested modules.

.. topic:: nf-core DSL2 concepts

	**MODULE**: A process that can be used within different pipelines and is as a atomic as possible i.e, cannot be split into 
	another module.
	e.g. a module file containing the process definition for a single tool such as FastQC  
	
	**SUB-WORKFLOW**: A chain of multiple modules that offer a higher-level functionality within the context of a pipeline. 
	e.g. a sub-workflow to sort, index and run some basic stats on a BAM file.

	**WORKFLOW**: An end-to-end pipeline created by a combination of Nextflow DSL2 individual modules and sub-workflows. 
	e.g. from one or more inputs to a series of final inputs

The nf-core DSL2 modules repository is at `https://github.com/nf-core/modules <https://github.com/nf-core/modules>`__ and you 
can navigate the modules available on this section of the nf-core `website <https://nf-co.re/modules>`__.

.. note::
	We have recently reach 500 modules available in the modules repository.

As you can see, modules have become a central resource of the nf-core community and as so nf-core tools provides with 
some dedicated utilities for modules. 

Listing modules
---------------

We can now list all the nf-core available modules getting advantage of the ``list remote`` sub-command. 

.. code-block:: console

	$ nf-core modules list remote
                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 2.4.1 - https://nf-co.re

	INFO     Modules available from nf-core/modules (master):                                                                                                                                                                                                            list.py:125

	┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
	┃ Module Name                              ┃
	┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┩
	│ abacas                                   │
	│ abricate/run                             │
	│ abricate/summary                         │
	│ adapterremoval                           │
	│ adapterremovalfixprefix                  │
	│ agrvate                                  │
	│ allelecounter                            │
	│ amplify/predict                          │
	│ amps                                     │
	│ amrfinderplus/run                        │
	│ amrfinderplus/update                     │
	│ antismash/antismashlite                  │
	│ antismash/antismashlitedownloaddatabases │
	│ arriba                                   │
	│ artic/guppyplex                          │
	│ artic/minion                             │
	│ ascat                                    │
	│ assemblyscan                             │
	│ ataqv/ataqv                              │
	│ bakta                                    │
	│ bamaligncleaner                          │
	│ bamcmp                                   │
	│ bamtools/convert                         │
	[..truncated..]

.. tip::
	You can add a pattern to the end of the list command to filter the modules by keyword eg: ``nf-core modules list remote samtools``

Likewise, it is also possible to list the modules installed in a pipeline by using the ``list local`` sub-command. By default, 
the command will list the modules installed in the current working directory but you can provide a different directory by using
the ``--dir <pipeline_dir>`` option.

.. code-block:: console

	nf-core modules list local

Showing information about a module
----------------------------------

You can render the basic information of a module using ``nf-core modules info <tool>``. This command will provide a brief
summary of the module functionality, the description of the input and output channels, its type (``val``, ``path``, etc.) 
and the its installation command.

.. code-block:: console

	nf-core modules info fastqc 

.. tip::
	If you prefer, you can also check the modules documentation in the `nf-core website <https://nf-co.re/modules>`__.


Installing modules in a pipeline
--------------------------------

You can use nf-core tools to install a module in any pipeline. The only requirement is that the directory contains a 
``main.nf`` a ``nextflow.config`` and a ``modules`` directory where the module will be installed.

Exercise
********

* Create a folder with an empty ``main.nf``, ``nextflow.config`` and a ``modules`` directory and try to install a module, 
e.g. samtools/sort.

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. code-block:: console
	mkdir my_pipeline
	cd my_pipeline
	touch main.nf nextflow.config 
	mkdir modules
	nf-core modules install samtools/sort

* Now, place yourself in the nf-core-toy pipeline we created before and try to install the same module.

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. code-block:: console
	cd your_path_here/nf-core-toy
	nf-core modules install samtools/sort

.. raw:: html

	</details>
|


.. code-block:: console

	nf-core modules install samtools/sort

Removing modules from a pipeline
--------------------------------

In the same manner, we can delete a module from a pipeline by using:

.. code-block:: console

	nf-core modules remove samtools/sort

Creating modules
----------------

The ``nf-core modules create`` command for modules is the equivalent to the ``nf-core create`` command for pipelines and
similarly uses the modules template to generate a module following nf-core guidelines.

You can use this command both to create local modules for a pipeline or to create modules for the `nf-core modules <https://github.com/nf-core/modules>`__
repository. The command can detect on which type of repository you are working thanks to the ``.nf-core.yml`` file that sets the type of repository using the 
``repository_type`` tag.

.. Note::
	If you want to make available a module in ``nf-core/modules`` to the whole Nextflow community you can find the reference 
	documentation `here <https://nf-co.re/developers/modules#writing-a-new-module-reference>`__  and a step by step tutorial 
	on `this <https://nf-co.re/developers/tutorials/dsl2_modules_tutorial>`__ link.

Exercise
********

* Place yourself in the nf-core-toy pipeline we created before and try to install the same module.

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. code-block:: console
	cd your_path_here/nf-core-toy
	nf-core modules create fastqc --author @github_user --label process_low --meta

	</details>
|

* In which folder does it create the module?

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. code-block:: console
	The ``create`` command generates the file inside `modules/local` since it is created as a local module to the pipeline.

* Clone the nf-core modules repository locally ``git clone https://github.com/nf-core/modules.git`` and try the same command
you use to create the fastqc module locally there, what happens?

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. code-block:: console
	The ``create`` command generates now the file inside `modules/fastqc` since it is created as a nf-core repository module. 
	You will need to include the --force flag since it is already available.

.. raw:: html

	</details>
|


Other commands for developing nf-core modules
---------------------------------------------

Lint modules
************

As for pipelines, nf-core tools provides a command to lint the modules against nf-core guidelines.

.. code-block:: console

	nf-core modules lint

Create unit test 
****************

nf-core modules have the requirement of being unit tested using a minimal test data. These tests are run using `pytest <https://pytest-workflow.readthedocs.io/en/stable/>`__
and can be automatically generated using the command below:

.. code-block:: console

	nf-core modules create-test-yml

.. Note::
	You can find more info about the ``create-test-yml`` command `here <https://nf-co.re/tools/#create-a-module-test-config-file>`__.

Run module test using pytest
****************************

Also, it is possible to run the unit test of a module using the ``nf-core modules test`` command using again `pytest <https://pytest-workflow.readthedocs.io/en/stable/>`__.
To run the test for a given module (e.g. fastqc) you can use:

.. code-block:: console

	nf-core modules test fastqc

.. tip::
	To run the modules unit test you need to install `pytest <https://pytest-workflow.readthedocs.io/en/stable/#installation>`__ first.

.. Note::
	Further documenation ``nf-core modules test`` can be found on this `link <https://nf-co.re/tools/#run-the-tests-for-a-module-using-pytest>`__.

Bump bioconda and containers versions of a module tool
******************************************************

To ease the update of the modules installed in a pipeline, nf-core provides with the ``nf-core modules bump-versions``
command. It is possible to both update a single or all modules in a pipeline. Also, this command can be used when contributing 
to the nf-core modules repository to update the versions of modules upon release in Bioconda. The typical ``bump-versions``
command looks like:

.. code-block:: console

	nf-core modules bump-versions

.. Note::
	Find the whole documenation of the ``nf-core modules bump-versions`` command `here <https://nf-co.re/tools/#bump-bioconda-and-container-versions-of-modules-in>`__.

Generate the name of a mulled container
***************************************

Biocontainers offer the possibility of generating what is known as mulled containers and that consist of multi-tool containers
generated by combinating a given version of single tool and adding them to the `hash.tsv <https://github.com/BioContainers/multi-package-containers/blob/master/combinations/hash.tsv>`__
of the Biocontainers ``multi-package-containers`` repository. This command generates the name of a BioContainers mulled image,
even if it does not exist, using the command below:

.. code-block:: console

	$ nf-core modules mulled bowtie2==2.4.4 samtools==1.15.1 pigz==2.6

                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 2.4.1 - https://nf-co.re


	INFO     Found docker image on quay.io! ✨                                                                                                                                                                                                                          mulled.py:68
	INFO     Mulled container hash:                                                                                                                                                                                                                                  __main__.py:717
	mulled-v2-ac74a7f02cebcfcc07d8e8d1d750af9c83b4d45a:1744f68fe955578c63054b55309e05b41c37a80d-0

.. Note:: 
	The above mulled container is used in the ``bowtie2/align module``, see `here <https://github.com/nf-core/modules/blob/61f68913fefc20241ceccb671b104230b2d775d7/modules/bowtie2/align/main.nf#L6-L9>`__

Exercise
********

* Create or use the previous toy nf-core pipeline

* Install the ``adapterremoval`` module

* Use the ``adapterremoval`` module in the ``toy.nf`` script.

* Add a parameter to make the call of ``adapterremoval`` optional (``skip_adapterremoval``) in the ``nextflow.config`` and implement the code to make the call of the process in ``rna.toy`` controlled by the parameter, see `here <https://github.com/nf-core/rnaseq/blob/89bf536ce4faa98b4d50a8ec0a0343780bc62e0a/workflows/rnaseq.nf#L182>`__ for an example.

* Lint the pipeline.

* Fix the linting by using the ``nf-core schema build`` command.

* Modify the arguments pass to the ``fastqc`` module by creating a custom config, see ``./conf/modules.config`` for inspiration.

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. code-block:: console
	nf-core create -n "toy" -d "My awesome nf-core pipeline" -a "Your name"
	cd nf-core-toy
	nf-core modules install adapterremoval
	# Modify toy.nf
	nf-core lint
	nf-core schema build
	nextflow run main.nf -profile test,docker --outdir ./results -c custom.config 
	</details>
|

.. literalinclude:: ../nf-core/examples/toy.nf
	:language: groovy
	:emphasize-lines: 51-52,82-87 

.. literalinclude:: ../nf-core/examples/nextflow_schema.json
	:language: JSON
	:emphasize-lines: 279-283

.. literalinclude:: ../nf-core/examples/nextflow.config
	:language: groovy
	:emphasize-lines: 21-22

.. literalinclude:: ../nf-core/examples/custom.config
	:language: groovy
	
.. raw:: html

	</details>
|

Interesting links
=================

* `nf-core website <https://nf-co.re/>`__.

* `nf-core github <https://github.com/nf-core/>`__.

* `Join nf-core slack <https://nf-co.re/join/slack>`__.

* `Join Nextflow slack <https://nextflow.io/slack-invite.html>`__.

* `nf-core YouTube channel <https://www.youtube.com/c/nf-core>`__.

* `nf-core Visual Code extension pack <https://github.com/nf-core/vscode-extensionpack>`__.

Acknowledgements
================

This nf-core tutorial has been build taking as inspiration the `nf-core official tools documentation <https://nf-co.re/tools/>`__ 
and the Carpentries materials *"Introduction to Bioinformatics workflows with Nextflow and nf-core"* that can be find `here <https://carpentries-incubator.github.io/workflows-nextflow/>`__.