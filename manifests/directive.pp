define sudo::directive (
  $ensure=present,
  $content="",
  $source=""
) {

  # sudo skipping file names that contain a "."
  $dname = regsubst($name, '\.', '-', 'G')

  if versioncmp($sudoversion,'1.7.2') < 0 {

    common::concatfilepart {$dname:
      ensure => $ensure,
      manage => true,
      file => "/etc/sudoers",
      content => $content ? {
        ""      => undef,
        default => $content,
      },
      source => $source ? {
        ""      => undef,
        default => $source,
      },
      require => Package["sudo"],
    }
  
  } else {

    file {"/etc/sudoers.d/${dname}":
      ensure  => $ensure,
      owner   => root,
      group   => root,
      mode    => 0440,
      content => $content ? {
        ""      => undef,   
        default => $content,
      },
      source  => $source ? {
        ""      => undef,  
        default => $source,
      },
      notify  => Exec["sudo-syntax-check for file $dname"],
      require => Package["sudo"],
    }
  
  }

  exec {"sudo-syntax-check for file $dname":
    command     => "visudo -c -f /etc/sudoers.d/${dname} || ( rm -f /etc/sudoers.d/${dname} && exit 1)",
    refreshonly => true,
  }

}
