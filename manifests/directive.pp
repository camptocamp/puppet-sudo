define sudo::directive (
  $ensure  = present,
  $content = '',
  $source  = ''
) {

  # sudo skipping file names that contain a "."
  $dname = regsubst($name, '\.', '-', 'G')

  if versioncmp($::sudoversion,'1.7.2') >= 0 {

    file {"/etc/sudoers.d/${dname}":
      ensure  => $ensure,
      owner   => root,
      group   => root,
      mode    => '0440',
      content => $content ? {
        ''      => undef,
        default => $content,
      },
      source  => $source ? {
        ''      => undef,
        default => $source,
      },
      notify => $ensure ? {
        'present' => Exec["sudo-syntax-check for file ${dname}"],
        default   => undef,
      },
      require => Package['sudo'],
    }

  } else {

    fail 'sudo fragments via #includedir is only available since version 1.7.2!'

  }

  exec {"sudo-syntax-check for file ${dname}":
    command     => "visudo -c -f '/etc/sudoers.d/${dname}' || ( rm -f '/etc/sudoers.d/${dname}' && exit 1)",
    refreshonly => true,
  }

}
