class puppios::check::linux::zombie_procs (
)
{
  @@nagios_service { "check_zombie_procs_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_zombie_procs",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_zombie_procs",
  }
}