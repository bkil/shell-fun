#!/bin/sh

iostat 1 |
sed -urn '
  s/^(nvme0n1|sda) +([^ ]+) +([^ ]+) +([^ ]+) .*$/\2 \3 \4/
  T e
  p
  :e
  '
