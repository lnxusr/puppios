class puppios::target::generic(
  $hostgroups = ['generic'],
  $ping_host  = true,
) inherits puppios::params {

  include puppios::check::auto

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

  file { '/etc/facter':
    ensure => directory,
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0755',
  }

  file { '/etc/facter/facts.d':
    ensure  => directory,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0755',
    require => File['/etc/facter'],
  }

  service { "$puppios::params::nrpe_service":
    ensure  => running,
    require => Package[$puppios::params::nrpe_packages],
  }

  @@nagios_host { $fqdn:
    ensure     => present,
    alias      => $hostname,
    address    => $ipaddress,
    use        => "generic-host",
    notes_url  => "https://$serverip/hosts/$::fqdn",
  }

  @@nagios_hostextinfo { $fqdn:
    ensure          => present,
    icon_image_alt  => $os_downcase,
    icon_image      => "base/$os_downcase.png",
    statusmap_image => "base/$os_downcase.gd2",
  }

  if $ping_host == true {
    @@nagios_service { "check_ping_${hostname}":
      use                 => "generic-service",
      service_description => "check_ping",
      check_command       => "check_ping!200.0,40%!400.0,80%",
      host_name           => "$fqdn",
    }
  }

}

