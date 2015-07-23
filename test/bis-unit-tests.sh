#!/bin/bash

# Override function for test suite

die() {

  >&2 echo "ERROR: $1 !"
  exit 1

}

init_test_suite() {

  cd
  echo "go to $PWD"


  mkdir -vp {A,B,C}/{1,2,3} D/{:2,+,-} E/
  chmod -v 000 E


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


