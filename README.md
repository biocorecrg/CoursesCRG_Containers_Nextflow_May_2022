# Courses@PHIND_course_nextflow_Feb_2022

## Title

Reproducible research and data analysis using Nextflow pipelines
<br>
Course page: https://www.sib.swiss/training/course/20211115_NEXTF
<br>
Course materials: https://biocorecrg.github.io/SIB_course_nextflow_Nov_2021/docs/


## About the course

This slow-paced hands-on course is designed for absolute beginners who want to start using [Nextflow](https://www.nextflow.io) to achieve reproducibility of data analysis. 

### Outline

The 4-half-day Nextflow course will train participants to build Nextflow pipelines and run them with [Singularity](https://sylabs.io/singularity/)  containers.

It is designed to provide trainees with short and frequent hands-on sessions, while keeping theoretical sessions to a minimum.

The course will be fully virtual via the [Zoom](https://zoom.us/) platform.

Trainees will work in a dedicated [AWS environment](https://en.wikipedia.org/wiki/AWS).


### Learning objectives

* Locate and fetch Docker/Singularity images from dedicated repositories.
* Execute/Run a Docker/Singularity container from the command line.
* Locate and fetch Nextflow pipelines from dedicated repositories.
* Execute/Run a Nextflow pipeline.
* Describe and explain Nextflow basic concepts.
* Test and modify a Nextflow pipeline.
* Implement short blocks of code into a Nextflow pipeline.
* Develop a Nextflow pipeline from scratch.
* Run a pipeline in diverse computational environments (local, HPC, cloud).
* Share a pipeline.

### Prerequisite / technical requirements

Being comfortable working with the CLI (command-line interface) in a Linux-based environment.
Knowledge of containers is not mandatory; however, this SIB course (https://www.sib.swiss/training/course/20211014_DOCK) can be advised to take. The course materials is online in the dedicated GitHub page for self-learning.

Practitioners will need to connect during the course to a remote server via the "ssh" protocotol. You can learn about it [here](https://www.hostinger.com/tutorials/ssh-tutorial-how-does-ssh-work)

Those who follow the course should be able to use a command-line/screen-oriented text editor (such as nano or vi/vim, which are already available on the server) or to be able to use an editor able to connect remotely. For sake of information, below the basics of "nano":
https://wiki.gentoo.org/wiki/Nano/Basics_Guide

Having a [GitHub account](https://github.com/join) is recommended. 

## Dates, time, location

* Dates: November 15-18, 2021

* Time: 13:00-17:30 (CET)
  * Afternoon coffee break: 15:00-15:30

* Location: virtual, via Zoom.

## Program

### Day 1: Introduction to Nextflow and Linux containers

* 13:00-13:30 Getting started, become familiar with the working environment.
* 13:30-14:30 Talk by Cédric Notredame and Jose Antonio Espinosa from CRG.
* 14:30-15:00 Introduction to Docker and Singularity containers.
* 15:00-15:30 Break.
* 15:30-16:30 Docker hub, BioContainers and other repositories. Find existing containers. Execute a Singularity container. 
* 16:30-17:30 Nexflow: introduction, installation, run a simple pipeline. 


### Day 2: Understand and run a basic Nexflow pipeline

* 13:00-14:00 Nexflow basic concepts. Channels and Operators. Processes, Workflows and the log
* 14:00-14:30 Breakout rooms: create channels starting from data. Write and run more simple pipelines.
* 14:30-15:00 Troubleshooting, Q&A.
* 15:00-15:30 Break.
* 15:30-16:30 Combine processes, directives, resume the pipeline.
* 16:30-17:00 Breakout rooms: write and run a more complex pipeline.
* 17:00-17:30 Troubleshooting, Q&A.  

### Day 3: Write, modify and run a complex pipeline 

* 13:00-14:00 Decoupling resources, parameters and nextflow script (params and nextflow config). Help section. How to get pipelines and run them.
* 14:00-14:30 Breakout rooms: example of directives, get a pipeline and run it with a test dataset.
* 14:30-15:00 Troubleshooting, Q&A.
* 15:00-15:30 Break.
* 15:30-16:30 Fetch public pipelines, adapt and run them. 
* 16:30-17:00 Breakout rooms: exercise.
* 17:00-17:30 Troubleshooting, Q&A. 

### Day 4: Run a Nextflow pipeline in different environments, share and report

* 13:00-14:00 Using Singularity, profiles and deploying on AWS. 
* 14:00-14:30 Breakout rooms: Deploy your pipeline on the cloud. 
* 14:30-15:00 Troubleshooting, Q&A.
* 15:00-15:30 Break.
* 15:30-16:30 Modules, reporting, share Nextflow pipelines on github. Nextflow Tower.
* 16:30-17:00 Breakout rooms: exercise. 
* 17:00-17:30 Troubleshooting, Q&A.  





## Acknowledgements

* [Sphinx](https://www.sphinx-doc.org/). The publication system for our course pages.
* [ELIXIR Workshop Hackathon](https://github.com/vibbits/containers-workflow-hackathon). Joined initiative with other colleagues to exchange materials for courses and approaches for courses like this.
