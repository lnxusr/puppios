define puppios::checks::rabbitmq::objects(
  $rabbitmq_host     = $puppios::checks::rabbitmq::params::rabbitmq_host,
  $rabbitmq_port     = $puppios::checks::rabbitmq::params::rabbitmq_port,
  $rabbitmq_user     = $puppios::checks::rabbitmq::params::rabbitmq_user,
  $rabbitmq_password = $puppios::checks::rabbitmq::params::rabbitmq_password,
  ){

  checks::check_nrpe {"check_rabbitmq_objects_$rabbitmq_host":
    command => "/usr/lib/nagios/plugins/check_rabbitmq_objects -H \"$rabbitmq_host\" --port=\"$rabbitmq_port\" -u \"$rabbitmq_user\" -p \"$rabbitmq_password\"",
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