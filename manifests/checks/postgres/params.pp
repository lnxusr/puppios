class puppios::checks::postgres::params {
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