#!/bin/bash

declare -r UNIT_TEST_PATHNAME="$1"

# Helper test suite
get_comments() {
  cat "${UNIT_TEST_PATHNAME}" | sed -n "/^$1() {$/,/}/p" | grep '#' | sed "s/^[ ]*//"
}

get_stdout() {
  echo "$1" | sed -n "/## stdout/,/##/p" | sed 1d | sed '$d' | sed 's/^# //'
}

get_stderr() {
  echo "$1" | sed -n "/## stderr/,/##/p" | sed 1d | sed '$d' | sed 's/^# //'
}

get_exit_status() {
  echo "$1" | grep '^## exit status' | sed 's/^## exit status //'
}

get_location() {
  echo "$1" | grep '^## location' | sed 's/^## location //'
}

# Import unit tests
source "$UNIT_TEST_PATHNAME"

init_test_suite

#trap '[[ $? -ne 0 ]] && clean_test_suite' EXIT

# Run unit tests
unit_tests=$(typeset -F | sed "s/declare -f //" | grep ^test_)

for unit_test in ${unit_tests}; do

  echo "Running unit test: ${unit_test} ..."

  init_test

  #trap '[[ $? -ne 0 ]] && clean_test' EXIT

  stdout=$(tempfile -p "bhist" -s "_${unit_test}.stdout")
  stderr=$(tempfile -p "bhist" -s "_${unit_test}.stderr")
  "${unit_test}" > "${stdout}" 2> "${stderr}"
  exit_status=$?
  location="${PWD}"

  comments=$(get_comments "${unit_test}")

  expected_stderr=$(get_stderr "${comments}")
  echo "expected stderr:"
  [[ -n "${expected_stderr}" ]] && echo "${expected_stderr}"
  echo "given stderr:"
  stderr=$(cat "${stderr}" | sed 's/^.*line [0-9]*: /bash: /')
  [[ -n "${stderr}" ]] && echo "${stderr}"
  if [[ "$(echo "${expected_stderr}")" == "$(echo "${stderr}")" ]]; then
    echo "--> stderr OK"
  else
    >&2 echo "--> stderr KO"
    exit 1
  fi

  expected_stdout=$(get_stdout "${comments}")
  echo "expected stdout:"
  [[ -n "${expected_stdout}" ]] && echo "${expected_stdout}"
  echo "given stdout:"
  cat "$stdout"
  if [[ "$(echo -n "${expected_stdout}")" == "$(cat "${stdout}")" ]]; then
    echo "--> stdout OK"
  else
    >&2 echo "--> stdout KO"
    exit 1
  fi

  expected_exit_status=$(get_exit_status "${comments}")
  echo "expected exit status: ${expected_exit_status}"
  echo "given exit status: ${exit_status}"
  if [[ "${expected_exit_status}" == "${exit_status}" ]]; then
    echo "--> exit status OK"
  else
    >&2 echo "--> exit status KO"
    exit 1
  fi

  expected_location=$(get_location "${comments}")
  echo "expected location: ${expected_location}"
  echo "given location: ${location}"
  if [[ "${expected_location}" == "${location}" ]]; then
    echo "--> location OK"
  else
    >&2 echo "--> location KO"
    exit 1
  fi

  echo

  clean_test

done

clean_test_suite
