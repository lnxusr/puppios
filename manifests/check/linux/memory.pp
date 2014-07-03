class puppios::check::linux::memory(
	$check_memory_warning  = '10%',
	$check_memory_critical = '5%',
	)
{
	  puppios::check::nrpe::generic {"check_memory":
    command => "check_memory -w $check_memory_warning -c $check_memory_critical"
  }

  @@nagios_service { "check_memory_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_memory",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_memory",
  }
}