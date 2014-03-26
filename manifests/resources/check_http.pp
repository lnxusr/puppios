#class to create resources based on puppios::target::generic_unmanaged for use with a puppet ENC (External Node Classifier).
# it  is teste !only! with "the foreman"

class puppios::resources::check_http (
  $hash_check_http
){

	create_resources('puppios::checks::check_http', $hash_check_http)
}
