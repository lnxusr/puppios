define puppios::facts::fact(
  $type,
  $content
){
    @@concat::fragment{ "$type_$title":
    target  => "/var/cache/puppios/facts.d/$type.list",
    content => $content,
    tag     => $type,
  }
}