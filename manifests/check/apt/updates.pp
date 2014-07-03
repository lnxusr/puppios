class puppios::check::apt::updates {
	puppios::check::nrpe::generic {"check_apt":
    command => "check_apt",
  }
  @@nagios_service { "check_apt_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_apt",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_apt",
  }
}