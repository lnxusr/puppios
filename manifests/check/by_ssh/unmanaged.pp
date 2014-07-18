class puppios::check::by_ssh::unmanaged(
 $options = {},
) {
  if $options != '' {
    create_resources("check::by_ssh::basic", $options)
  }
}
