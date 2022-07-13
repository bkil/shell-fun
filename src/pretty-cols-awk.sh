#!/bin/sh

printf %s "\
1 X12
2ab Y1234
3abcdef Z123
4abc U123456
" |
awk -vN=4 '
  {
    printf("%-" N+1 "s%-" N+1 "s\n", substr($1, 0, N), substr($2, 0, N));
  }
'
