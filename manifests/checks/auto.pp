class puppios::checks::auto(
) inherits puppios::params {

  #Check for classes

  #check for postgres class, if available add the check_postgres class
  if defined(Class['ib::db']) {
    include puppios::checks::check_postgres
    notify {"Postgres Yeeeaaahhh":}
  }

  #check for ntp class, if available add the check_ntp_time class
  if defined(Class['ntp']) {
    include puppios::checks::check_ntp_time
  }
}
