define puppios::resource::auto_hostgroup(
  $groupname = $title,
  ){
  ensure_resource('puppios::resource::host_group', $groupname, {'ensure' => 'present'})
}