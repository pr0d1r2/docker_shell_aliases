# Allow to stop all docker containers
#
# Example usage:
#   docker_stop_all_containers
function docker_stop_all_containers() {
  docker ps | cut -f 1  -d " " | grep -v "^CONTAINER" | parallel "docker stop {}"
  return $?
}
