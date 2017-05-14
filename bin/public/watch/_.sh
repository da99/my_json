
# === {{CMD}} cr|py
watch () {
  cd "$THIS_DIR"

  case "$@" in
    cr|crystal)
      local +x CMD="my_json watch run cr"
      $CMD || :
      mksh_setup watch "-r bin -r specs -r json.cr"  "$CMD"
      return 0
      ;;

    py|python)
      local +x CMD="my_json watch run py"
      $CMD || :
      mksh_setup watch "-r bin -r specs -r json.py"  "$CMD"
      return 0
      ;;

    "run py")
      my_json spec py
      echo ""
      ;;

    "run cr")
      sh_color ORANGE "=== {{Compiling}}..."
      my_json compile
      my_json spec cr
      echo ""
      ;;

    *)
      sh_color RED "!!! {{Invalid options}}: $@"
      exit 2
      ;;
  esac
} # === end function

