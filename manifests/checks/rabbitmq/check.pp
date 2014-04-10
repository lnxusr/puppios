define puppios::checks::rabbitmq::check(
  $rabbitmq_host     = $hostname,
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

  package {$puppios::checks::rabbitmq::params::rabbitmq_check_package:
    ensure => installed }

  puppios::resource::check_file {$nagios_check_files:
    nagios_check_name => 'rabbitmq',
    require           => Package[$puppios::checks::rabbitmq::params::rabbitmq_check_package]
  }

  puppios::checks::rabbitmq::server{"rabbitmq_server_${::fqdn}":
    rabbitmq_user     => $rabbitmq_user,
    rabbitmq_password => $rabbitmq_password
  }

  puppios::checks::rabbitmq::overview{"rabbitmq_overview_${::fqdn}":
    rabbitmq_user     => $rabbitmq_user,
    rabbitmq_password => $rabbitmq_password
  }

  checks::check_nrpe {"check_rabbitmq_objects_$rabbitmq_host":
    command => "/usr/lib/nagios/plugins/check_rabbitmq_objects -H \"$rabbitmq_host\" -u \"$rabbitmq_user\" -p \"$rabbitmq_password\" --port=\"15672\"",
  }

  resource::service { "check_rabbitmq_objects_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_rabbitmq_objects_$rabbitmq_host",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_rabbitmq_objects",
      servicegroups       => join([$servicegroups],","),
      puppios_managed     => true,
  }
}