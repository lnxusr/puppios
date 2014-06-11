class puppios::check::rabbitmq::scripts(
  $ensure = 'present'
)
inherits puppios::params
{
  include puppios::check::rabbitmq::params
  $nagios_check_name = 'rabbitmq'
  $nagios_check_files = ['check_rabbitmq_aliveness',
                         'check_rabbitmq_objects',
                         'check_rabbitmq_overview',
                         'check_rabbitmq_partition',
                         'check_rabbitmq_queue',
                         'check_rabbitmq_server',
                         'check_rabbitmq_shovels',
                         'check_rabbitmq_watermark']

  package {$puppios::check::rabbitmq::params::rabbitmq_check_package:
    ensure => $ensure,
  }

  puppios::resource::check_file {$nagios_check_files:
    ensure            => $ensure,
    nagios_check_name => 'rabbitmq',
    require           => Package[$puppios::check::rabbitmq::params::rabbitmq_check_package]
  }
}