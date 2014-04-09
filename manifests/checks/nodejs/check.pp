define puppios::checks::nodejs::check(
  ) {
  include puppios::params
  @@concat::fragment{ "hostgroup_nodejs_${::fqdn}":
    target  => '/var/cache/puppios/facts.d/hostgroups.list',
    content => 'nodejs',
    tag     => 'hostgroup'
    #order   => '01'
  }
}