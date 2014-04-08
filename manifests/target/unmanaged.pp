class puppios::target::unmanaged(
  $hash
){
  create_resources('puppios::target::generic_unmanaged', $hash)
}