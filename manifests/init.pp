class sudo {

  package {'sudo':
    ensure => 'present',
  }

  file {'/etc/sudoers':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0440',
  }

  if versioncmp($::sudoversion,'1.7.2') >= 0 {

    file {'/etc/sudoers.d':
      ensure  => directory,
      owner   => root,
      group   => root,
      mode    => '0755',
      purge   => true,
      recurse => true,
      force   => true,
    }

    File ['/etc/sudoers'] { content => template('sudo/sudoers.erb'), }

  } else {

    fail 'sudo fragments via #includedir is only available since version 1.7.2!'

  }

}
