define puppios::checks::nodejs::check(
  ) {
  include puppios::params
  puppios::resource::auto_hostgroup {'postgres_auto':}

  }
}