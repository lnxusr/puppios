class puppios::checks::rabbitmq::auto(
  $check_level = 'Class'
  )
{
  case $check_level{
    'Class': {
      #check for rabbitmq class, if available add the puppios::checks::rabbitmq::check class
      if defined(Class['rabbitmq'])
        { 
          if ! defined(Checks::Rabbitmq::Checks["nagios_rabbitmq_${::fqdn}"]) {
          checks::rabbitmq::check {"nagios_rabbitmq_${::fqdn}":}
          include puppios::checks::rabbitmq::scripts

          puppios::checks::rabbitmq::server{"rabbitmq_server_${::fqdn}":
            rabbitmq_user     => $rabbitmq_user,
            rabbitmq_password => $rabbitmq_password
          }
        
          puppios::checks::rabbitmq::overview{"rabbitmq_overview_${::fqdn}":
            rabbitmq_user     => $rabbitmq_user,
            rabbitmq_password => $rabbitmq_password
          }

          puppios::checks::rabbitmq::objects{"rabbitmq_objects_${::fqdn}":
            rabbitmq_user     => $rabbitmq_user,
            rabbitmq_password => $rabbitmq_password
          }
        }
      }
      else{
        notify{"detected rabbitmq: Noooow":}
      }
    }
  }
}