#!/bin/sh

echo iiiiiiiii |
sed -r '
  s/i$/  i/
  t next

  :loop
  s/([^ ]*) ([^ ]*)$/& \1\2/
  t next
  :next
  s/^i//
  t loop

  s/.* //
  '
