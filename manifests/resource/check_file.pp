define puppios::resource::check_file (
){
  
  file {$name:
    path   => "$puppios::params::nagios_check_dir/$name",
    ensure => present,
    source => "puppet:///modules/puppios/checks/$nagios_check_name/${name}",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}