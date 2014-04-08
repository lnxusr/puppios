define puppios::checks::http::check(
  $http_fqdn,
  $http_host,
  $http_ssl,
  $http_url,
  $http_string,
  $http_timeout = '5',
  $http_expect = undef
  ) 
  {
  include puppios::params

  if $http_ssl == false {
    $command_variable_ssl = undef
  }
  elsif $http_ssl == true {
    $command_variable_ssl = '-S'
  }
  else {
    fail("$http_ssl not a correct value, please use bolean values")
  }

  if $http_expect == '' {
    $http_expect_command = '--expect="200 OK"'
  }
  else {
    $http_expect_command = "--expect=\"${http_expect}\""
  }

  if $http_string == '' {
    $http_string_command = ''
  }
  else {
    $http_string_command = "-s \"$http_string\""
  }

  $command_variable_string = "${http_string_command} ${http_expect_command}"

  nagios_command { "check_http_${title}":
    ensure       => 'present',
    command_line => "/usr/lib/nagios/plugins/check_http $command_variable_ssl -H \'$http_fqdn\' -u $http_url $command_variable_string",
    notify       => Service["${puppios::params::nagios_service}"]
  }
  nagios_service { "check_http_${title}":
    use                 => "generic-service",
    service_description => "Check http ${title} ${http_fqdn} for ${http_string}",
    check_command       => "check_http_${title}!200.0,40%!400.0,80%",
    host_name           => "$http_host",
    notify              => Service["${puppios::params::nagios_service}"]
  }
}