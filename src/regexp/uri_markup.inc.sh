#!/bin/sh

uri_markup() {
  local B E URL R PUNCT
  readonly B='(^| )'
  readonly PUNCB='])}>.,;:!?'
  readonly PUNCE='-'
  readonly PUNCT="$PUNCB$PUNCE"
  readonly PUNCTS="$PUNCB $PUNCE"
  readonly U="([a-z.-]+://[^ ]*[^$PUNCTS])([$PUNCT]*)"
  readonly E='( |$)'
  readonly R='\1%3ca href=\"\3\"%3e\3%3c/a%3e\4\5'

  printf %s '<pre>'
  sed -r "
    s~%~&25~g
    s~&~\&amp;~g
    s~\"~\&quot;~g
    s~ ~  ~g
    s~($B<)$U(>$E)~$R~ig
    s~($B&quot;)$U(&quot;$E)~$R~ig
    s~($B\()$U(\)$E)~$R~ig
    s~($B\[)$U(\]$E)~$R~ig
    s~($B\{)$U(\}$E)~$R~ig
    s~($B')$U('$E)~$R~ig
    s~($B\`)$U(\`$E)~$R~ig
    s~($B)$U($E)~$R~ig
    s~<~\&lt;~g
    s~>~\&gt;~g
    s~%3c~<~g
    s~%3e~>~g
    s~%25~%~g
    s~  ~ ~g
  " "$@"
  echo '</pre>'
}
