define sudo::directive (
  $ensure  = present,
  $content = '',
  $source  = ''
) {

  fail( "The sudo::directive is deprecated and will be removed soon. Use sudo::conf instead" )

}
