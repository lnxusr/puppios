define puppios::check::postgres::database_size(
  $database_size_warning  = $puppios::check::postgres::params::database_size_warning,
  $database_size_critical = $puppios::check::postgres::params::database_size_warning
  ){
  include puppios::params
  include puppios::check::postgres::params

  puppios::check::check_nrpe {"check_postgres_database_size":
    command => "/usr/bin/check_postgres_database_size --warning=\'$database_size_warning\' --critical=\'$database_size_critical\'",
    runas   => "postgres",
  }
  
  resource::service { "check_postgres_database_size_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_postgres_database_size",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_postgres_database_size",
      servicegroups       => join([$servicegroups],","),
  }
}