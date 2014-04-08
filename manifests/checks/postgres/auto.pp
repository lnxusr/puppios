class puppios::checks::postgress::auto(
  $check_level = 'Class'
  )
{
  notify{"detecting postgres":}
  case $check_level{
    'Class': {
      #check for postgres class, if available add the check_postgres class
      if defined(Class['postgresql'])
      or defined(Class['ib::db'])    # Temporary hack for our specific needs!
        { 
          notify{"detected postgres: Yeahhh":}
          if ! defined(Class['puppios::checks::postgres::checks']) {
          include puppios::checks::check_postgres
        }
      }
      else{
        notify{"detected postgres: Noooow":}
      }
    }
  }
}