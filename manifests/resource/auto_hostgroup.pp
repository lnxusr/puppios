define puppios::resource::auto_hostgroup(
  $groupname = $title,
  ){
  facts::fact {"${title}_${::fqdn}":
    content => $groupname,
    type    => 'hostgroup',
  }
}