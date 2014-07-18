define puppios::resource::host_group(
# Trick to create duplcate exported resources only once.
# 'Found at'/'stolen from' James @ http://ttboj.wordpress.com/2013/06/04/collecting-duplicate-resources-in-puppet/
  $hostgroup_name    = $name,
  $ensure            = present,
  $action_url        = undef,
  $alias             = undef,
  $group             = $puppios::params::file_group,
  $hostgroup_members = undef,
  $members           = undef,
  $mode              = $puppios::params::nagios_file_mode,
  $notes             = undef,
  $notes_url         = undef,
  $owner             = $puppios::params::nagios_file_owner,
  $provider          = undef,
  $realm             = undef,
  $register          = undef,
  $target            = undef,
  $use               = undef,
  $allow_duplicates  = false,
) {
  if $allow_duplicates { # a non empty string is also a true
    # allow the user to specify a specific split string to use...
    $c = type($allow_duplicates) ? {
      'string' => "${allow_duplicates}",
      default => '#',
    }
    if "${c}" == '' {
      fail('Split character(s) cannot be empty!')
    }

    # split into $realname-$uid where $realname can contain split chars
    $realname = inline_template("<%= name.rindex('${c}').nil?? name : name.slice(0, name.rindex('${c}')) %>")
    $uid = inline_template("<%= name.rindex('${c}').nil?? '' : name.slice(name.rindex('${c}')+'${c}'.length, name.length-name.rindex('${c}')-'${c}'.length) %>")

    $params = { # this must use all the args as listed above...
      'ensure'             => $ensure,
      #action_url         => $action_url,
      #alias              => $alias,
      #group              => $group,
      #hostgroup_members  => $hostgroup_members,
      #members            => $members,
      #mode               => $mode,
      #notes              => $notes, 
      #notes_url          => $notes_url,
      #owner              => $owner,
      #provider           => $provider,
      #realm              => $realm,
      #register           => $register,
      #target             => $target,
      #use                => $use,
      }
    ensure_resource('nagios_hostgroup', "${realname}", $params)
    }
    else { # body of the actual resource...
      notify{"allow_duplicates_missing":}
    }
}