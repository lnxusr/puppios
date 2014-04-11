define check::check_resource(
 $options = {},
) {
  $hash = is_hash($options)
  create_resources("check::$plugin::$check", $options)
}
