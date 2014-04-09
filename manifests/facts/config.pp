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
  concat { '/var/cache/puppios/facts.d/hostgroups.list':
    owner => 'root',
    group => 'root',
    mode  => '0644'
  }->
  concat::fragment{ 'hostgroups_header':
    target  => '/var/cache/puppios/facts.d/hostgroups.list',
    content => "\n##Puppios hostgroups\n\n",
    order   => '01'
  }
}