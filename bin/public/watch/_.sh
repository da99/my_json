
# === {{CMD}}
watch () {
  if [[ -z "$@" ]]; then
    mksh_setup watch "-r json.cr"  "my_json watch run"
    return 0
  fi

  case "$@" in
    run)
      my_json compile
      ;;

    *)
      sh_color RED "!!! {{Invalid options}}: $@"
      exit 2
      ;;
  esac
} # === end function

