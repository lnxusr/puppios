class puppios::check::postgres::params {
  #set global variables
  $database_size_warning  = '80 GB'
  $database_size_critical = '90 GB'
  $wal_files_warning      = '20'
  $wal_files_critical     = '30'

  case $::osfamily {
    'Debian': {
      $nagios_check_packages = 'check-postgres'
      $file_check            = '/etc/init.d/postgresql'
    }

    default: {
      fail(
        "Unsupported osfamily: ${::osfamily} operatingsystem:
         ${::operatingsystem}, check \'postgres\' currently
         only supports osfamily \'Debian\'")
    }
  }
}