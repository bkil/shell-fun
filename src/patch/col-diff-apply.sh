#!/bin/sh

main() {
  local TMP FILE HASH IPOS OPOS KEEP SKIP INSERT GOTHASH
  readonly TMP="`tempfile -p cold -s .col-diff.sh.txt.tmp 2>/dev/null || echo /tmp/$(date +%s).$$.col-diff.sh.txt.tmp`"
  while
    read -r FILE
    read -r HASH
    [ -f "$FILE" ] && [ -n "$HASH" ]
  do
    IPOS=0
    OPOS=0
    rm "$TMP" 2>/dev/null
    while
      read -r KEEP
      read -r SKIP
      read -r INSERT
      [ "0$KEEP" -ne 0 ] || [ "0$SKIP" -ne 0 ] || [ "0$INSERT" -ne 0 ]
    do
      dd bs=1 if="$FILE" skip="$IPOS" of="$TMP" seek="$OPOS" count="$KEEP" 2>/dev/null
      IPOS=$((IPOS+KEEP+SKIP))
      OPOS=$((OPOS+KEEP))

      dd bs=1 of="$TMP" seek="$OPOS" count="$INSERT" 2>/dev/null
      OPOS=$((OPOS+INSERT))
    done

    GOTHASH="`md5sum < "$TMP" | cut -d ' ' -f 1`"
    if [ "$GOTHASH" = "$HASH" ]; then
      if
        mv "$TMP" "$FILE"
      then
        echo "debug: patched $FILE" >&2
      else
        echo "error: failed to overwrite $FILE" >&2
      fi
    else
      echo "error: hash mismatch, not patching $FILE" >&2
    fi
  done
  rm "$TMP" 2>/dev/null
}

main "$@"
