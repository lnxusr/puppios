class puppios::check::ntp::check(
  ) inherits  puppios::params {

  puppios::check::check_nrpe {"check_ntp_time":
    command => "check_ntp_time -H ${ntp_server} -w 0.5 -c 1",
  }
  @@nagios_service { "check_ntp_time_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_ntp_time",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_ntp_time",
  }
}
