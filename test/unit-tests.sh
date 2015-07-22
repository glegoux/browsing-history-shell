#!/bin/bash

# Override function for test suite

die() {

  >&2 echo "ERROR: $1 !"
  exit 1

}

init_test_suite() {

  cd
  echo "go to $PWD"

  # Check and build unit test environment
  [[ "$(id -un)" == "$BHIST_USER" ]] \
    || die "current user should be '$BHIST_USER'"

  [[ "$(pwd)" == "$BHIST_HOME" ]] \
    || die "pwd sould be '$BHIST_HOME'"

  mkdir -vp {A,B,C}/{1,2,3} D/{:2,+,-} E/
  chmod -v 000 E

  # Enable browsing history
  source "$BHIST_HOME/$BHIST_FILENAME"

}

clean_test_suite() {

  rm -rfv ~/{A,B,C,D,E}

}

init_test() {
  set -x
  cd > /dev/null
  BHIST_DIRS=([0]="$PWD")
  BHIST_CUR_INDEX=0
  BHIST_LEN=1
  set +x

}

clean_test() {
  echo nothing to do
}


# Unit tests

test_1() {
  ## stdout
  #  0 /home/user
  #  1 /home/user/A
  # *2 /home/user/A/1
  #  3 /home/user/B
  ## stderr
  ## exit status 0
  ## location /home/user/A/1
  __bhist_changedir A > /dev/null
  __bhist_changedir ../A/1 > /dev/null
  __bhist_changedir ../../B > /dev/null
  __bhist_changedir :2 > /dev/null
  __bhist_bhistory
}


test_2() {
  ## stdout
  ## stderr
  # ERROR: 'cd +', impossible out of range browsing history.
  ## exit status 1
  ## location /home/user
  __bhist_changedir +
}


test_3() {
  ## stdout
  ## stderr
  # ERROR: 'cd -', impossible out of range browsing history.
  ## exit status 1
  ## location /home/user
  __bhist_changedir -
}


test_4() {
  ## stdout
  ## stderr
  # bash: cd: aaa: No such file or directory
  ## exit status 1
  ## location /home/user
  __bhist_changedir aaa
}

test_5() {
  ## stdout
  ## stderr
  # bash: cd: E: Permission denied
  ## exit status 1
  ## location /home/user
  __bhist_changedir E
}
