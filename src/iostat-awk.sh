#!/bin/sh

iostat 1 |
awk '
  {
    if (("sda" == $1) || ("nvme0n1" == $1)) {
      print $2 " " $3 " " $4;
    }
  }'
