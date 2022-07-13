#!/bin/sh

echo '(wow) only (((more) hidden) (text)) this (haha)' |
sed -r '
  :loop
  s/\([^()]*\)//g
  t loop
  '
