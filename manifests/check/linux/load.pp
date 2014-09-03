class puppios::check::linux::load (
)

{
  $warn_5=($processorcount*0.7)
  $warn_10=($processorcount*0.6)
  $warn_15=($processorcount*0.5)
  $crit_5=($processorcount*0.9)
  $crit_10=($processorcount*0.8)
  $crit_15=($processorcount*0.7)

	@@nagios_service { "check_load_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_load!",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_load",
  }
}