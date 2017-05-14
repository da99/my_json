
    *.nhk.*)
      # Sometimes newlines are randomly included in the raw JSON output.
      # Even if you pipe this to tr, it will still output newlines for some reason.
      # So we save the entire output first (RAW), then delete newlines with tr.
      # Newlines in JSON will throw an error in Python.
      local +x RAW="$(curl --compressed --ssl -s "$URL")"
      set +o pipefail
      local +x JSON="$(echo "$RAW" | tr -d "\n")"
      set -o pipefail

      parse () {
        echo "$JSON" | python -c "import sys, json; sys.stdout.write( json.load(sys.stdin)['channel']['item'][$1]['title'] )"
      }

      if [[ -z "$JSON" ]]; then
        return 1
      fi

