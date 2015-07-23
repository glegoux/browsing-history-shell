#!/bin/bash
#
# test_suite.sh

declare -r UNIT_TEST_PATHNAME="$1"
declare -ar FUNCTIONS=(init_test_suite clean_test_suite init_test clean_test)

# Helper test suite

usage() {
  echo "Usage:"
}

die() {

  >&2 echo "ERROR: $1 !"
  exit 1

}


check_functions() {

  for f in ${FUNCTIONS[*]}; do
    declare -F "$f" > /dev/null || die "'$0', no implementation in $UNIT_TEST_PATHNAME for $f"
  done

}


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


clean_test_suite_verbose() {

  local is_ko="${1-false}"
  echo "Cleaning test suite ..."
  clean_test_suite
  echo
  if "$is_ko"; then
    echo "--> Latest unit test KO."
  else
    echo "--> All unit tests OK."
  fi

}


clean_test_verbose() {

  echo
  local unit_test="$1"
  local is_ko="${2-false}"
  echo "Cleaning unit test: ${unit_test} ..."
  clean_test "$unit_test"
  if "$is_ko"; then
    echo
    clean_test_suite_verbose "$is_ko"
  fi

}


# Run unit tests

source "$UNIT_TEST_PATHNAME"

echo "Initializing test suite ..."
check_functions

init_test_suite
echo

trap '[ $? -eq 0 ] || clean_test_suite_verbose true' EXIT

unit_tests=$(typeset -F | sed "s/declare -f //" | grep ^test_)

[[ -z "${unit_tests}" ]] && echo "no one unit test"

for unit_test in ${unit_tests}; do


  echo "Initializing unit test: ${unit_test} ..."
  init_test "${unit_test}"
  echo

  trap '[ $? -eq 0 ] || clean_test_verbose "${unit_test}" "true"' EXIT

  echo "Running unit test: ${unit_test} ..."
  stdout=$(tempfile -p "bhist" -s "_${unit_test}.stdout")
  stderr=$(tempfile -p "bhist" -s "_${unit_test}.stderr")
  "${unit_test}" > "${stdout}" 2> "${stderr}"
  exit_status=$?
  location="${PWD}"

  comments=$(get_comments "${unit_test}")

  expected_stderr=$(get_stderr "${comments}")
  echo "--STDERR:"
  echo "- given stderr:"
  stderr=$(cat "${stderr}" | sed 's/^.*line [0-9]*: /bash: /')
  [[ -n "${stderr}" ]] && echo "${stderr}"
  echo "- expected stderr:"
  [[ -n "${expected_stderr}" ]] && echo "${expected_stderr}"
  if [[ "$(echo "${expected_stderr}")" == "$(echo "${stderr}")" ]]; then
    echo "--> stderr OK"
  else
    >&2 echo "--> stderr KO"
    exit 1
  fi

  expected_stdout=$(get_stdout "${comments}")
  echo "--STDOUT:"
  echo "- given stdout:"
  cat "$stdout"
  echo "- expected stdout:"
  [[ -n "${expected_stdout}" ]] && echo "${expected_stdout}"
  if [[ "$(echo -n "${expected_stdout}")" == "$(cat "${stdout}")" ]]; then
    echo "--> stdout OK"
  else
    >&2 echo "--> stdout KO"
    exit 1
  fi

  expected_exit_status=$(get_exit_status "${comments}")
  echo "--EXIT STATUS:"
  echo "- given exit status: ${exit_status}"
  echo "- expected exit status: ${expected_exit_status}"
  if [[ "${expected_exit_status}" == "${exit_status}" ]]; then
    echo "--> exit status OK"
  else
    >&2 echo "--> exit status KO"
    exit 1
  fi

  expected_location=$(get_location "${comments}")
  echo "--LOCATION:"
  echo "- given location: ${location}"
  echo "- expected location: ${expected_location}"
  if [[ "${expected_location}" == "${location}" ]]; then
    echo "--> location OK"
  else
    >&2 echo "--> location KO"
    exit 1
  fi

  clean_test_verbose "${unit_test}"
  
done

echo
clean_test_suite_verbose