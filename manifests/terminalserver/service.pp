# Manage NoMachine Terminal Server service
#
# @summary Manage NoMachine Terminal Server service
#
# @example
#   include nomachine::terminalserver::service
class nomachine::terminalserver::service inherits nomachine::terminalserver {

  $service_ensure = $nomachine::terminalserver::package_ensure ? {
    'absent' => 'stopped',
    default  => $nomachine::terminalserver::service_ensure,
  }

  $service_enable = $nomachine::terminalserver::package_ensure ? {
    'absent' => false,
    default  => $nomachine::terminalserver::service_enable,
  }

  service { 'nxserver':
    ensure => $service_ensure,
    enable => $service_enable,
  }

}
