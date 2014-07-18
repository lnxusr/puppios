define puppios::resource::host_group_array (
)
{
  $host_group_array_element = $name
  $hostgroups               += [$host_group_array_element]
      notify {"$host_group_array_element":}
  
}