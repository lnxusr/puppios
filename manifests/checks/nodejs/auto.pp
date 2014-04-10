class puppios::checks::nodejs::auto(
  $check_level = 'Class'
  )
{
  notify{"detecting nodejs":}
  case $check_level{
    'Class': {
      #check for nodejs class, if available add the puppios::checks::nodejs::check class
      if defined(Class['nodejs'])
        { 
          notify{"detected nodejs: Yeahhh":}
          if ! defined(Checks::Nodejs::Checks["nagios_nodejs_${::fqdn}"]) {
          checks::nodejs::check {"nagios_nodejs_${::fqdn}":}
        }
      }
      else{
        notify{"detected nodejs: Noooow":}
      }
    }
  }
}