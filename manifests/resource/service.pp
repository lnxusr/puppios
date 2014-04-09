define puppios::resource::service(
  $puppios_managed              = false,
  $_naginator_name              = $name,
  $ensure                       = present,
  $action_url                   = undef,
  $active_checks_enabled        = undef,
  $business_impact              = undef,
  $check_command                = undef,
  $check_freshness              = undef,
  $check_interval               = undef,
  $check_period                 = undef,
  $contact_groups               = undef,
  $contacts                     = undef,
  $display_name                 = undef,
  $event_handler                = undef,
  $event_handler_enabled        = undef,
  $failure_prediction_enabled   = undef,
  $first_notification_delay     = undef,
  $flap_detection_enabled       = undef,
  $flap_detection_options       = undef,
  $freshness_threshold          = undef,
  $group                        = $puppios::params::nagios_file_group,
  $high_flap_threshold          = undef,
  $host_name                    = undef,
  $hostgroup_name               = undef,
  $icon_image                   = undef,
  $icon_image_alt               = undef,
  $initial_state                = undef,
  $is_volatile                  = undef,
  $low_flap_threshold           = undef,
  $max_check_attempts           = undef,
  $mode                         = undef,
  $normal_check_interval        = undef,
  $notes                        = undef,
  $notes_url                    = undef,
  $notification_interval        = undef,
  $notification_options         = undef,
  $notification_period          = undef,
  $notifications_enabled        = undef,
  $obsess_over_service          = undef,
  $owner                        = $puppios::params::nagios_file_owner,
  $parallelize_check            = undef,
  $passive_checks_enabled       = undef,
  $poller_tag                   = undef,
  $process_perf_data            = undef,
  $provider                     = undef,
  $register                     = undef,
  $retain_nonstatus_information = undef,
  $retain_status_information    = undef,
  $retry_check_interval         = undef,
  $retry_interval               = undef,
  $service_description          = undef,
  $servicegroups                = undef,
  $stalking_options             = undef,
  $target                       = undef,
  $use                          = 'generic-service',
  )
{
  include puppios::params

  # Check required variables for values
  if $check_command == '' {
    fail('The service variable \'check_command\' cannot be empty')
  }
  if $host_name == '' {
    fail('The service variable \'host_name\' cannot be empty')
  }
  if $service_description == '' {
    fail('The service variable \'service_description\' cannot be empty')
  }

  ## Check if a service group or multiple service groups are defined
  ## If so, check if it exists if not create a simple service group
  ## also, join the array
  #if $servicegroups != '' {
  #  define createGroups {
  #    if ! defined(Nagios_servicegroup[$name]) {
  #      @@nagios_servicegroup {$name:
  #        ensure => present,
  #      }
  #    }
  #  } 
  #  createGroups{ $servicegroups:}
#
  #  if is_array($servicegroups) {
  #    $groupstring = join([$servicegroups],","),
  #  }
  #  else {
  #    $groupstring = $servicegroups
  #  }
  #}

  # Check if the host is defined on a nagios server.
  # if so, don't export the resources but add them localy
  if tagged(puppios::server) {
    $puppios_service = 'nagios_service'
  }
  else {
    $puppios_service = '@@nagios_service'
  }

#  if ! defined(nagios_service[$]) {
    @@nagios_service {$_naginator_name:
      ensure                       => $ensure,
      action_url                   => $action_url,
      active_checks_enabled        => $active_checks_enabled,
      business_impact              => $business_impact,
      check_command                => $check_command,
      check_freshness              => $check_freshness,
      check_interval               => $check_interval,
      check_period                 => $check_period,
      contact_groups               => $contact_groups,
      contacts                     => $contacts,
      display_name                 => $display_name,
      event_handler                => $event_handler,
      event_handler_enabled        => $event_handler_enabled,
      failure_prediction_enabled   => $failure_prediction_enabled,
      first_notification_delay     => $first_notification_delay,
      flap_detection_enabled       => $flap_detection_enabled,
      flap_detection_options       => $flap_detection_options,
      freshness_threshold          => $freshness_threshold,
      group                        => $group,
      high_flap_threshold          => $high_flap_threshold,
      host_name                    => $host_name,
      hostgroup_name               => $hostgroup_name,
      icon_image                   => $icon_image,
      icon_image_alt               => $icon_image_alt,
      initial_state                => $initial_state,
      is_volatile                  => $is_volatile,
      low_flap_threshold           => $low_flap_threshold,
      max_check_attempts           => $max_check_attempts,
      mode                         => $mode,
      normal_check_interval        => $normal_check_interval,
      notes                        => $notes,
      notes_url                    => $notes_url,
      notification_interval        => $notification_interval,
      notification_options         => $notification_options,
      notification_period          => $notification_period,
      notifications_enabled        => $notifications_enabled,
      obsess_over_service          => $obsess_over_service,
      owner                        => $owner,
      parallelize_check            => $parallelize_check,
      passive_checks_enabled       => $passive_checks_enabled,
      poller_tag                   => $poller_tag,
      process_perf_data            => $process_perf_data,
      provider                     => $provider,
      register                     => $register,
      retain_nonstatus_information => $retain_nonstatus_information,
      retain_status_information    => $retain_status_information,
      retry_check_interval         => $retry_check_interval,
      retry_interval               => $retry_interval,
      service_description          => $service_description,
      servicegroups                => $groupstring,
      stalking_options             => $stalking_options,
      target                       => $target,
      use                          => $use,
    }  
#  }
}