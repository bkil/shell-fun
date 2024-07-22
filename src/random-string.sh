#!/bin/sh

LC_ALL=c sed -r ":loop; N; s/[^ -~]//g; t x; :x; s/^((..){128}).*/\1/; T loop; q" </dev/urandom
