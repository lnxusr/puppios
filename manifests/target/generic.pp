#blatantly stolen from http://blog.gurski.org/index.php/2010/01/28/automatic-monitoring-with-puppet-and-nagios/
class puppios::target::generic(
) inherits puppios::params {
  $os_downcase = downcase($operatingsystem)

  package { $puppios::params::nrpe_packages:
    ensure => installed,
  }

  file { "${puppios::params::nrpe_confdir}/${nagios_server_name}.cfg":
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Package[$puppios::params::nrpe_packages],
    notify  => Service[$puppios::params::nrpe_service],
    content => "#File managed by puppet
allowed_hosts=${nagios_server_ip}",
  }

  service { "$puppios::params::nrpe_service":
    ensure  => running,
    require => Package[$puppios::params::nrpe_packages],
  }

  @@nagios_host { $fqdn:
    ensure  => present,
    alias   => $hostname,
    address => $ipaddress,
    use     => "generic-host",
  }

  @@nagios_hostextinfo { $fqdn:
    ensure          => present,
    icon_image_alt  => $os_downcase,
    icon_image      => "base/$os_downcase.png",
    statusmap_image => "base/$os_downcase.gd2",
  }

  @@nagios_service { "check_ping_${hostname}":
    use                 => "generic-service",
    service_description => "check_ping",
    check_command       => "check_ping!200.0,40%!400.0,80%",
    host_name           => "$fqdn",
  }
  include puppios::checks::auto

  puppios::checks::check_nrpe {"check_disk":
    command => "check_disk -w 20% -c 10% -l -x /dev -x /run/lock -x /run -x /run/shm -x /run/shm -x /sys/fs/cgroup -x /var/lib/os-prober/mount"
  }
  @@nagios_service { "check_disk_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_disk",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_disk",
  }


  @@nagios_service { "check_users_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_users",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_user",
  }


  @@nagios_service { "check_load_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_load",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_load",
  }

  @@nagios_service { "check_zombie_procs_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_zombie_procs",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_zombie_procs",
  }

  @@nagios_service { "check_total_procs_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_total_procs",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_total_procs",
  }
}

