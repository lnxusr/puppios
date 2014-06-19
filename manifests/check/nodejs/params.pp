class puppios::check::nodejs::params
inherits puppios::params {

	case $::osfamily {
    'Debian': {
      $check_level                   = 'File'
      $nodejs_exec_directory         = '/usr/bin'
      $nodejs_server_executable_name = 'nodejs'
      }

    default: {
      fail(
        "Unsupported osfamily: ${::osfamily} operatingsystem:
         ${::operatingsystem}, check \'postgres\' currently
         only supports osfamily \'Debian\'")
    }
  }
}