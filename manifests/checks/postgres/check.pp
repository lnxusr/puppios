define puppios::checks::postgres::check(
  ) {
  include puppios::params
  include puppios::checks::postgres::params
  $servicegroups = ["Database","Postgres"]

  #define createGroups {
  #if ! defined(Nagios_servicegroup[$name]) {
  #  @@nagios_servicegroup {$name:
  #    ensure => present,}
  #  }
  #}
  #createGroups{ $servicegroups:}

  #create_resources('@@puppios::resource::service_group', $servicegroups)
  puppios::resource::auto_hostgroup {'postgres_auto':}
  package { "${puppios::checks::postgres::params::nagios_check_packages}":
    ensure => present,
  }

 # puppios::checks::check_nrpe {"check_postgres_database_size":
 #   command => "/usr/bin/check_postgres_database_size --warning='80 GB' --critical='90 GB'",
 #   runas   => "postgres",
 # }
  
  resource::service { "check_postgres_database_size_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_postgres_database_size",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_postgres_database_size",
      servicegroups       => join([$servicegroups],","),
  }
  
# checks::check_nrpe {"check_postgres_wal_files":
#   command => "/usr/bin/check_postgres_wal_files --critical=20",
#   runas   => "postgres",
# }
  resource::service { "check_postgres_wal_files_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_postgres_wal_files",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_postgres_wal_files",
      servicegroups       => join([$servicegroups],","),
  }
}