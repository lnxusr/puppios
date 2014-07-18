define puppios::check::raid::status ()
{
	puppios::check::nrpe::generic {"check_raid":
    command => 'check_raid',
    runas    => 'root',
  }

  @@nagios_service { "check_raid_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_raid",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_raid",
  }
}