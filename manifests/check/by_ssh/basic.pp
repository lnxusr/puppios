define puppios::check::by_ssh::basic(
	$by_ssh_user    = 'nagios-ssh',
	$by_ssh_nagioshost,
	$by_ssh_sshhost,
	$by_ssh_command = '',
  )
  {
  include puppios::params

  nagios_command { "check_by_ssh_${title}_$by_ssh_nagioshost":
    ensure       => 'present',
    command_line => "/usr/lib/nagios/plugins/check_by_ssh -H \'$by_ssh_sshhost\' -u $by_ssh_user -C \"$by_ssh_command\"",
    notify       => Service["${puppios::params::nagios_service}"]
  }

  nagios_service { "${title}":
    use                 => "generic-service",
    service_description => "Remote check by ssh ${title} $by_ssh_host",
    check_command       => "check_by_ssh_${title}_$by_ssh_nagioshost",
    host_name           => "$by_ssh_nagioshost",
    notify              => Service["${puppios::params::nagios_service}"]
  }

}
