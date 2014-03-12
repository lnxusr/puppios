define puppios::target::check_http(
  $puppios_host       = $title,
  $http_ssl           = false,
  $http_url,
  $http_string,
) {

  if $ssl = false {
    $command_variable_ssl = '',
  }
  elseif $ssl = true {
    $command_variable_ssl = '-S',
  }
  else {
    fail("$ssl not a correct value, please use bolean values")
  }

  if $http_string = '' {
    $command_variable_string = ''
  }
  else {
    $command_variable_string = "-s $http_string"
  }

  nagios_command { "check_http${puppios_host}":
    ensure       => present,
    command_line => "/usr/lib/nagios/plugins/check_http $command_variable_ssl -H '$HOSTADDRESS$' -u $http_url $command_variable_string",
  }
  nagios_service { "check_http_${puppios_host}":
    use                 => "generic-service",
    service_description => "Check http ${puppios_host}",
    check_command       => "check_http!200.0,40%!400.0,80%",
    host_name           => "$puppios_fqdn",
  }
}