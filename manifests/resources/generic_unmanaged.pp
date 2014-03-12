#class to create resources based on puppios::target::generic_unmanaged for use with a puppet ENC (External Node Classifier).
# it  is teste !only! with "the foreman"

class puppios::resources::generic_unmanaged (
  $hash_generic_unmanaged
){

	create_resources('puppios::target::generic_unmanaged', $hash_generic_unmanaged)
}