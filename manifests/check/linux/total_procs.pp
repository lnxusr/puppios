class puppios::check::linux::total_procs(
  $check_total_procs_warning  = '250',
  $check_total_procs_critical = '300',
)
{
	  puppios::check::nrpe::generic {"check_total_procs_$check_total_procs_critical":
    command => "check_procs -w $check_total_procs_warning -c $check_total_procs_critical"
  }
    @@nagios_service { "check_total_procs_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_total_procs_$check_total_procs_critical",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_total_procs",
  }
}