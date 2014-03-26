define puppios::checks::check_resource(
 $options = {},
) {
  $hash = is_hash($options)
  notify{"The title is : $title": }
  notify{"The name is: $name": }
  notify{"is hash: $hash": }
  notify{"The options are: $options": }
  create_resources("puppios::checks::$title", $options)
}
