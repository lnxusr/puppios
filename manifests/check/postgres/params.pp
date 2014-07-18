class puppios::check::postgres::params
inherits puppios::params {
  #set global variables
  $database_size_warning  = '90 GB'
  $database_size_critical = '100 GB'
  $wal_files_warning      = '20'
  $wal_files_critical     = '30'

  case $::osfamily {
    'Debian': {
      $nagios_check_packages     = 'check-postgres'
      $file_check                = '/etc/init.d/postgresql'
      $pg_server_root_directory  = '/usr/lib/postgresql'
      $pg_server_executable_name = 'postgres'
      $check_level               = 'File'
    }

    default: {
      fail(
        "Unsupported osfamily: ${::osfamily} operatingsystem:
         ${::operatingsystem}, check \'postgres\' currently
         only supports osfamily \'Debian\'")
    }
  }
}
