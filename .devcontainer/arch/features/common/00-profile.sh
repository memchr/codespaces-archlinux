#shellcheck disable=SC2148
prepend_path() {
    case ":$PATH:" in
    *:"$1":*)
        ;;
    *)
        PATH="$1:${PATH:+$PATH}"
    esac
}
_profile_loaded=1