class puppios::check::rabbitmq::auto(
  $check_level = 'Class'
  )
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
  }
}