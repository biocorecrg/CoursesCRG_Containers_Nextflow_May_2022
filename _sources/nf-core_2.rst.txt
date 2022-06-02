.. _nf-core_2-page:


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

	nf-core create -n foo -d "My awesome nf-core pipeline" -a "Your name"

|

.. note:: 
	As shown in the message returned by the ``nf-core create`` if you plan to contribute your pipeline to nf-core, it is 
	highly advisable to drop a message on the nf-core before starting to write any code, read more `here <https://nf-co.re/developers/adding_pipelines#join-the-community>`__

|

Linting pipelines
-----------------

To make sticking to nf-core guidelines easier, nf-core includes the ``lint`` command. This command checks that the pipeline is following 
nf-core standards. Interestingly, this command is the same that is used in the automated continuous integration tests.

Let's try to run this command on the pipeline we have just created.

.. code-block:: console

	cd nf-core-<your_pipeline_name>
	nf-core lint

.. tip::
	You can use :kbd:`ctrl` + :kbd:`click` to navigate the documentation of each of the lint results. Otherwise, 
	the complete list of the lint tests can be found `here <https://nf-co.re/tools-docs/lint_tests/index.html>`__

To run only a specific nf-core lint test you can use the ``-k`` / ``--key`` option, this enables to run for example
only a certain test that has failed, e.g. ``nf-core lint -k files_exist -k files_unchanged``.

nf-core modules
===============

Since the introduction of `Nextflow DSL2<https://www.nextflow.io/blog/2020/dsl2-is-here.html>`__, nf-core pipelines have, 
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

The nf-core DSL2 modules repository is at `https://github.com/nf-core/modules<https://github.com/nf-core/modules>`__ and you 
can navigate the modules available on this section of the nf-core `website<https://nf-co.re/modules>`__.

.. note::
	We have recently reach 500 modules available in the modules repository.

As you can see, modules have been become a central resource of the nf-core community and as so nf-core tools provides with 
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

	$ nf-core modules list local

Showing information about a module
----------------------------------

You can render the basic information of a module using ``nf-core modules info <tool>``. This command will provide a brief
summary of the module functionality, the description of the input and output channels, its type (``val``, ``path``, etc.) 
and the its installation command.

.. code-block:: console

	$ nf-core modules info fastqc 

.. tip::
	If you prefer, you can also check the modules documentation in the `nf-core website <https://nf-co.re/modules>`__.


Installing modules in a pipeline
--------------------------------

You can use nf-core tools to install a module in any pipeline. The only requirement is that the directory contains a 
``main.nf`` a ``nextflow.config`` and a ``modules`` directory where the module will be installed.

.. code-block:: console

	$ nf-core modules install samtools/sort

Removing modules from a pipeline
--------------------------------

In the same manner, we can delete a module from a pipeline by using:

.. code-block:: console

	``nf-core modules remove samtools/sort``.

Creating modules
----------------

The ``nf-core modules create`` command for modules is the equivalent to the ``nf-core create`` command for pipelines and
similarly uses the modules template to generate a module following nf-core guidelines.

You can use this command both to create local modules for a pipeline or to create modules for the `nf-core modules <https://github.com/nf-core/modules>`__
repository. The command can detect on which type of repository you are working thanks to the ``.nf-core.yml`` file that sets the type of repository using the 
``repository_type`` tag.

.. Note::
	If you want to make available a module in ``nf-core/modules`` to the whole Nextflow community you can find the reference 
	documentation `here https://nf-co.re/developers/modules#writing-a-new-module-reference>`__  and a step by step tutorial 
	on `this https://nf-co.re/developers/tutorials/dsl2_modules_tutorial>`__ link.

Exercise
********

Try to create a module (e.g. `fastqc`)  ``nf-core modules create``
Which is the difference? NO ESTO SERIA EN EL MODULES REPOSITORY O EN UNA PIPELINE

.. raw:: html

	<details>
	<summary><a>Solution</a></summary>

.. code-block:: console

	nf-core create -n foo -d "My awesome nf-core pipeline" -a "Your name"



.. Exercise
.. CREATE a fake pipeline (tip: use touch to create the main.nf and nextflow.config).
.. and install fastqc module there


.. Exercise
.. CREATE a toy nf-core pipeline
.. install samtools/sort module in the pipeline
.. list the modules installed in the pipeline and keep them in a json file.

.. Add the link to the nf-core modules in the nf-core website X done in Showing information about a module

.. 

.. remove the conf/test.config file and run the lint

.. LINT HELPER PACKAGE for visual code

.. In carpentries there is an example of using the nf-core/rnaseq pipeline with an example data test.

