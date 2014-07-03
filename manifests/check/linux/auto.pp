class puppios::check::linux::auto{
  #check for ntp class, if available add the check_ntp_time class
  if $kernel == 'Linux' {
    include puppios::check::linux::running_kernel
    include puppios::check::linux::disk
    include puppios::check::linux::memory
    include puppios::check::linux::users
    include puppios::check::linux::total_procs
    include puppios::check::linux::load
    include puppios::check::linux::zombie_procs
    include puppios::check::linux::swap
  }
}