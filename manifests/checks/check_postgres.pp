class puppios::checks::check_postgres(
  ) inherits  puppios::params {

  package { "${puppios::params::nagios_check_postgres}":
    ensure => present,
  }

  puppios::checks::check_nrpe {"check_postgres_database_size":
    command => "/usr/bin/check_postgres_database_size --warning='50 GB' --critical='70 GB'",
    runas   => "postgres",
  }
  @@nagios_service { "check_postgres_database_size_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_postgres_database_size",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_postgres_database_size",
  }
  
  puppios::checks::check_nrpe {"check_postgres_wal_files":
    command => "/usr/bin/check_postgres_wal_files --critical=20",
    runas   => "postgres",
  }
  @@nagios_service { "check_postgres_wal_files_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_postgres_wal_files",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_postgres_wal_files",
  }
}
