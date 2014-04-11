define puppios::check::http::basic(
  $http_basic_fqdn,
  $http_basic_host,
  $http_basic_ssl = false,
  $http_basic_url,
  $http_basic_string,
  $http_basic_timeout = '5',
  $http_basic_expect = '200 OK'
  )
  {
  include puppios::params

  if $http_basic_ssl == false {
    $command_variable_ssl = undef
  }
  elsif $http_basic_ssl == true {
    $command_variable_ssl = '-S'
  }
  else {
    fail("$http_basic_ssl not a correct value, please use bolean values")
  }

  $http_expect_command = "--expect=\"${http_basic_expect}\""

  if $http_basic_string == '' {
    $http_basic_string_command = ''
  }
  else {
    $http_basic_string_command = "-s \"$http_basic_string\""
  }

  $command_variable_string = "${http_basic_string_command} ${http_expect_command}"

  nagios_command { "check_http_${title}":
    ensure       => 'present',
    command_line => "/usr/lib/nagios/plugins/check_http $command_variable_ssl -H \'$http_basic_fqdn\' -u $http_basic_url $command_variable_string",
    notify       => Service["${puppios::params::nagios_service}"]
  }
  nagios_service { "check_http_${title}":
    use                 => "generic-service",
    service_description => "Check http ${title} ${http_basic_fqdn} for ${http_basic_string}",
    check_command       => "check_http_${title}!200.0,40%!400.0,80%",
    host_name           => "$http_basic_host",
    notify              => Service["${puppios::params::nagios_service}"]
  }
}