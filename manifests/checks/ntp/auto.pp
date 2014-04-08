class puppios::checks::ntp::auto{
  #check for ntp class, if available add the check_ntp_time class
  if defined(Class['ntp']) {
    if ! defined(Class['puppios::checks::ntp::check']) {
    include puppios::checks::ntp::check
    }
  }