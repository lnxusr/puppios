class puppios::check::apt::auto {
  #check for ntp class, if available add the check_ntp_time class
  if $osfamily == 'Debian' {
    include puppios::check::apt::updates
  }
}