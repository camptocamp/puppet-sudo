define sudo::directive (
  $ensure=present,
  $content="",
  $source=""
) {

  include sudo::params

  if versioncmp($sudo::params::majversion,'1.7.2') < 0 {

    common::concatfilepart {$name:
      ensure => $ensure,
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

    file {"/etc/sudoers.d/${name}":
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
      notify  => Exec["sudo-syntax-check"],
      require => Package["sudo"],
    }
  
  }

  exec {"sudo-syntax-check":
    command     => "visudo -c -f /etc/sudoers.d/${name} || ( rm -f /etc/sudoers.d/${name} && exit 1)",
    refreshonly => true,
  }

}
