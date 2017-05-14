
# === {{CMD}} cr|py
spec () {
  local +x BIN_TYPE="$1"
  cd "$THIS_DIR"
  sh_color ORANGE "=== Running {{specs}} ..."

  mkdir -p tmp
  mkdir -p progs

  case "$BIN_TYPE" in
    cr)
      local +x BIN=tmp/json
      ;;
    py)
      local +x BIN=json.py/_.py
      ;;
    *)
      ;;
  esac

  local +x IFS=$'\n'
  for FILE in $(find ./specs -maxdepth 1 -mindepth 1 -type f -iname "*.sh" | sort); do
    sh_color ORANGE -n "=== {{Spec}}: $FILE "
    "$FILE" "$BIN"
  done
} # === end function
