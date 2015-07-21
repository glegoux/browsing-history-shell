#!/bin/bash


test_1() {
  ## stdout
  #  0 /home/user
  #  1 /home/user/A
  # *2 /home/user/A/1
  #  3 /home/user/B
  ## stderr
  ## exit status 0
  cd A > /dev/null
  cd ../A/1 > /dev/null
  cd ../../B > /dev/null
  cd :2 > /dev/null
  bhistory
}


test_2() {
  ## stdout
  ## stderr
  # ERROR: 'cd +', impossible out of range browsing history.
  ## exit status 1
  cd +
}


test_3() {
  ## stdout
  ## stderr
  # ERROR: 'cd -', impossible out of range browsing history.
  ## exit status 1
  cd -
}


test_4() {
  ## stdout
  ## stderr
  # bash: cd: aaa: No such file or directory
  ## exit status 1
  cd aaa
}
