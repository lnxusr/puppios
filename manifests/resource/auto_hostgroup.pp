define puppios::resource::auto_hostgroup(
  ){
  facts::fact {$title:
    type => 'hostgroup',
    }
}