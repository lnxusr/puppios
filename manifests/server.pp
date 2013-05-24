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
class puppios::server(
)
inherits puppios::params
{
    package { $server_packages:
        ensure  => installed,
    }
    notify{"Folder is: ${base_d}": }
    file { $base_d:
        ensure => "directory",
        owner  => "nagios",
        group  => "nagios",
        mode   => 755,
    }
    notify{"Folder is: ${host_d}": }
    file { [$host_d, $services_d, $commands_d]:
        ensure  => "directory",
        owner   => "nagios",
        group   => "nagios",
        mode    => 755,
        require => File[$base_d],
    }
    file { $conf_f:
        ensure  => present,
        owner   => "nagios",
        group   => "nagios",
        mode    => 644,
        content => template('puppios/nagios.cfg.erb')
    }
    service { 'nagios3':
        ensure  => running,
        alias   => nagios,
        require => Package[$server_packages],
    }
}

