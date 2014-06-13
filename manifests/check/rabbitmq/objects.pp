define puppios::check::rabbitmq::objects(
  $rabbitmq_host     = $puppios::check::rabbitmq::params::rabbitmq_host,
  $rabbitmq_port     = $puppios::check::rabbitmq::params::rabbitmq_port,
  $rabbitmq_user     = $puppios::check::rabbitmq::params::rabbitmq_user,
  $rabbitmq_password = $puppios::check::rabbitmq::params::rabbitmq_password,
  ){

  puppios::check::nrpe::generic {"check_rabbitmq_objects_$rabbitmq_host":
    command => "/usr/lib/nagios/plugins/check_rabbitmq_objects -H \"$rabbitmq_host\" --port=\"$rabbitmq_port\" -u \"$rabbitmq_user\" -p \"$rabbitmq_password\"",
  }

  puppios::resource::service { "check_rabbitmq_objects_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_rabbitmq_objects_$rabbitmq_host",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_rabbitmq_objects",
      servicegroups       => join([$servicegroups],","),
      puppios_managed     => true,
  }
}
