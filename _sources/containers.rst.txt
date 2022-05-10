.. _containers-page:

*******************
Containers
*******************

Introduction to Linux containers.
=================================

What are containers?
---------------------

.. image:: https://www.synopsys.com/blogs/software-security/wp-content/uploads/2018/04/containers-rsa.jpg
  :width: 700

A Container can be seen as a **minimal virtual environment** that can be used in any Linux-compatible machine (and beyond).

Using containers is time- and resource-saving as they allow:

* Controlling for software installation and dependencies.
* Reproducibility of the analysis.

Containers allow us to use **exactly the same versions of the tools**.

Virtual machines or containers ?
----------------------------------

=====================================================  =====================================================
Virtualisation                                         Containerisation (aka lightweight virtualisation)
=====================================================  =====================================================
Abstraction of physical hardware                       Abstraction of application layer
Depends on hypervisor (software)                       Depends on host kernel (OS)
Do not confuse with hardware emulator                  Application and dependencies bundled all together
Enable virtual machines                                Every virtual machine with an OS (Operating System)
=====================================================  =====================================================


Virtualisation
----------------------------------

* Abstraction of physical hardware
* Depends on hypervisor (software)
* Do not confuse with hardware emulator
* Enable virtual machines:
	* Every virtual machine with an OS (Operating System)

Containerisation (aka lightweight virtualisation)
-------------------------------------------------

* Abstraction of application layer
* Depends on host kernel (OS)
* Application and dependencies bundled all together

Virtual machines vs containers
----------------------------------------

.. image:: https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/docker/images/vm-docker5.png
  :width: 800

`Source <https://dockerlabs.collabnix.com/beginners/difference-docker-vm.html>`__


**Pros and cons**

===== ===================================================== =====================================================
ADV   Virtualisation                                        Containerisation
===== ===================================================== =====================================================
PROS. * Very similar to a full OS.     			     * No need of full OS installation (less space).
      * High OS diversity       			     * Better portability
      							     * Faster than virtual machines.
							     * Easier automation.
							     * Easier distribution of recipes.
							     * Better portability.


CONS. * Need more space and resources.                       * Some cases might not be exactly the same as a full OS.
      * Slower than containers.                              * Still less OS diversity, even with current solutions
      * Not that good automation.
===== ===================================================== =====================================================


History of containers
----------------------

**chroot**

* chroot jail (BSD jail): first concept in 1979
* Notable use in SSH and FTP servers
* Honeypot, recovery of systems, etc.

.. image:: https://sysopsio.files.wordpress.com/2016/09/linux-chroot-jail.png
  :width: 550

**Additions in Linux kernel**

* First version: 2008
* cgroups (control groups), before "process containers"
	* isolate resource usage (CPU, memory, disk I/O, network, etc.) of a collection of processes
* Linux namespaces
	* one set of kernel resources restrict to one set of processes

.. image:: images/linux-vs-docker-comparison-architecture-docker-lxc.png
  :width: 600
