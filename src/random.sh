#!/usr/bin/env bash

get_random_below_n() {
  local N MOD ATTEMPT
  readonly N="$1"
  readonly MOD=$((32768 * 32768 % N))
  while true; do
    ATTEMPT=$((RANDOM * 32768 + RANDOM))
    [ "$ATTEMPT" -lt "$MOD" ] || break
  done
  echo $((ATTEMPT%N))
}

main() {
  local R
  readonly R="$(get_random_below_n 6)"
  echo $((1 + R))
}

main "$@"
