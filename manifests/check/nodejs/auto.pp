class puppios::check::nodejs::auto(
  $check_level                   = $puppios::check::nodejs::params::check_level,
  $nodejs_exec_directory         = $puppios::check::nodejs::params::nodejs_exec_directory,
  $nodejs_server_executable_name = $puppios::check::nodejs::params::nodejs_server_executable_name,
  )
  inherits puppios::check::nodejs::params
{
  case $check_level{
    'Class': {
      #check for nodejs class, if available add the puppios::check::nodejs::check class
      if defined(Class['nodejs'])
        { 
          if ! defined(Puppios::Check::Nodejs::Checks["nagios_nodejs_${::fqdn}"]) {
          puppios::check::nodejs::check {"nagios_nodejs_${::fqdn}":}
        }
      }
      else{
      }
    }
    'File': {
      #Add a fact to facter
      exec { "add_puppios_fact_nodejs_server":
        command => '/bin/echo "nodejs_server=true" > /etc/facter/facts.d/puppios_nodejs_server.txt',
        creates => '/etc/facter/facts.d/puppios_nodejs_server.txt',
        onlyif  => "/usr/bin/find $nodejs_exec_directory -type f -name \"$nodejs_server_executable_name\" | /bin/grep -e \'$nodejs_server_executable_name\'",
        require => File['/etc/facter/facts.d'],
      }
      #If it is a Nodejs server, add the checks
      if $rabbitmq_server ==  'true' {
          if ! defined(Puppios::Check::Nodejs::Checks["nagios_nodejs_${::fqdn}"]) {
          puppios::check::nodejs::check {"nagios_nodejs_${::fqdn}":}
        }
      }
    }
  }
}
