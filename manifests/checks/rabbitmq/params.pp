class puppios::checks::rabbitmq::params {
  #Set global variables
  $rabbitmq_host              = ${hostname},
  $rabbitmq_port              = '15672',
  $rabbitmq_user              = 'guest',
  $rabbitmq_password          = 'guest',
  $rabbitmq_overview_warning  = '700,700,700',
  $rabbitmq_overview_critical = '1000,1000,1000'


   case $::osfamily {
    'Debian': {
      $rabbitmq_check_package = ['libwww-perl',
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