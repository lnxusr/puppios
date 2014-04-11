class puppios::check::http::unmanaged(
 $basic = {},
) {
  if $basic != '' {}
    create_resources("check::http::basic", $basic)
  }
}