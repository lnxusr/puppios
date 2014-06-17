define puppios::check::nrpe::generic(
  $command  ,
  $runas    = undef
  ){
  include puppios::params

  case $command {
    /^\/.*/: {
    $command_string = "$command"
    }
    default: {$command_string = "${puppios::params::nagios_check_dir}/${command}"}
  }

  if $runas == '' {
    $sudo_command = ''
  }
  else {
    $sudo_command_string = regsubst($command_string, '^([\/\w]*)(.*)','\1', 'G')
    $sudo_command = "/usr/bin/sudo -u $runas "
    file { "/etc/sudoers.d/${$name}":
      owner   => 'root',
      group   => 'root',
      mode    => '0440',
      content => "nagios ALL=(ALL) NOPASSWD:$sudo_command_string\n"
    }
  }


  file { "${puppios::params::nrpe_confdir}/$name.cfg":
    content => "command[${name}]=${sudo_command}${command_string}\n",
    require => Package[$puppios::params::nrpe_packages],
    notify  => Service[$puppios::params::nrpe_service],
  }
}

