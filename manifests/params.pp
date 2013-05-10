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
class nagios::params {

    #find os family and set variables. Only support for debian based systems for now.
    case $::osfamily {
        'Debian': {
            $server_package        = 'nagios3',
            $server_plugin_package = 'nagios-plugins',
            $nrpe_server_package   = 'nagios-nrpe-server',
            $nrpe_package          = 'nagios-nrpe-plugin',
            $configdir             = '/etc/nagios3',
        }
        default: {
            fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports osfamily RedHat and Debian")
        }
 }



}