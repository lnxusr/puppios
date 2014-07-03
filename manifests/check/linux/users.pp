class puppios::check::linux::users (
)
{
  @@nagios_service { "check_users_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_users",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_user",
  }
}