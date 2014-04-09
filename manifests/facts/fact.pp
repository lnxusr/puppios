define puppios::facts::fact(
  $type = undef,
){
    @@concat::fragment{ "$type_$title_${::fqdn}":
    target  => '/var/cache/puppios/facts.d/$type.list',
    content => $title,
    tag     => $type,
  }
}