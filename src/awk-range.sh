#!/bin/sh
main() {
  seq 1 9 |
  awk '
   /7/ { exit }
   y { print }
   /3/ { y=1 }
  '
}

main "$@"
