class puppios::checks::postgres(
){
  puppios::checks::postgres::check{"nagios_postgres_${::fqdn}":
  }
}