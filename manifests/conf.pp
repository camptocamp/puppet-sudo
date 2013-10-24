# Define: sudo::conf
#
# The target is to use https://github.com/saz/puppet-sudo module from were this
# definition was copied from instead of our.
#
# the $sudo_config_dir was removed, as we don't support it.
#
define sudo::conf(
  $ensure = present,
  $priority = 10,
  $content = undef,
  $source = undef,
) {

  # Call our sudo::directive with the right parameters
  sudo::directive{ "${priority}_${name}":
    ensure  => $ensure,
    content => $content,
    source  => $source,
  }

}
