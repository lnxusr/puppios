class puppios::check::postgres::auto(
  $check_level               = $puppios::check::postgres::params::check_level,
  $pg_server_root_directory  = $puppios::check::postgres::params::pg_server_root_directory,
  $pg_server_executable_name = $puppios::check::postgres::params::pg_server_executable_name
  )
  inherits puppios::check::postgres::params
{
  case $check_level{
    'Class': {
      #check for postgres class, if available add the puppios::check::postgres::check class
      if defined(Class['postgresql'])
      or defined(Class['ibase::server'])    # Temporary hack for our specific needs!
        { 
          if ! defined(Puppios::Check::Postgres::Scripts["nagios_postgres_${::fqdn}"]) {
          include puppios::check::postgres::scripts

          puppios::check::postgres::wal_files{"postgres_wal_files_${::fqdn}":
          }

          puppios::check::postgres::database_size{"postgres_database_size_${::fqdn}":
          }
        }
      }
    }
    'File': {
      #Add a fact to facter
      exec { "add_puppios_fact_postgres_server":
        command => '/bin/echo "postgres_server=true" > /etc/facter/facts.d/puppios_postgres.txt',
        creates => '/etc/facter/facts.d/puppios_postgres.txt',
        onlyif  => "/usr/bin/find $pg_server_root_directory -type f -name \"$pg_server_executable_name\" | /bin/grep -e \'$pg_server_executable_name\'",
        require => File['/etc/facter/facts.d'],
      }
      #If it is a postgres server, add the checks
      if $postgres_server ==  'true' {
        include puppios::check::postgres::scripts

        @@puppios::resource::host_group {"postgres#${hostname}":
          allow_duplicates => '#',
        }

        @puppios::resource::host_group_array { "postgres":}

        #$puppios::target::generic::hostgroups += ['postgres','databse']
        puppios::check::postgres::wal_files{"postgres_wal_files_${::fqdn}":
        }

        puppios::check::postgres::database_size{"postgres_database_size_${::fqdn}":
        }
      }
    }
  }
}