class sudo::params {

  $release_version = $::operatingsystem ? {
    RedHat => $::lsbdistcodename ? {
      /^Nahant.*/        => '1.6.7',
      /Tikanga|Santiago/ => '1.7.2',
      default            => undef

    },
    Debian => $::lsbdistcodename ? {
      lenny   => '1.6.9',
      squeeze => '1.7.4',
      default => undef
    },
    Ubuntu => $::lsbdistcodename ? {
      lucid    => '1.7.4p4-3',
      default  => undef

    },
    CentOS => $::lsbmajdistrelease ? {
      5       => '1.7.2',
      6       => '1.7.2p2',
      default => undef

    },
    default   => undef

  }

  if !$::sudo_version {
    $version = "present"
    $majversion = $release_version
  } else {
    $majversion = $::sudo_version
    $version = $::sudo_version
  }

}
