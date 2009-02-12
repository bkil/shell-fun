#!/bin/sh

main() {
  local TMP FILE HASH IOFS OOFS KEEP SKIP INSERT GOTHASH
  readonly TMP="`tempfile -p cold -s .col-diff.sh.txt.tmp 2>/dev/null || echo /tmp/$(date +%s).$$.col-diff.sh.txt.tmp`"
  while read FILE; do
    read HASH
    IOFS=0
    OOFS=0
    rm "$TMP" 2>/dev/null
    while
      read KEEP
      read SKIP
      read INSERT
      ! [ "0$KEEP" -eq 0 ] || ! [ "0$SKIP" -eq 0 ] || ! [ "0$INSERT" -eq 0 ]
    do
      dd bs=1 if="$FILE" skip="$IOFS" of="$TMP" seek="$OOFS" count="$KEEP" 2>/dev/null
      IOFS=$((IOFS+KEEP+SKIP))
      OOFS=$((OOFS+KEEP))
      dd bs=1 of="$TMP" seek="$OOFS" count="$INSERT" 2>/dev/null
      OOFS=$((OOFS+INSERT))
    done

    GOTHASH="`md5sum < "$TMP" | cut -d ' ' -f 1`"
    if [ "$GOTHASH" = "$HASH" ]; then
      if
        mv "$TMP" "$FILE"
      then
        echo "debug: patched $FILE"
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
