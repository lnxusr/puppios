define puppios::checks::rabbitmq::(
  $rabbitmq_host     = $hostname,
  ) {
  include puppios::params
  include puppios::checks::rabbitmq::params

}