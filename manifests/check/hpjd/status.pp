define puppios::check::hpjd::status(
  $hpjd_status_ip,
  $hpjd_status_host,
  $hpjd_status_smtp_community = 'public'
  )
  {
  include puppios::params

  nagios_command { "check_hpjd_${title}":
    ensure       => 'present',
    command_line => "/usr/lib/nagios/plugins/check_hpjd -H \'$hpjd_status_ip\'",
    notify       => Service["${puppios::params::nagios_service}"]
  }

  nagios_service { "check_hpjd_${title}":
    use                 => "generic-service",
    service_description => "Check printer status ${title} ${hpjd_status_ip}",
    check_command       => "check_hpjd_${title}!-C $hpjd_status_smtp_community",
    host_name           => "$hpjd_status_host",
    notify              => Service["${puppios::params::nagios_service}"]
  }

  nagios_command { "check_printer_${title}":
    ensure       => 'present',
    command_line => "/usr/lib/nagios/plugins/check_printer \'$hpjd_status_ip\' $hpjd_status_smtp_community 10 5",
    notify       => Service["${puppios::params::nagios_service}"]
  }

  nagios_service { "check_printer_${title}":
    use                 => "generic-service",
    service_description => "Check printer supplies ${title} ${hpjd_status_ip}",
    check_command       => "check_printer_${title}!",
    host_name           => "$hpjd_status_host",
    notify              => Service["${puppios::params::nagios_service}"]
  }

}
