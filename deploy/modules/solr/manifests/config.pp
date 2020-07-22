# @summary Full description of class solr here.
#
class solr::config {

  if $::osfamily == 'debian' {
    file { '/usr/java':
      ensure  => directory,
    }

    # setup a sym link for java home (TODO: FIX to not be hard coded)
    file { '/usr/java/default':
      ensure  => 'link',
      target  => '/usr/lib/jvm/java-8-openjdk-amd64',
      require => File['/usr/java'],
      before  => File[$::solr::solr_logs],
    }
  }

  # create the directories
  file { $::solr::solr_logs:
    ensure => directory,
    owner  => $solr::solr_user,
    group  => $solr::solr_user,
  }

  # After solr v 7.4.0 SOLR now uses log4j2.xml
  if versioncmp($solr::version, '7.4.0') >= 0 {
    # setup log4j2 configuration file.
    $logger_config_file = 'log4j2.xml'
    file { "${::solr::var_dir}/log4j2.xml":
      ensure  => file,
      owner   => 'solr',
      group   => 'solr',
      content => epp('solr/log4j2.xml.epp',{
        log4j_rootlogger_loglevel => $solr::log4j_rootlogger_loglevel,
        log4j_maxfilesize         => $solr::log4j_maxfilesize,
        log4j_maxbackupindex      => $solr::log4j_maxbackupindex,
      }),
    }
  } else {
    # setup log4j configuration file.
    $logger_config_file = 'log4j.properties'
    file { "${::solr::var_dir}/log4j.properties":
      ensure  => file,
      owner   => 'solr',
      group   => 'solr',
      content => epp('solr/log4j.properties.epp',{
        log4j_rootlogger_loglevel => $solr::log4j_rootlogger_loglevel,
        log4j_maxfilesize         => $solr::log4j_maxfilesize,
        log4j_maxbackupindex      => $solr::log4j_maxbackupindex,
      }),
    }
  }

  # setup default jetty configuration file.
  file { $::solr::solr_env:
    ensure  => file,
    content => epp('solr/solr.in.sh.epp',{
      java_home                       => $solr::java_home,
      solr_heap                       => $solr::solr_heap,
      zk_hosts                        => $solr::zk_hosts,
      solr_pid_dir                    => $solr::solr_pid_dir,
      solr_home                       => $solr::solr_home,
      var_dir                         => $solr::var_dir,
      solr_logs                       => $solr::solr_logs,
      solr_host                       => $solr::solr_host,
      solr_port                       => $solr::solr_port,
      logger_config_file              => $logger_config_file,
      solr_environment                => $solr::solr_environment,
      ssl_key_store                   => $solr::ssl_key_store,
      ssl_key_store_password          => $solr::ssl_key_store_password,
      ssl_trust_store                 => $solr::ssl_trust_store,
      ssl_trust_store_password        => $solr::ssl_trust_store_password,
      ssl_need_client_auth            => $solr::ssl_need_client_auth,
      ssl_want_client_auth            => $solr::ssl_want_client_auth,
      ssl_client_key_store            => $solr::ssl_client_key_store,
      ssl_client_key_store_password   => $solr::ssl_client_key_store_password,
      ssl_client_trust_store          => $solr::ssl_client_trust_store,
      ssl_client_trust_store_password => $solr::ssl_client_trust_store_password,
    }),
    require => File[$::solr::solr_logs],
  }

  # setup the service level entry
  if $::solr::params::is_systemd {
    include '::systemd'
    ::systemd::unit_file { 'solr.service':
      content => epp('solr/solr.service.epp',{
        solr_pid_dir => $solr::solr_pid_dir,
        solr_port    => $solr::solr_port,
        solr_bin     => $solr::solr_bin,
        solr_env     => $solr::solr_env,
      }),
      require => File[$::solr::solr_env],
    }

    # prevents confusion
    file { '/etc/init.d/solr':
      ensure => absent,
    }
  } else {
    file { '/etc/init.d/solr':
      ensure  => file,
      mode    => '0755',
      content => epp('solr/solr.sh.epp',{
        solr_bin  => $solr::solr_bin,
        solr_user => $solr::solr_user,
        solr_env  => $solr::solr_env,
      }),
      require => File[$::solr::solr_env],
    }
  }
}
