define puppios::check::rabbitmq::overview(
  $rabbitmq_host     = $puppios::check::rabbitmq::params::rabbitmq_host,
  $rabbitmq_port     = $puppios::check::rabbitmq::params::rabbitmq_port,
  $rabbitmq_user     = $puppios::check::rabbitmq::params::rabbitmq_user,
  $rabbitmq_password = $puppios::check::rabbitmq::params::rabbitmq_password,
  $rabbitmq_warning  = $puppios::check::rabbitmq::params::rabbitmq_overview_warning,
  $rabbitmq_critical = $puppios::check::rabbitmq::params::rabbitmq_overview_critical
  ){
  include puppios::check::rabbitmq::params
  puppios::check::check_nrpe {"check_rabbitmq_overview_$rabbitmq_host":
    command => "/usr/lib/nagios/plugins/check_rabbitmq_overview -H \"$rabbitmq_host\" -u \"$rabbitmq_user\" -p \"$rabbitmq_password\" --port=\"15672\" -c $rabbitmq_critical -w $rabbitmq_warning",
  }

  puppios::resource::service { "check_rabbitmq_overview_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_rabbitmq_overview_$rabbitmq_host",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_rabbitmq_overview",
      servicegroups       => join([$servicegroups],","),
      puppios_managed     => true,
  }
}