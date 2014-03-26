define puppios::target::generic_unmanaged(
  $unmanaged_name       = $title,
  $unmanaged_fqdn,
  $unmanaged_ipaddress,
  $unmanaged_operatingsystem
) {
  include puppios::params

  nagios_host { $unmanaged_fqdn:
    ensure  => present,
    alias   => $unmanaged_name,
    address => $unmanaged_ipaddress,
    use     => "generic-host",
    notify  => Service["${puppios::params::nagios_service}"]
  }

  nagios_hostextinfo { $unmanaged_fqdn:
    ensure          => present,
    icon_image_alt  => $unmanaged_operatingsystem,
    icon_image      => "base/$unmanaged_operatingsystem.png",
    statusmap_image => "base/$unmanaged_operatingsystem.gd2",
    notify  => Service["${puppios::params::nagios_service}"]
  }

  nagios_service { "check_ping_${unmanaged_name}":
    use                 => "generic-service",
    service_description => "Check ping ${unmanaged_name}",
    check_command       => "check_ping!200.0,40%!400.0,80%",
    host_name           => "$unmanaged_fqdn",
    notify              => Service["${puppios::params::nagios_service}"]
  }
}
