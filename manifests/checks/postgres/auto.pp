class puppios::checks::postgres::auto(
  $check_level = 'Class'
  )
{
  notify{"detecting postgres":}
  case $check_level{
    'Class': {
      #check for postgres class, if available add the puppios::checks::postgres::check class
      if defined(Class['postgresql'])
      or defined(Class['ib::db'])    # Temporary hack for our specific needs!
        { 
          notify{"detected postgres: Yeahhh":}
          if ! defined(puppios::checks::postgres::checks["nagios_postgres_${::fqdn}"]) {
          puppios::checks::postgres::check {"nagios_postgres_${::fqdn}":}
        }
      }
      else{
        notify{"detected postgres: Noooow":}
      }
    }
  }
}