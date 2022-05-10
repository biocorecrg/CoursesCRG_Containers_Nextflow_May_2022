#!/usr/bin/env nextflow
// This is a comment

/*
 * This is a block of comments
 */

// This is needed for activating the new DLS2
nextflow.enable.dsl=2

/* 
* This is a channel creating 
*/ from string values

str = Channel.from('hello', 'hola', 'bonjour')

/*
* The operator view() can be used to view the channel `str`
* https://www.nextflow.io/docs/latest/operator.html#view
*/

str.view()
