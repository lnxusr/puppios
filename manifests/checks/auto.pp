class puppios::checks::auto(
) inherits puppios::params {
  notify{"auto check rule!":}

  import '*/auto.pp'
}
