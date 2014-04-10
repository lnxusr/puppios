define puppios::checks::rabbitmq::check(
  ) {
  include puppios::params

  $nagios_check_name = 'rabbitmq'
  $nagios_check_files = ['check_rabbitmq_aliveness',
                         'check_rabbitmq_objects',
                         'check_rabbitmq_overview',
                         'check_rabbitmq_partition',
                         'check_rabbitmq_queue',
                         'check_rabbitmq_server',
                         'check_rabbitmq_shovels',
                         'check_rabbitmq_watermark']

define puppios::checks::rabbitmq::check::file() {
  file { $name : 
    path   => "$puppios::params::nagios_check_dir/$name",
    ensure => file,
    source => 'puppet:////modules/puppios/checks/$nagios_check_name/${name}',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}


  puppios::checks::rabbitmq::check::file {$nagios_check_files:
  }
}