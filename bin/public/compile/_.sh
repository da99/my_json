
# === {{CMD}}
compile () {
  cd "$THIS_DIR"
  crystal build json.cr/json.cr
  if [[ -x "json" ]]; then
    mkdir -p tmp
    mv -f json tmp/json
  fi
  sh_color GREEN "=== {{Created}}: tmp/json"
} # === end function
