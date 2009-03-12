class sudo::base {
  package {"sudo":
    ensure => installed,
  }

  file {"/etc/sudoers":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 440,
  }
}
