# Class: nagios::server
#
# This class installs Nagios3 server
#
# Parameters:
#
# Actions:
#   - Install nagios
#   - Manage nagios service
#
# Requires:
#
# Sample Usage:
#
class puppios::server {
include puppios::params
    # prevent nagios from installing the postfix mta
        package { 'lsb-invalid-mta':
            ensure => present,
        }


    package { $puppios::params::server_packages:
                ensure => present,
                require => Package['lsb-invalid-mta'],
        }
   # add a htpasswd user for nagios
	htpasswd { "nagiosadmin":
 	ryptpasswd => "$apr1$AAJvNhnI$nLg6q.oJBJE9nZQTd7pzP1",  # encrypted password hash goes here
	target => "${puppios::params::configdir}/htpasswd.users",
}
}

