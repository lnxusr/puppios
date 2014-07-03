puppios
=======

Table of Contents
-----------------

1. [Overview - What is the Puppios puppet module?](#overview)
2. [Module Description - What does the module do?](#Module Description)
3. [Status - Where does the module stand at the moment](#Status)

Overview
--------

The Puppios module allows you to easily manage Nagios deployments with puppet.

Module Description
------------------

Achieve instant awareness of IT infrastructure problems, so downtime doesn't adversely affect your business. Nagios offers complete monitoring and alerting for servers, switches, applications, and services.
The Puppios module allows you to manage the deployment of Nagios servers and hosts. This module enables a fast deployment of a complete nagios infrastructure using autodetection for its service configuration.

Status
------
=======
2. [Status - Where does the module stand at the moment](#Status)

Overview
--------

This is puppet modules will generate a fast, but flexibel, nagios deployment. This is achieved by using an autodetect system for monitoring specific service.

Status
------

The first stage of development concists of:

1. [x] Basic installation of nagios on the nagios server.
2. [x] Basic configuration of nagios hosts.
3. [x] Basic autodetection for checks.
4. [ ] Basic configuration of contacts.
5. [ ] Advanced Server configuration.
6. [ ] Advanced configuration of nagios hosts.
7. [ ] Advanced autodetection for checks.

Setup
-----

**What Puppios affects:**

* package installation/service/configuration files for Nagios and Nagios NRPE.
* listened-to ports

=======
Whenever possible this module wil add checks to the nagios system by autodetecting. Exceptions to this rule can exist but should be avoided as much as possible.
