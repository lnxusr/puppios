define puppios::check::postgres::wal_files (
  $wal_files_warning  = $puppios::check::postgres::params::wal_files_warning,
  $wal_files_critical = $puppios::check::postgres::params::wal_files_critical
  ){


 puppios::check::check_nrpe {"check_postgres_wal_files":
   command => "/usr/bin/check_postgres_wal_files -w $wal_files_warning -c $wal_files_critical",
   runas   => "postgres",
 }
  puppios::resource::service { "check_postgres_wal_files_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_postgres_wal_files",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_postgres_wal_files",
      servicegroups       => join([$servicegroups],","),
  }
}