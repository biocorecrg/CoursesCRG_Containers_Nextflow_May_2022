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

.. note:: 
	As shown in the message returned by the ``nf-core create`` if you plan to contribute your pipeline to nf-core, it is 
	highly advisable to drop a message on the nf-core before starting to write any code, read more `here <https://nf-co.re/developers/adding_pipelines#join-the-community>`__


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
---------------

Since the introduction of `Nextflow DSL2<https://www.nextflow.io/blog/2020/dsl2-is-here.html>`__, nf-core pipelines have being, 
and still are, being ported to DSL2 syntax. One of the paramount features of the DSL2 syntax is the possibility of creating 
modules and sub-workflows, as we have already discussed during this course. For this reason, the nf-core community has created
a centralised repository to host modules and sub-workflows (the latter is still WIP). This enables multiple pipelines to use
the same process defined as a module improving the developing speed and the robustness of pipelines by using tested modules.

The nf-core DSL2 modules repository is at `https://github.com/nf-core/modules<https://github.com/nf-core/modules>`__ and you 
can navigate the modules available on this section of the nf-core `website<https://nf-co.re/modules>`__.

.. note::
	We have recently reach 500 modules available in the modules repository.

As you can see, modules have been become a central resource of the nf-core community and as so nf-core tools provides with 
some dedicated utilities for modules. 

Modules
-------



.. remove the conf/test.config file and run the lint

.. LINT HELPER PACKAGE for visual code

.. In carpentries there is an example of using the nf-core/rnaseq pipeline with an example data test.

