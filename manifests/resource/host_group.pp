define puppios::resource::host_group(
  $hostgroup_name    = $name,
  $ensure            = present,
  $action_url        = undef,
  $alias             = undef,
  $group             = $puppios::params::file_group,
  $hostgroup_members = undef,
  $members           = undef,
  $mode              = $puppios::params::nagios_file_mode,
  $notes             = undef,
  $notes_url         = undef,
  $owner             = $puppios::params::nagios_file_owner,
  $provider          = undef,
  $realm             = undef,
  $register          = undef,
  $target            = undef,
  $use               = undef,
  )
  include puppios::params
  {
    if tagged(puppios::server) {
      $puppios_hostgroup = 'nagios_hostgroup'
    }
    else {
      $puppios_hostgroup = '@@nagios_hostgroup'
    }

  if ! defined(Nagios_hostgroup[$hostgroup_name]) {
    $puppios_hostgroup {$hostgroup_name:
      ensure            => $ensure,
      action_url        => $action_url,
      alias             => $alias,
      group             => $group,
      hostgroup_members => $hostgroup_members,
      members           => $members,
      mode              => $mode,             
      notes             => $notes,
      notes_url         => $notes_url,
      owner             => $owner,
      provider          => $provider,
      realm             => $realm,
      register          => $register,
      target            => $target,
      use               => $use,
    }
  }
}