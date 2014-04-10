define puppios::checks::rabbitmq::server(
  $rabbitmq_host     = $puppios::checks::rabbitmq::params::rabbitmq_host,
  $rabbitmq_port     = $puppios::checks::rabbitmq::params::rabbitmq_port,
  $rabbitmq_user     = $puppios::checks::rabbitmq::params::rabbitmq_user,
  $rabbitmq_password = $puppios::checks::rabbitmq::params::rabbitmq_password,
  ){
  checks::check_nrpe {"check_rabbitmq_server_$rabbitmq_host":
    command => "/usr/lib/nagios/plugins/check_rabbitmq_server -H \"$rabbitmq_host\" --port=\"$rabbitmq_port\" -u \"$rabbitmq_user\" -p \"$rabbitmq_password\"",
  }
  resource::service { "check_rabbitmq_server_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_rabbitmq_server_$rabbitmq_host",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_rabbitmq_server",
      servicegroups       => join([$servicegroups],","),
      puppios_managed     => true,
  }
}