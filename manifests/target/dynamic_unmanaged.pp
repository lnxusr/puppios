define puppios::target::dynamic_puppios(
  $puppios_name       = $title,
  $puppios_fqdn,
  $puppios_ipaddress,
  $puppios_operatingsystem
) {
	nagios_host { $puppios_fqdn:
    ensure  => present,
    alias   => $puppios_name,
    address => $puppios_ipaddress,
    use     => "generic-host",
  }

  nagios_hostextinfo { $puppios_fqdn:
    ensure          => present,
    icon_image_alt  => $puppios_operatingsystem,
    icon_image      => "base/$puppios_operatingsystem.png",
    statusmap_image => "base/$puppios_operatingsystem.gd2",
  }
  notify{"The value is: ${services}": }
}