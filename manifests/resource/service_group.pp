define puppios::resource::service_group(
  $servicegroup_name    = $title,
  $ensure               = present,
  $action_url           = undef,
  $alias                = undef,
  $group                = $puppios::params::file_group,
  $members              = undef,
  $mode                 = $puppios::params::nagios_file_mode,
  $notes                = undef,
  $notes_url            = undef,
  $owner                = $puppios::params::nagios_file_owner,
  $provider             = undef,
  $register             = undef,
  $servicegroup_members = undef,
  $target               = undef,
  $use                  = undef,
  )
  include puppios::params
  {

    if tagged(puppios::server) {
      $puppios_servicegroup = 'nagios_servicegroup'
    }
    else {
      $puppios_servicegroup = '@@nagios_servicegroup'
    }

  if ! defined(Nagios_hostgroup[$servicegroup_name]) {
    $puppios_servicegroup {$servicegroup_name:
      servicegroup_name    => $servicegroup_name,
      ensure               => $ensure,   
      action_url           => $action_url,
      alias                => $alias,
      group                => $group,
      members              => $members,
      mode                 => $mode,
      notes                => $notes,
      notes_url            => $notes_url,
      owner                => $owner,
      provider             => $provider,
      register             => $register,
      servicegroup_members => $servicegroup_members,
      target               => $target,
      use                  => $use,
    }
  }
}