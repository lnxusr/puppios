define puppios::target::dynamic_unmanaged(
  $puppios_fqdn,
  $puppios_ipaddress,
  $puppios_operatingsystem,
){
  include puppios::params

  nagios_host { "$puppios_fqdn":
    ensure  => present,
    alias   => $name,
    address => $puppios_ipaddress,
    use     => "generic-host",
    notify  => Service["${puppios::params::nagios_service}"]
  }
  nagios_hostextinfo { "$puppios_fqdn":
    ensure          => present,
    icon_image_alt  => $puppios_operatingsystem,
    icon_image      => "base/$puppios_operatingsystem.png",
    statusmap_image => "base/$puppios_operatingsystem.gd2",
    notify          => Service["${puppios::params::nagios_service}"]
  }
}
