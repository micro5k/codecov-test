#!/usr/bin/env sh
# @name Device list downloader
# @brief It download the device list and convert it in the proper format
# @author ale5000
# Get the latest version from here: https://github.com/micro5k/microg-unofficial-installer/tree/main/utils

# SPDX-FileCopyrightText: (c) 2023 ale5000
# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileType: SOURCE

# shellcheck enable=all
# shellcheck disable=SC3043 # In POSIX sh, local is undefined

set -u
# shellcheck disable=SC3040,SC3041,SC2015
{
  # Unsupported set options may cause the shell to exit (even without set -e), so first try them in a subshell to avoid this issue
  (set -o posix 2> /dev/null) && set -o posix || true
  (set +H 2> /dev/null) && set +H || true
  (set -o pipefail 2> /dev/null) && set -o pipefail || true
}

set_utf8_codepage()
{
  if command 1> /dev/null -v 'chcp.com' && PREVIOUS_CODEPAGE="$(chcp.com 2> /dev/null | cut -d ':' -f '2-' -s | LC_ALL=C tr -d ' \r')" && test "${PREVIOUS_CODEPAGE?}" -ne 65001; then
    'chcp.com' 1> /dev/null 65001
  else
    PREVIOUS_CODEPAGE=''
  fi
}

restore_codepage()
{
  if test -n "${PREVIOUS_CODEPAGE-}"; then
    'chcp.com' 1> /dev/null "${PREVIOUS_CODEPAGE:?}"
    PREVIOUS_CODEPAGE=''
  fi
}

show_error()
{
  printf 1>&2 '\033[1;31m%s\033[0m\n' "ERROR: ${*}"
}

show_info()
{
  printf '\033[1;32m%s\033[0m\n' "${*}"
}

pause_if_needed()
{
  # shellcheck disable=SC3028 # In POSIX sh, SHLVL is undefined
  if test "${CI:-false}" = 'false' && test "${SHLVL:-}" = '1' && test -t 0 && test -t 1 && test -t 2; then
    printf 1>&2 '\n\033[1;32m%s\033[0m' 'Press any key to exit...' || true
    # shellcheck disable=SC3045
    IFS='' read 1>&2 -r -s -n 1 _ || true
    printf 1>&2 '\n' || true
  fi
}

contains()
{
  case "${2?}" in
    *"${1:?}"*) return 0 ;; # Found
    *) ;;
  esac
  return 1 # NOT found
}

iconv_compat()
{
  local _input_file _output_file _status

  _input_file="${1:?}"
  _output_file="${2:?}"
  shift 2

  if contains 'GNU libiconv' "$(iconv --version 2> /dev/null | head -n 1 -q || true)"; then
    # Limited version, -o is NOT available
    if test "${_output_file:?}" = "${_input_file:?}"; then
      iconv "${@}" -- "${_input_file:?}" 1> "${_output_file:?}.compat-temp" || return "${?}"
      mv -f -T -- "${_output_file:?}.compat-temp" "${_output_file:?}" || return "${?}"
    else
      iconv "${@}" -- "${_input_file:?}" 1> "${_output_file:?}" || return "${?}"
    fi
  else
    # -o is available
    iconv -o "${_output_file:?}" "${@}" -- "${_input_file:?}" || return "${?}"
  fi
}

readonly WGET_CMD='wget'
readonly DL_UA='Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101 Firefox/128.0'
readonly DL_ACCEPT_HEADER='Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8'
readonly DL_ACCEPT_LANG_HEADER='Accept-Language: en-US,en;q=0.5'

dl()
{
  "${WGET_CMD:?}" -q -O "${2:?}" -U "${DL_UA:?}" --header "${DL_ACCEPT_HEADER:?}" --header "${DL_ACCEPT_LANG_HEADER:?}" --no-cache -- "${1:?}" || return "${?}"
}

dl_and_convert_device_list()
{
  local _path _file _var

  # shellcheck disable=SC3028
  if test -n "${UTILS_DATA_DIR:-}"; then
    _path="${UTILS_DATA_DIR:?}"
  elif test -n "${BASH_SOURCE:-}" && _path="$(dirname "${BASH_SOURCE:?}")/data"; then # Expanding an array without an index gives the first element (it is intended)
    :
  elif test -n "${0:-}" && _path="$(dirname "${0:?}")/data"; then
    :
  else
    _path='./data'
  fi

  if mkdir -p "${_path:?}"; then
    _file="${_path:?}/device-list.csv"
  else
    return 1
  fi

  rm -f "${_file:?}-temp" || return "${?}"
  dl 'https://storage.googleapis.com/play_public/supported_devices.csv' "${_file:?}-temp" || return "${?}"

  iconv_compat "${_file:?}-temp" "${_file:?}-temp" -f 'UTF-16LE' -t 'UTF-8' || return "${?}"

  _var="$(printf '\342\200\235')"
  sed -i "s/${_var:?}/\"/g" "${_file:?}-temp" || return "${?}"

  if test "${SAVE_AS_UTF8}" = 'true'; then
    mv -f -T -- "${_file:?}-temp" "${_file:?}" || return "${?}"
  else
    iconv_compat "${_file:?}-temp" "${_file:?}" -c -f 'UTF-8' -t 'WINDOWS-1252//IGNORE' || return "${?}"
    rm -f "${_file:?}-temp" || return "${?}"
  fi
}

main()
{
  set_utf8_codepage

  if dl_and_convert_device_list; then
    show_info 'File downloaded correctly :)'
  else
    show_error 'Download failed!!!'
  fi

  restore_codepage
  pause_if_needed
}

readonly SAVE_AS_UTF8='true'
main
