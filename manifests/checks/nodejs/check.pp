define puppios::checks::nodejs::check(
  ) {
  include puppios::params
  resource::auto_hostgroup {'nodejs':
  }
}