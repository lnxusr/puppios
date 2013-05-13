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

    # prevent nagios from installing the postfix mta
        package { 'lsb-invalid-mta':
            ensure => present,
        }

    
    package { $server_$packages:
                ensure => present,
                require => Package['lsb-invalid-mta'],
        }
}

inherits puppios::params {

  }