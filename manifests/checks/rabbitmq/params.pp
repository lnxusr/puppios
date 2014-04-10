class puppios::checks::rabbitmq::params {
   case $::osfamily {
    'Debian': {
      $libwww_perl_package = ['libwww-perl',
                              'libmath-calc-units-perl',
                              'libconfig-tiny-perl',
                              'libconfig-json-perl']
    }

    default: {
      fail(
        "Unsupported osfamily: ${::osfamily} operatingsystem:
         ${::operatingsystem}, check \'postgres\' currently
         only supports osfamily \'Debian\'")
    }
  }
}