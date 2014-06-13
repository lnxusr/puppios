class puppios::check::auto(
) inherits puppios::params {
  #include auto checks for the different nagios checks
  include puppios::check::nodejs::auto
  include puppios::check::ntp::auto
  include puppios::check::postgres::auto
  include puppios::check::rabbitmq::auto
  include puppios::check::linux::auto
  include puppios::check::ubuntu::auto
}
