class sudo (
  $config_file_replace = true,
) {

  validate_bool($config_file_replace)

  package {'sudo':
    ensure => 'present',
  }

  file {'/etc/sudoers':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0440',
  }

  # sudo fragments via #includedir is only available since version 1.7.2
  # /etc/sudoers content is therefore unmanaged on older systems by this
  # module. You should subclass this class to manage its content.
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

    if $config_file_replace {
      File ['/etc/sudoers'] { content => template('sudo/sudoers.erb'), }
    } else {
      augeas { 'includedirsudoers':
        changes => ['set /files/etc/sudoers/#includedir /etc/sudoers.d'],
        incl    => $config_file,
        lens    => 'FixedSudoers.lns',
      }
    }

  }

}
