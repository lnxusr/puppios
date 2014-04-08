define puppios::resource::check_command(
  $command_name = $name,
  $ensure       = present,
  $command_line = undef,
  $group        = $puppios::params::file_group,
  $mode         = undef,
  $owner        = $puppios::params::nagios_file_owner,
  $poller_tag   = undef,
  $provider     = undef,
  $target       = undef,
  $use          = undef,
  ){
  include puppios::params

  # Check required variables for values
  if $command_line == '' {
    fail('The service variable \'command_line\' cannot be empty')
  }

  # Check if the host is defined on a nagios server.
  # if so, don't export the resources but add them localy
  if tagged(puppios::server) {
    $puppios_command = 'nagios_command'
  }
  else {
    $puppios_command = '@@nagios_command'
  }
  if ! defined(nagios_command[$]) {
    $puppios_command {$command_name:
      command_name => $command_name,
      ensure       => $ensure,
      command_line => $command_line,
      group        => $group,
      mode         => $mode,
      owner        => $owner,
      poller_tag   => $poller_tag,
      provider     => $provider,
      target       => $target,
      use          => $use,
  }
}