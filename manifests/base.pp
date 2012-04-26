class sudo::base {

  package {'sudo':
    ensure => 'present',
  }


  if versioncmp($::sudoversion,'1.7.2') < 0 {
    #
    # Backward compatibility for version less than 1.7.2
    #

    include concat::setup

    concat {'/etc/sudoers':
      owner   => root,
      group   => root,
      mode    => 660,
    }

    concat::fragment {'000-sudoers.init':
      ensure  => present,
      target  => '/etc/sudoers',
      content => template('sudo/sudoers.erb'),
    }

    # removed this folder originally created by common::concatfilepart
    file {'/etc/sudoers.d':
      ensure  => absent,
      purge   => true,
      recurse => true,
    }

  } else {
    #
    # Use the #includedir directive to manage sudoers.d, version >= 1.7.2
    #

    file {'/etc/sudoers':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0440',
      content => template('sudo/sudoers.erb'),
    }

    file {'/etc/sudoers.d':
      ensure  => directory,
      owner   => root,
      group   => root,
      mode    => '0755',
      purge   => true,
      recurse => true,
    }

  }

}
