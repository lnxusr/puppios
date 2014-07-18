class puppios::check::raid::auto(
  $check_level = $puppios::check::raid::params::check_level,
  )
  inherits puppios::check::raid::params
{
  case $check_level{
    'File': {
      #Add a fact to facter
      exec { "add_puppios_fact_hwraid_drive":
        command => '/bin/echo "hwraid_drive=true" > /etc/facter/facts.d/puppios_hwraid_drive.txt',
        creates => '/etc/facter/facts.d/puppios_hwraid_drive.txt',
        onlyif  => "/usr/bin/lspci | grep -i raid",
        require => File['/etc/facter/facts.d'],
      }
      #If it is a RabbitMQ server, add the checks
      if $hwraid_drive ==  'true' {
          puppios::check::raid::status{"raid_status_${::fqdn}":
          }
      }
    }
  }  
}
