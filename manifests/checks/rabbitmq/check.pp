define puppios::checks::rabbitmq::check(
  ) {
  include puppios::params
  include puppios::checks::rabbitmq::params

  $nagios_check_name = 'rabbitmq'
  $nagios_check_files = ['check_rabbitmq_aliveness',
                         'check_rabbitmq_objects',
                         'check_rabbitmq_overview',
                         'check_rabbitmq_partition',
                         'check_rabbitmq_queue',
                         'check_rabbitmq_server',
                         'check_rabbitmq_shovels',
                         'check_rabbitmq_watermark']

  package {$puppios::checks::rabbitmq::params::libwww_perl_package:
    ensure => installed }

  puppios::resource::check_file {$nagios_check_files:
    nagios_check_name => 'rabbitmq',
    require           => Package[$puppios::checks::rabbitmq::params::libwww_perl_package]
  }
}