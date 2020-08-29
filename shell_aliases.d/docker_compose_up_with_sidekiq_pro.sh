# Allow to quickly do docker-compose with variables required for Sidekiq Pro
#
# Example usage:
#   docker_compose_up_with_sidekiq_pro
# Any docker-compose parameter is passed on:
#   docker_compose_up_with_sidekiq_pro --build
function docker_compose_up_with_sidekiq_pro() {
  local docker_compose_up_with_sidekiq_pro_BUNDLE_GITHUB__COM
  local docker_compose_up_with_sidekiq_pro_BUNDLE_ENTERPRISE__CONTRIBSYS__COM
  docker_compose_up_with_sidekiq_pro_BUNDLE_GITHUB__COM="$(cat .bundle/config | grep "^BUNDLE_GITHUB__COM: " | cut -f2 -d ' ' | cut -f 2 -d '"')"
  docker_compose_up_with_sidekiq_pro_BUNDLE_ENTERPRISE__CONTRIBSYS__COM="$(cat .bundle/config | grep "^BUNDLE_ENTERPRISE__CONTRIBSYS__COM: " | cut -f2 -d ' ' | cut -f 2 -d '"')"
  if [ -z "$docker_compose_up_with_sidekiq_pro_BUNDLE_GITHUB__COM" ]; then
    echo ".bundle/config does not contain 'BUNDLE_GITHUB__COM' (GitHub personal access tocken: https://github.com/settings/tokens)"
    return 1
  fi
  if [ -z "$docker_compose_up_with_sidekiq_pro_BUNDLE_ENTERPRISE__CONTRIBSYS__COM" ]; then
    echo ".bundle/config does not contain 'BUNDLE_ENTERPRISE__CONTRIBSYS__COM' (Sidekiq Pro credentials: https://sidekiq.org/products/pro.html)"
    return 2
  fi
  command -v docker 1>/dev/null || cask cask install docker ##Darwin
  docker-compose up $@
  return $?
}
