# Manage NoMachine Terminal Server service
#
# @summary Manage NoMachine Terminal Server service
#
# @example
#   include nomachine::terminalserver::service
#
# @param package_ensure
#   Current package state.
#   When set to `absent`, the service will be stopped and disabled.
#
# @param service_ensure
#   Desired state of the NoMachine service.
#   Common values are `running` or `stopped`.
#
# @param service_enable
#   Whether the NoMachine service should be enabled at boot.
class nomachine::terminalserver::service (
  Variant[Enum['present', 'latest', 'absent'], String] $package_ensure = $nomachine::terminalserver::package_ensure,
  String $service_ensure = $nomachine::terminalserver::service_ensure,
  Boolean $service_enable = $nomachine::terminalserver::service_enable,
) {
  $real_service_ensure = $package_ensure ? {
    'absent' => 'stopped',
    default  => $service_ensure,
  }

  $real_service_enable = $package_ensure ? {
    'absent' => false,
    default  => $service_enable,
  }

  service { 'nxserver':
    ensure => $real_service_ensure,
    enable => $real_service_enable,
  }
}
