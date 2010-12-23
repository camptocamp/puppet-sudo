import "classes/*.pp"
import "definitions/*.pp"

class sudo {
  case $operatingsystem {
    default: { include sudo::base }
  }
}
