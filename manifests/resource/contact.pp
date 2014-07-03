define puppios::resource::contact (
  $contact_name                   = $name,
  $cryptpasswd                    = undef,
  $ensure                         = present,
  $address1                       = undef,
  $address2                       = undef,
  $address3                       = undef,
  $address4                       = undef,
  $address5                       = undef,
  $address6                       = undef,
  $alias                          = undef,
  $can_submit_commands            = undef,
  $contactgroups                  = undef,
  $email                          = undef,
  $group                          = $puppios::params::nagios_file_group,
  $host_notification_commands     = 'notify-host-by-email',
  $host_notification_options      = 'd,u,r,f',
  $host_notification_period       = '24x7',
  $host_notifications_enabled     = undef,
  $mode                           = $puppios::params::nagios_file_mode,
  $owner                          = $puppios::params::nagios_file_owner,
  $pager                          = undef,
  $provider                       = undef,
  $register                       = undef,
  $retain_nonstatus_information   = undef,
  $retain_status_information      = undef,
  $service_notification_commands  = 'notify-service-by-email',
  $service_notification_options   = 'w,u,c,r,f',
  $service_notification_period    = '24x7',
  $service_notifications_enabled  = undef,
  $target                         = undef,
  $use                            = undef,
)
{
  include puppios::params

  $nagios_http_user_defaults = {
    'target'   => "$nagios_configdir/htpasswd.users",
    'notify'   => "Service[$puppios::params::nagios_service]",
  }

  $nagios_http_user = {
    "${name}" => {
      'ensure'      => "present",
      'cryptpasswd' => $cryptpasswd,
    }
  }

  nagios_contact { $contact_name:
    ensure                         => $ensure,
    address1                       => $address1,
    address2                       => $address2,
    address3                       => $address3,
    address4                       => $address4,
    address5                       => $address5,
    address6                       => $address6,
    alias                          => $alias ,
    can_submit_commands            => $can_submit_commands ,
    contactgroups                  => $contactgroups ,
    email                          => $email ,
    group                          => $group ,
    host_notification_commands     => $host_notification_commands,
    host_notification_options      => $host_notification_options ,
    host_notification_period       => $host_notification_period,
    host_notifications_enabled     => $host_notifications_enabled,
    mode                           => $mode,
    owner                          => $owner ,
    pager                          => $pager ,
    provider                       => $provider,
    register                       => $register,
    retain_nonstatus_information   => $retain_nonstatus_information,
    retain_status_information      => $retain_status_information ,
    service_notification_commands  => $service_notification_commands ,
    service_notification_options   => $service_notification_options,
    service_notification_period    => $service_notification_period ,
    service_notifications_enabled  => $service_notifications_enabled ,
    target                         => $target,
    use                            => $use ,
  }


  create_resources('htpasswd', $nagios_http_user, $nagios_http_user_defaults)
}