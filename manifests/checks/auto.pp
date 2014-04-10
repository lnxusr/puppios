class puppios::checks::auto(
) inherits puppios::params {
  notify{"auto check rule!":}


  #include auto checks for
  include puppios::checks::nodejs::auto
  include puppios::checks::ntp::auto
  include puppios::checks::postgres::auto
  include puppios::checks::rabbitmq::auto
}