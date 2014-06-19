class puppios::check::postgres::scripts(
  $ensure = 'present',
  ) inherits puppios::check::postgres::params
   {
  package { "${puppios::check::postgres::params::nagios_check_packages}":
    ensure => $ensure,
  }
}