# Remove all docker images
#
# Example usage:
#   docker_images_prune_hardcore
function docker_images_prune_hardcore() {
  ask_seriuosly_destructive "Do you really want to prune all docker images?" || return $?
  docker images -a | awk '{print $3}' | parallel "docker rmi -f {}"
  return $?
}
