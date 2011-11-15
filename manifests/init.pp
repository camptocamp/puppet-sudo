class sudo {
  case $operatingsystem {
    default: { include sudo::base }
  }
}
