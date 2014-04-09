class puppios::resource::fact_config {
  File {
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
 
  file { '/etc/puppios': } ->
  file { '/etc/puppios/facts.d':
    recurse => true,
    purge   => true,
  }
}