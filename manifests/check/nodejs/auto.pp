class puppios::check::nodejs::auto(
  $check_level = 'Class'
  )
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
  }
}
