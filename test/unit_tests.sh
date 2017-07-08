# unit_tests.sh
#
# Set of unit test for bhist library. 
# 
# Require:
#
#  environment variables:
#    BHIST_USER=bhist_test
#    BHIST_HOME=/home/bhist_test
#    BHIST_FILENAME=<bhist_filename>
#  
#  user/group: bhist_test/bhist_test
#  location: /home/bhist_test


# Helper

die() {
  >&2 echo "ERROR: $1 !"
  exit 1
}


# Define functions to use the script ./test_suite.

init_test_suite() {

  # Check environment
  [[ -n $BHIST_USER ]] || die "environment variable BHIST_USER is not defined"
  [[ "$USER" == "$BHIST_USER" ]] || die "current user should be '$BHIST_USER'"
  
  [[ -n $BHIST_HOME ]] || die "environment variable BHIST_HOME is not defined"
  [[ -d "$BHIST_HOME" ]] || die "'$BHIST_HOME' does not exist or is not a folder"
  [[ "$HOME" == "$BHIST_HOME" ]] || die "home should be '$BHIST_HOME'"
  
  [[ -n $BHIST_FILENAME ]] || die "environment variable BHIST_FILENAME is not defined"
  BHIST_FILENAME="$(realpath "$BHIST_FILENAME")"
  [[ -f $BHIST_FILENAME ]] || die "'$BHIST_FILENAME' does not exist or is not a file"
  
  # Init environment
  cd "$BHIST_HOME" || die "impossible to go to '$BHIST_HOME'"
  echo "go to $PWD"

  mkdir -vp {A,B,C}/{1,2,3} D/{:2,+,-,:-1} E/ "F F/" || die "impossible to create filesystem environment"
  chmod -v -x E || die "impossible to change permissions for 'E' folder"

  # Enable browsing history
  source "$BHIST_FILENAME" || die "impossible to import '$BHIST_FILENAME' in bash environment"

}

clean_test_suite() {

  rm -rfv "$BHIST_HOME"/{A,B,C,D,E,"F F"}
  
}

init_test() {

  cd "$BHIST_HOME" || die "impossible to go to '$BHIST_HOME'"
  echo "go to $PWD"
  BHIST_DIRS=([0]="$PWD")
  BHIST_CUR_INDEX=0
  BHIST_LEN=1
  echo "reset BHIST_DIRS, BHIST_CUR_INDEX and BHIST_LEN"

}

clean_test() {
  echo nothing to do
}


# Unit tests

test_01() {
  ## stdout
  #  0 /home/bhist_test
  #  1 /home/bhist_test/A
  # *2 /home/bhist_test/A/1
  #  3 /home/bhist_test/B
  ## stderr
  ## exit status 0
  ## location /home/bhist_test/A/1
  __bhist_changedir A > /dev/null
  __bhist_changedir ../A/1 > /dev/null
  __bhist_changedir ../../B > /dev/null
  __bhist_changedir :2 > /dev/null
  __bhist_history
}


test_02() {
  ## stdout
  ## stderr
  # ERROR: 'cd +', impossible out of range browsing history.
  ## exit status 1
  ## location /home/bhist_test
  __bhist_changedir +
}


test_03() {
  ## stdout
  ## stderr
  # ERROR: 'cd -', impossible out of range browsing history.
  ## exit status 1
  ## location /home/bhist_test
  __bhist_changedir -
}


test_04() {
  ## stdout
  ## stderr
  # bash: cd: aaa: No such file or directory
  ## exit status 1
  ## location /home/bhist_test
  __bhist_changedir aaa
}


test_05() {
  ## stdout
  ## stderr
  # bash: cd: E: Permission denied
  ## exit status 1
  ## location /home/bhist_test
  __bhist_changedir E
}


test_06() {
  ## stdout
  #  0 /home/bhist_test
  # *1 /home/bhist_test/F F
  ## stderr
  ## exit status 0
  ## location /home/bhist_test/F F
  __bhist_changedir F\ F > /dev/null
  __bhist_history
}


test_07() {
  ## stdout
  #  0 /home/bhist_test
  #  1 /home/bhist_test/A
  #  2 /home/bhist_test/B
  #  3 /home/bhist_test/D
  # *4 /home/bhist_test/D/:2
  ## stderr
  # WARNING: 'cd :2', folder ':2' exists, go into this with 'cd ./:2'.
  ## exit status 0
  ## location /home/bhist_test/D/:2
  __bhist_changedir A > /dev/null
  __bhist_changedir ../B > /dev/null
  __bhist_changedir ../D > /dev/null
  __bhist_changedir :2 > /dev/null
  __bhist_changedir ../D/:2 > /dev/null
  __bhist_history
}


test_08() {
  ## stdout
  # *0 /home/bhist_test
  #  1 /home/bhist_test/A
  #  2 /home/bhist_test/B
  ## stderr
  ## exit status 0
  ## location /home/bhist_test
  __bhist_changedir A > /dev/null
  __bhist_changedir ../B > /dev/null
  __bhist_changedir - > /dev/null
  __bhist_changedir - > /dev/null
  __bhist_history
}


test_09() {
  ## stdout
  #  0 /home/bhist_test
  #  1 /home/bhist_test/A
  # *2 /home/bhist_test/B
  ## stderr
  ## exit status 0
  ## location /home/bhist_test/B
  __bhist_changedir A > /dev/null
  __bhist_changedir ../B > /dev/null
  __bhist_changedir :0 > /dev/null
  __bhist_changedir B > /dev/null
  __bhist_history
}


test_10() {
  ## stdout
  #  0 /home/bhist_test
  #  1 /home/bhist_test/A
  #  2 /home/bhist_test/B
  # *3 /home/bhist_test/C
  ## stderr
  # ERROR: 'cd :4', impossible out of range browsing history.
  ## exit status 1
  ## location /home/bhist_test/C
  __bhist_changedir A > /dev/null
  __bhist_changedir ../B > /dev/null
  __bhist_changedir ../C > /dev/null
  __bhist_history
  __bhist_changedir :4 > /dev/null
}


test_11() {
  ## stdout
  #  0 /home/bhist_test
  #  1 /home/bhist_test/A
  #  2 /home/bhist_test/B
  #  3 /home/bhist_test/C
  #  4 /home/bhist_test/D
  # *5 /home/bhist_test/D/:-1
  ## stderr
  ## exit status 0
  ## location /home/bhist_test/D/:-1
  __bhist_changedir A > /dev/null
  __bhist_changedir ../B > /dev/null
  __bhist_changedir ../C > /dev/null
  __bhist_changedir ../D > /dev/null
  __bhist_changedir :-1 > /dev/null
  __bhist_history
}
