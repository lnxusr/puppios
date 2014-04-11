class puppios::check::ntp::auto{
  #check for ntp class, if available add the check_ntp_time class
  if defined(Class['ntp']) {
    if ! defined(Class['puppios::check::ntp::check']) {
    include puppios::check::ntp::check
    }
  }
}