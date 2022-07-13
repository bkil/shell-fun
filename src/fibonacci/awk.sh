#!/bin/sh

echo 9 |
awk '
  {
    print f($1);
  }

  function f(n) {
    if (n < 2)
      return n;
    else
      return f(n-1) + f(n-2);
    }
  '
