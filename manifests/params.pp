# Class: nagios::params
#
#   The nagios configuration settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

# TODO: add real docs
class puppios::params {
  $puppet_webuser      = 'nagiosadmin'
  $puppet_webpassword  = undef


  # Find os family and set variables.
  # Only support for debian based systems for now.

  case $::osfamily {
    'Debian': {
      $server_packages       = ['nagios3',               #OS Packages for nagios server
                                'nagios-images',
                                'nagios-plugins',
                                'nagios-plugins-basic',
                                'nagios-plugins-extra',
                                'nagios-plugins-contrib',
                                'nagios-nrpe-plugin',
                                'nagios3-doc',
                                'nagiosgrapher',
                                'libnagios-plugin-perl',]
      $server_plugin_package = 'nagios-plugins'
      $nagios_configdir      = '/etc/nagios3'            #Filesystem location for default nagios config files
      $nagios_service        = 'nagios3'                 #Name of the nagios service
      $nagios_check_dir      = '/usr/lib/nagios/plugins' #Filesystem location for nagios checkscript
      $nagios_file_owner     = 'root'                    #System user for nagios files
      $nagios_file_group     = 'nagios'                  #System group for nagios files
      $nagios_file_mode      = '640'                     #Filesystem creation mode for nagios files

      #Variables for nagios nrpe system
      $nrpe_packages         = ['nagios-nrpe-server',    #OS Packages for nagios nrpe client
                                'nagios-plugins',
                                'nagios-plugins-basic',
                                'nagios-plugins-extra',
                                'nagios-plugins-contrib',
                                'libnagios-plugin-perl',]
      $nrpe_confdir          = '/etc/nagios/nrpe.d'      #Filesystem location for nrpe config files
      $nrpe_service          = 'nagios-nrpe-server'      #Name of nagios nrpe service

      #Variables for pnp4nagios
      $pnp4nag_packages      = ['pnp4nagios',            #OS packages for pnp4nagios system
                                'pnp4nagios-bin',
                                'pnp4nagios-web']
      $pnp4nag_confdir       = '/etc/pnp4nagios'         #Filesystem location for pnp4nagios config files

    }

    default: {
      fail(
        "Unsupported osfamily: ${::osfamily} operatingsystem:
         ${::operatingsystem}, module ${module_name} currently
         only supports osfamily \'Debian\'")
    }
  }
}
