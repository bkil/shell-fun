#!/bin/sh

pi() {
  Z="`printf "%018d" 0`"
  F="-3$Z"
  for K in `seq 1 4 19999`; do
    F=$((F + 4$Z/K - 4$Z/(K+2)))
  done
  printf "%.4f\n" "3.$F"
}

pi
