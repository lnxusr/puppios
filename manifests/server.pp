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
  $nagios_users,
  $nagios_configdir    = $puppios::params::nagios_configdir,
  ) inherits puppios::params
  {
  #Install nrragios packages
  package { $puppios::params::server_packages:
    ensure => present,
    #notify => Service["${puppios::params::nagios_service}"]
  }

  $nagios_users_defaults = {
     'target'   => "$nagios_configdir/htpasswd.users",
     'notify'   => "Service[$puppios::params::nagios_service]",
  }
  create_resources('htpasswd', $nagios_users, $nagios_users_defaults)

  #Set permissions on the htpassword file
  file { "${puppios::params::nagios_configdir}/htpasswd.users":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Htpasswd[$puppios::params::puppet_webuser],
  }

  #Set correct permissions on nagios directory
  file { '/etc/nagios/':
    ensure  => 'directory',
    recurse => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  #Make sure service is running
  service { $puppios::params::nagios_service :
    ensure  => 'running',
    require => Package[$puppios::params::server_packages]
  }

  #Collect resources and populate /etc/nagios/nagios_*.cfg
  Nagios_host         <<||>>
  Nagios_hostgroup    <<||>>
  Nagios_service      <<||>>
  Nagios_hostextinfo  <<||>>
  Nagios_command      <<||>>
  Nagios_servicegroup <<||>>
}