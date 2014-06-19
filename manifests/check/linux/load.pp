class puppios::check::linux::load (
)
{
	@@nagios_service { "check_load_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_load",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_load",
  }
}