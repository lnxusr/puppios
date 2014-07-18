class puppios::check::raid::params
inherits puppios::params {
  #Set global variables
   case $::osfamily {
    'Debian': {
      $check_level                     = 'File'
    }

    default: {
      fail(
        "Unsupported osfamily: ${::osfamily} operatingsystem:
         ${::operatingsystem}, check \'postgres\' currently
         only supports osfamily \'Debian\'")
    }
  }
}