class puppios::checks::http(
  $hash
){
  create_resources("${name}::check", $hash)
}