define puppios::resource::check_file (
  $ensure             = 'present',
  $nagios_check_name
){
  
  file {$name:
    path   => "$puppios::params::nagios_check_dir/$name",
    ensure => $ensure,
    source => "puppet:///modules/puppios/checks/$nagios_check_name/${name}",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}