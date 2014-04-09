class puppios::facts::config {
  File {
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
 
  file { '/var/cache/puppios': }->
  file { '/var/cache/puppios/facts.d':
    recurse => true,
    purge   => true,
  }->
  concat { '/var/cache/puppios/facts.d/hostgroup.list':
    owner          => 'root',
    group          => 'root',
    mode           => '0644',
    ensure_newline => true,
  }
  concat::fragment{ 'hostgroups_header':
    target  => '/var/cache/puppios/facts.d/hostgroup.list',
    content => "##Puppios hostgroups\n\n",
    order   => '01'
  }

  Concat::Fragment <<| tag == 'hostgroup' |>>
}