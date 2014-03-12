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
class puppios::server (
  $puppet_webuser      = $puppios::params::puppet_webuser,
  $puppet_webpassword  = $puppios::params::puppet_webpassword,
  $puppet_configdir    = $puppios::params::puppet_configdir
  ) inherits puppios::params
  {


  package { $puppios::params::server_packages:
    ensure => present,
  }

  # add a htpasswd user for nagios
  htpasswd { $puppios::params::puppet_webuser:
    cryptpasswd => "${puppet_webpassword}",  # encrypted password hash goes here
	target      => "${puppet_configdir}/htpasswd.users",
  }
  file { "${puppet_configdir}/htpasswd.users":
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
   # collect resources and populate /etc/nagios/nagios_*.cfg
   Nagios_host <<||>>
   Nagios_service <<||>>
   Nagios_hostextinfo <<||>>
  
}

