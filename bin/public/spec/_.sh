
# === {{CMD}}
spec () {
  cd "$THIS_DIR"
  sh_color ORANGE "=== Running {{specs}} ..."

  mkdir -p tmp
  mkdir -p progs

  local +x IFS=$'\n'
  for FILE in $(find ./specs -maxdepth 1 -mindepth 1 -type f -iname "*.sh"); do
    sh_color ORANGE -n "=== {{Spec}}: $FILE "
    "$FILE" tmp/json
  done
} # === end function
