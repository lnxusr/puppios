define puppios::resource::auto_hostgroup(
  $groupname = $title,
  ){
  facts::fact {"$title_${::fqdn}":
    content => $groupname,
    type    => 'hostgroup',
    }
}