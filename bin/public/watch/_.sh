
# === {{CMD}}
watch () {
  cd "$THIS_DIR"
  local +x CMD="my_json watch run"

  if [[ -z "$@" ]]; then
    $CMD
    mksh_setup watch "-r bin -r specs -r json.cr"  "$CMD"
    return 0
  fi

  case "$@" in
    run)
      sh_color ORANGE "=== {{Compiling}}..."
      my_json compile
      my_json spec
      echo ""
      ;;

    *)
      sh_color RED "!!! {{Invalid options}}: $@"
      exit 2
      ;;
  esac
} # === end function

