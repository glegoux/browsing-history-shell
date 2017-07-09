# docker_helper.sh
#
# Provide bash function suite to use docker version 1.7.0.


get_docker_image_uuid() {

  if [[ -z "$1" ]]; then
    >&2 echo "ERROR: '${FUNCNAME}', missing argument !"
    return 1
  fi

  local uuid=$(docker images --no-trunc | grep "^$1 " | awk '{print $3}')
  if [[ -z "${uuid}" ]]; then
    return 0
  fi

  echo "${uuid}"
  return 0

}


get_docker_container_uuid() {

  if [[ -z "$1" ]]; then
    >&2 echo "ERROR: '${FUNCNAME}', missing argument !"
    return 1
  fi

  local uuid=$(docker ps -a --no-trunc -q --filter "name=$1")
  if [[ -z "${uuid}" ]]; then
    return 0
  fi

  echo "${uuid}"
  return 0

}


get_short_docker_uuid() {

  if [[ ${#1} -le 12 ]]; then
    >&2 echo "ERROR: '${FUNCNAME}', missing or invalid argument !"
    return 1
  fi

  local uuid="$1"
  echo "${uuid::12}"
  return 0

}


delete_docker_container() {

  if [[ -z "$1" ]]; then
    >&2 echo "ERROR: '${FUNCNAME}', missing argument !"
    return 1
  fi

  local uuid="$1"
  docker rm -f "$uuid" > /dev/null || return $?
  >&2 echo "Deleted docker container $(get_short_docker_uuid "${uuid}")"
  return 0

}


delete_docker_image() {

  if [[ -z "$1" ]]; then
    >&2 echo "ERROR: '${FUNCNAME}', missing argument !"
    return 1
  fi

  local uuid="$1"
  docker rmi -f "$uuid" > /dev/null || return $?
  >&2 echo "Deleted docker image $(get_short_docker_uuid "${uuid}")"
  return 0

}


execute_docker_command() {

  if [[ -z $1 ]]; then
    >&2 echo "ERROR: '${FUNCNAME}', missing or invalid argument !"
    return 1
  fi

  local cuuid="$1"
  local user="${2:-root}"
  local cmd="${3:-"echo Hello, World !"}"
  docker exec -u "${user}" "${cuuid}" ${cmd} || return $?
  return 0

}


connect_docker_container() {

  if [[ -z $1 ]]; then
    >&2 echo "ERROR: '${FUNCNAME}', missing or invalid argument !"
    return 1
  fi

  local cuuid="$1"
  local user="${2:-root}"
  docker exec -it -u "${user}" "${cuuid}" /bin/bash -c "cd; /bin/bash" \
    || return $?
  return 0

}
