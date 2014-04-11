class puppios::check::postgres::auto(
  $check_level = 'Class'
  )
{
  case $check_level{
    'Class': {
      #check for postgres class, if available add the puppios::check::postgres::check class
      if defined(Class['postgresql'])
      or defined(Class['ib::db'])    # Temporary hack for our specific needs!
        { 
          if ! defined(Puppios::Check::Postgres::Scripts["nagios_postgres_${::fqdn}"]) {
          include puppios::check::postgres::scripts

          puppios::check::postgres::wal_files{"postgres_wal_files_${::fqdn}":
          }

          puppios::check::postgres::database_size{"postgres_database_size_${::fqdn}":
          }
        }
      }
    }
  }
}