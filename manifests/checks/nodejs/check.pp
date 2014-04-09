define puppios::checks::nodejs::check(
  ) {
  include puppios::params
  puppios::resource::auto_hostgroup {'nodejs_auto':}
  }
}