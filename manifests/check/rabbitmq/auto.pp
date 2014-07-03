class puppios::check::rabbitmq::auto(
  $check_level                     = $puppios::check::rabbitmq::params::check_level,
  $rabbitmq_user                   = undef,
  $rabbitmq_password               = undef,
  $rabbitmq_root_directory         = $puppios::check::rabbitmq::params::rabbitmq_root_directory,
  $rabbitmq_server_executable_name = $puppios::check::rabbitmq::params::rabbitmq_server_executable_name

  )
  inherits puppios::check::rabbitmq::params
{
  case $check_level{
    'Class': {
      #check for rabbitmq class, if available add the puppios::check::rabbitmq::check class
      if defined(Class['rabbitmq'])
        { 
          if ! defined(Check::Rabbitmq::Checks["nagios_rabbitmq_${::fqdn}"]) {
          include puppios::check::rabbitmq::scripts

          puppios::check::rabbitmq::server{"rabbitmq_server_${::fqdn}":
            rabbitmq_user     => $rabbitmq_user,
            rabbitmq_password => $rabbitmq_password
          }
        
          puppios::check::rabbitmq::overview{"rabbitmq_overview_${::fqdn}":
            rabbitmq_user     => $rabbitmq_user,
            rabbitmq_password => $rabbitmq_password
          }

          puppios::check::rabbitmq::objects{"rabbitmq_objects_${::fqdn}":
            rabbitmq_user     => $rabbitmq_user,
            rabbitmq_password => $rabbitmq_password
          }
        }
      }
    }
    'File': {
      #Add a fact to facter
      exec { "add_puppios_fact_rabbitmq_server":
        command => '/bin/echo "rabbitmq_server=true" > /etc/facter/facts.d/puppios_rabbitmq_server.txt',
        creates => '/etc/facter/facts.d/puppios_rabbitmq_server.txt',
        onlyif  => "/usr/bin/find $rabbitmq_root_directory -type f -name \"$rabbitmq_server_executable_name\" | /bin/grep -e \'$rabbitmq_server_executable_name\'",
        require => File['/etc/facter/facts.d'],
      }
      #If it is a RabbitMQ server, add the checks
      if $rabbitmq_server ==  'true' {
          include puppios::check::rabbitmq::scripts

          puppios::check::rabbitmq::server{"rabbitmq_server_${::fqdn}":
            rabbitmq_user     => $rabbitmq_user,
            rabbitmq_password => $rabbitmq_password
          }
        
          puppios::check::rabbitmq::overview{"rabbitmq_overview_${::fqdn}":
            rabbitmq_user     => $rabbitmq_user,
            rabbitmq_password => $rabbitmq_password
          }

          puppios::check::rabbitmq::objects{"rabbitmq_objects_${::fqdn}":
            rabbitmq_user     => $rabbitmq_user,
            rabbitmq_password => $rabbitmq_password
          }
      }
    }
  }
}