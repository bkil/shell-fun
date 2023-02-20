#!/bin/sh
. `dirname $(readlink -f "$0")`/uri_markup.inc.sh

main() {
  test_data |
  run_tests
}

test_data() {
  cat << "EOF"
(http://test.example/?q=(http://test.example))
<pre>(<a href="http://test.example/?q=(http://test.example">http://test.example/?q=(http://test.example</a>))</pre>
ms-help://test.example/) hehe
<pre><a href="ms-help://test.example/">ms-help://test.example/</a>) hehe</pre>
<[{(hi http://test.example/hi.txt.,;:!?)}]>
<pre>&lt;[{(hi <a href="http://test.example/hi.txt">http://test.example/hi.txt</a>.,;:!?)}]&gt;</pre>
{http://test.example/hi.txt}
<pre>{<a href="http://test.example/hi.txt">http://test.example/hi.txt</a>}</pre>
`http://test.example/hi.txt`
<pre>`<a href="http://test.example/hi.txt">http://test.example/hi.txt</a>`</pre>
"http://test.example/hi.txt"
<pre>&quot;<a href="http://test.example/hi.txt">http://test.example/hi.txt</a>&quot;</pre>
<http://test.example/hi.txt>
<pre>&lt;<a href="http://test.example/hi.txt">http://test.example/hi.txt</a>&gt;</pre>
[http://test.example/hi.txt]
<pre>[<a href="http://test.example/hi.txt">http://test.example/hi.txt</a>]</pre>
x ftp://test.example/hi.txt y
<pre>x <a href="ftp://test.example/hi.txt">ftp://test.example/hi.txt</a> y</pre>
https://test.example/hi.txt, http://test.example/. http://test.invalid/?
<pre><a href="https://test.example/hi.txt">https://test.example/hi.txt</a>, <a href="http://test.example/">http://test.example/</a>. <a href="http://test.invalid/">http://test.invalid/</a>?</pre>
ok (https://test.example/hi.txt) ok
<pre>ok (<a href="https://test.example/hi.txt">https://test.example/hi.txt</a>) ok</pre>
x http://test.example/hi.txt http://test.invalid/ho.txt y
<pre>x <a href="http://test.example/hi.txt">http://test.example/hi.txt</a> <a href="http://test.invalid/ho.txt">http://test.invalid/ho.txt</a> y</pre>
EOF
}

run_tests() {
  local IN EXPECT GOT I FAIL
  {
    FAIL="0"
    while read IN; do
      read EXPECT
      I=$((I+1))

      GOT="`printf %s "$IN" | uri_markup`"
      if ! [ "$GOT" = "$EXPECT" ]; then
        printf "Failing test %d. Input:\n %s\n  expected:\n %s \n  got:\n %s\n" "$I" "$IN" "$EXPECT" "$GOT"
        FAIL=$((FAIL+1))
      fi
    done

    if [ "$FAIL" = "0" ]; then
      printf "All %d tests successful.\n" "$I"
      return 0
    else
      printf "Failed %d test(s) of %d.\n" "$FAIL" "$I"
      return 1
    fi
  }
}

main "$@"
