#!/bin/sh

main() {
  random_hex |
  mask_mac_admin
}

random_hex() {
  dd bs=1 count=6 if=/dev/urandom 2>/dev/null |
  hexdump -v -e '/1 "%02X"'
}

mask_mac_admin() {
  sed -r "
    s~^(...)[013](.*)~\12\2~
    s~^(...)[457](.*)~\16\2~
    s~^(...)[89B](.*)~\1A\2~
    s~^(...)[CDF](.*)~\1E\2~
    s~^(..)(..)(..)(..)(..)(..)$~\1:\2:\3:\4:\5:\6~
    "
}

main "$@"
