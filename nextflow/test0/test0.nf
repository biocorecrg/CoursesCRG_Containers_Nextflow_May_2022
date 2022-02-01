#!/usr/bin/env nextflow

/*
 * Copyright (c) 2013-2020, Centre for Genomic Regulation (CRG).
 *
 *   This file is part of 'CRG_Containers_NextFlow'.
 *
 *   CRG_Containers_NextFlow is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   CRG_Containers_NextFlow is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with CRG_Containers_NextFlow.  If not, see <http://www.gnu.org/licenses/>.
 */


/* 
 * This code enables the new dsl of Nextflow. 
 */
 
nextflow.enable.dsl=2

/* 
 * Creates a channel emitting some string values
 */
 
str = Channel.from('hello', 'hola', 'bonjour')

/*
 * Creates a process which receive an input channel containing values
 * Each value emitted by the channel triggers the execution 
 * of the process. The process stdout is caputured and send over 
 * the another channel. 
 */

process printHello {
   tag { "${str_in}" }
   
   input:
   val str_in

   output: 
   stdout
   
   script:
   """
   echo ${str_in} in Italian is ciao 
   """
}

/*
 * A workflow consist of a number of invocations of processes
 * where they are fed with the expected input channels 
 * as they were cutom functions. You can only invoke once a process per workflow.
 */

workflow {
 result = printHello(str)
 result.view()
}
 
