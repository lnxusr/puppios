class puppios::resource::facter {
  define fact ( $value = true ) {
    file { "/etc/puppios/facts.d/${title}.txt":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "${title}=${value}",
      require => Class['puppios::resource::fact_config'],
  }
}