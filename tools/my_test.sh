get_shell_exe()
{
  local _gse_shell_exe _gse_tmp_var

  if _gse_shell_exe="$(readlink 2> /dev/null "/proc/${$}/exe")" && test -n "${_gse_shell_exe}"; then
    # On Linux / Android / Windows (on Windows only some shells support it)
    printf '%s\n' "${_gse_shell_exe}"
    return 0
  elif _gse_tmp_var="$(ps 2> /dev/null -p "${$}" -o 'comm=')" && test -n "${_gse_tmp_var}" && _gse_tmp_var="$(command 2> /dev/null -v "${_gse_tmp_var}")"; then
    # On Linux / macOS
    # shellcheck disable=SC2230 # Ignore: 'which' is non-standard
    case "${_gse_tmp_var}" in *'/'* | *"\\"*) ;; *) _gse_tmp_var="$(which 2> /dev/null "${_gse_tmp_var}")" || return 3 ;; esac # We may not get the full path with "command -v" on some old versions of Oils
  elif _gse_tmp_var="${BASH:-${SHELL-}}" && test -n "${_gse_tmp_var}"; then
    if test "${_gse_tmp_var}" = '/bin/sh' && test "$(uname 2> /dev/null || :)" = 'Windows_NT'; then _gse_tmp_var="$(command 2> /dev/null -v 'busybox')" || return 2; fi
    if test ! -x "${_gse_tmp_var}" && test -x "${_gse_tmp_var}.exe"; then _gse_tmp_var="${_gse_tmp_var}.exe"; fi # Special fix for broken versions of Bash under Windows
  else
    return 1
  fi

  _gse_shell_exe="$(readlink 2> /dev/null -f "${_gse_tmp_var}" || realpath 2> /dev/null "${_gse_tmp_var}")" || _gse_shell_exe="${_gse_tmp_var}"
  printf '%s\n' "${_gse_shell_exe}"
  return 0
}

get_shell_exe
