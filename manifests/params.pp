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
      $server_packages       = ['nagios3',
                                'nagios-images',
                                'nagios-plugins',
                                'nagios3-doc',
                                'nagios-nrpe-plugin',
                                'nagiosgrapher']
      $server_plugin_package = 'nagios-plugins'
      $nagios_configdir      = '/etc/nagios3'
      $nagios_service        = 'nagios3'
      $nagios_check_dir      = '/usr/lib/nagios/plugins'

      #Variables for nagios nrpe system
      $nrpe_packages         = ['nagios-nrpe-server',
                                'nagios-plugins-basic',
                                'nagios-plugins',
                                'nagios-plugins-extra']
      $nrpe_confdir          = '/etc/nagios/nrpe.d'
      $nrpe_service          = 'nagios-nrpe-server'

      #Variables for pnp4nagios
      $pnp4nag_packages      = ['pnp4nagios',
                                'pnp4nagios-bin',
                                'pnp4nagios-web']
      $pnp4nag_confdir       = '/etc/pnp4nagios'

      #Variables for 'check' classes
      $nagios_check_postgres = 'check-postgres'
    }

    default: {
      fail(
        "Unsupported osfamily: ${::osfamily} operatingsystem:
         ${::operatingsystem}, module ${module_name} currently
         only supports osfamily Debian")
    }
  }
}
