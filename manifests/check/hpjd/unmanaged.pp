class puppios::check::hpjd::unmanaged(
 $hpjd = {},
) {
  if $hpjd != '' {
    create_resources("check::hpjd::status", $hpjd)
  }
}
