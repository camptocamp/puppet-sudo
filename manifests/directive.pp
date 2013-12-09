define sudo::directive (
  $ensure  = present,
  $content = '',
  $source  = ''
) {

  notify{ "The sudo::directive is deprecated and will be removed soon. Use sudo::conf instead": }

  # Call our sudo::conf with the right parameters
  sudo::conf{ "${name}":
    ensure  => $ensure,
    content => $content,
    source  => $source,
  }

}
