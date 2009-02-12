#!/bin/sh

cp -a test-data.original.txt test-data.out.txt
./col-diff-apply.sh < test-data.patch
