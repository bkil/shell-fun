#!/bin/sh

echo '(wow) only (((more) hidden) (text)) this (haha)' |
sed -r "s/\
\([^()]*(\
\([^()]*(\
\([^()]*(\
\([^()]*\)\
[^()]*)*\)\
[^()]*)*\)\
[^()]*)*\)\
//g"
