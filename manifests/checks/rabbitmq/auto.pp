class puppios::checks::rabbitmq::auto(
  $check_level = 'Class'
  )
{
  notify{"detecting rabbitmq":}
  case $check_level{
    'Class': {
      #check for rabbitmq class, if available add the puppios::checks::rabbitmq::check class
      if defined(Class['rabbitmq'])
        { 
          notify{"detected rabbitmq: Yeahhh":}
          if ! defined(Checks::Rabbitmq::Checks["nagios_rabbitmq_${::fqdn}"]) {
          checks::rabbitmq::check {"nagios_rabbitmq_${::fqdn}":}
        }
      }
      else{
        notify{"detected rabbitmq: Noooow":}
      }
    }
  }
}