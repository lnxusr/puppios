#puppios


####Table of Contents

1. [Overview - What is the Puppios module?](#overview)

##overview
This is a puppet modules aiming at a fast, but flexibel, nagios deployment. The goal is to have most of the system work on an autodetect principle. nagios checks should be able to autodetect on which systems they should be present.

The first stage of development concists of:

1. Basic installation of nagios on the nagios server
2. Basic configuration of nagios targets
3. Basic autodetection for checks

It should be possible to add checks manually. Nagios checks without autodetection can exist but should be an exception.


