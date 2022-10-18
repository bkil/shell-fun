#!/bin/sh

data() {
cat <<EOF
bob.bib
@article{ref
foo
bar
}
rob.bib
@article{raf
bar
baz
xyzzy
}
tod.bib
@article{rof
fum
}
EOF
}

data |
sed -n "
  s~{raf$~&~
  T end
  p
  :loop
  n
  s~}~&~
  p
  T loop
  :end
"
