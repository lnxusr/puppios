class puppios::check::linux::running_kernel {
  puppios::check::nrpe::generic {"check_running_kernel":
    command => "check_running_kernel",
    runas   => 'root',
  }
  @@nagios_service { "check_running_kernel_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_running_kernel",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_running_kernel",
  }
}