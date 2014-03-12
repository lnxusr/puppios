define puppios::target::http_unmanaged(
  $unmanaged_host       = $title,
  $ssl                  = false,
  $unmanaged_operatingsystem
) {

  if $ssl = false {
    $command_variable_ssl = '',
  }
  elseif $ssl = true {
    $command_variable_ssl = '-S',
  }
  else {
    fail("$ssl not a correct value, please use bolean values")
  }

	nagios_host { $unmanaged_fqdn:
    ensure  => present,
    alias   => $unmanaged_name,
    address => $unmanaged_ipaddress,
    use     => "generic-host",
  }



  nagios_hostextinfo { $unmanaged_fqdn:
    ensure          => present,
    icon_image_alt  => $unmanaged_operatingsystem,
    icon_image      => "base/$unmanaged_operatingsystem.png",
    statusmap_image => "base/$unmanaged_operatingsystem.gd2",
  }

  nagios_service { "check_ping_${unmanaged_name}":
    use                 => "generic-service",
    service_description => "Check ping ${unmanaged_name}",
    check_command       => "check_ping!200.0,40%!400.0,80%",
    host_name           => "$unmanaged_fqdn",
  }
}