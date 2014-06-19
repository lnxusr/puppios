class puppios::check::linux::swap(
  $check_swap_warning  = '40%',
  $check_swap_critical = '25%',
)
{

  puppios::check::nrpe::generic {"check_swap":
    command => "check_swap -w $check_swap_warning -c $check_swap_critical"
  }

  @@nagios_service { "check_swap_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_swap",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_swap",
  }
}