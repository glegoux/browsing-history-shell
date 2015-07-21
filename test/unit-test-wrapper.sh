#!/bin/bash

# Environment variables
cd $(dirname "$0")
declare -r UNIT_TEST_FILE="${PWD}/unit-tests.sh"
cd - > /dev/null
declare -r TEST_USER="user"
declare -r TEST_ORIGIN_DIR="/home/user"
declare -r BHIST_PATHNAME="~/.bashrc_bhist"
declare -r BHIST_ALIAS_PATHNAME="~/.bash_aliases_bhist"


# Helper unit test
init_test() {
  cd > /dev/null
  source "$BHIST_PATHNAME"
}

get_comments() {
  cat ${UNIT_TEST_FILE} | sed -n "/$1() {/,/}/p" | grep '#' | sed "s/^[ ]*//"
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

die() {
  >&2 echo "ERROR: $1 !"
  exit 1
}

# Check and build unit test environment
[[ "$(id -un)" == "${TEST_USER}" ]] \
  || die "current user should be '${TEST_USER}'"

[[ "$(pwd)" == "${PWD}" ]] \
  || die "pwd sould be '${TEST_ORIGIN_DIR}'"

cd
mkdir -p {A,B,C}/{1,2,3} D/{:2,+,-}

# Enable alias in this non-interactive script
shopt -s expand_aliases

# Enable browsing history aliases
source "$BHIST_ALIAS_PATHNAME"

# Import unit tests
source "${UNIT_TEST_FILE}"

# Run unit tests
unit_tests=$(typeset -F | sed "s/declare -f //" | grep test_)
for unit_test in ${unit_tests}; do
  echo "Running unit test: ${unit_test} ..."
  init_test
  stdout="$(tempfile -p "bhist" -s _${unit_test}.stdout)"
  stderr="$(tempfile -p "bhist" -s _${unit_test}.stderr)"
  "${unit_test}" > "${stdout}" 2> "${stderr}"
  exit_status=$?

  comments=$(get_comments "${unit_test}")

  expected_stdout=$(get_stdout "${comments}")
  echo "expected stdout:"
  [[ -n ${expected_stdout} ]] && echo "${expected_stdout}"
  echo "given stdout:"
  cat "$stdout"
  if [[ "$(echo -n "${expected_stdout}")" == "$(cat "${stdout}")" ]]; then
    echo "--> stdout OK"
  else
    >&2 echo "--> stdout KO"
    exit 1
  fi

  expected_stderr=$(get_stderr "${comments}")
  echo "expected stderr:"
  [[ -n ${expected_stderr} ]] && echo "${expected_stderr}"
  echo "given stderr:"
  cat "${stderr}"
  if [[ "$(echo "${expected_stderr}")" == "$(cat "${stderr}")" ]]; then
    echo "--> stderr OK"
  else
    >&2 echo "--> stderr KO"
    exit 1
  fi

  expected_exit_status=$(get_exit_status "${comments}")
  echo "expected exit status: ${expected_exit_status}"
  echo "given exit status: ${exit_status}"
  if [[ "${expected_exit_status}" == "${exit_status}" ]]; then
    echo "--> exit status OK"
  else
    >&2 echo "--> exit status OK"
    exit 1
  fi
  echo

done

# Disable alias in this non-interactive shell
shopt -u expand_aliases
