define puppios::checks::rabbitmq::check(
  $rabbitmq_host = $hostname,
  $rabbitmq_user,
  $rabbitmq_password,
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
  checks::check_nrpe {"check_rabbitmq_server_$rabbitmq_host":
    command => "/usr/lib/nagios/plugins/check_rabbitmq_server -H \"$rabbitmq_host\" -u \"$rabbitmq_user\" -p \"$rabbitmq_password\" --port=\"15672\" --verbose",
  }
  resource::service { "check_rabbitmq_server_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_rabbitmq_server_$rabbitmq_host",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_rabbitmq_server",
      servicegroups       => join([$servicegroups],","),
  }
}