class puppios::check::rabbitmq::params
inherits puppios::params {
  #Set global variables
  $rabbitmq_host              = $hostname
  $rabbitmq_port              = '15672'
  $rabbitmq_overview_warning  = '700,700,700'
  $rabbitmq_overview_critical = '1000,1000,1000'

   case $::osfamily {
    'Debian': {
      $rabbitmq_check_package          = ['libwww-perl',
                                         'libmath-calc-units-perl',
                                         'libconfig-tiny-perl',
                                         'libconfig-json-perl']
      $check_level                     = 'File'
      $rabbitmq_root_directory         = '/usr/lib/rabbitmq/lib/rabbitmq_server-*'
      $rabbitmq_server_executable_name = 'rabbitmq-server'
    }

    default: {
      fail(
        "Unsupported osfamily: ${::osfamily} operatingsystem:
         ${::operatingsystem}, check \'postgres\' currently
         only supports osfamily \'Debian\'")
    }
  }
}