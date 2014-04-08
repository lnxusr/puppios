class puppios::checks::postgress::auto(
  $check_level = 'Class'
  )
{
  case $check_level{
    'Class': {
      #check for postgres class, if available add the check_postgres class
      if defined(Class['postgresql'])
      or defined(Class['ib::db'])    # Temporary hack for our specific needs!
        { 
          if ! defined(Class['puppios::checks::postgres::checks']) {
          include puppios::checks::check_postgres
        }
      }
    }
  }
}