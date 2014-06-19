class puppios::check::linux::disk(
  $check_disk_warning  = '20%',
  $check_disk_critical = '10%',
  $check_disk_excludes = [
                           '/dev',
                           '/run/lock',
                           '/run',
                           '/run/shm',
                           '/sys/fs/cgroup',
                           '/var/lib/os-prober/mount',
                         ]
	) {

  if $check_disk_excludes != '' {
  	$check_disk_excludes_pre    = '-x '
    $check_disk_excludes_join   = join($check_disk_excludes, " -x ")
    $check_disk_excludes_string = "${check_disk_excludes_pre}${check_disk_excludes_join}"
  }

  puppios::check::nrpe::generic {"check_disk":
    command => "check_disk -w $check_disk_warning -c $check_disk_critical -l $check_disk_excludes_string"
  }

  @@nagios_service { "check_disk_${::fqdn}":
      check_command       => "check_nrpe_1arg!check_disk",
      use                 => "generic-service",
      host_name           => $::fqdn,
      service_description => "check_disk",
  }
}