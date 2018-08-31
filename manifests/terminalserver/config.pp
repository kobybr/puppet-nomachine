# Manage NoMachine Terminal Server configurations
#
# @summary Manage NoMachine Terminal Server configurations
#
# @example
#   include nomachine::terminalserver::config
class nomachine::terminalserver::config inherits nomachine::terminalserver {

  if $nomachine::terminalserver::server_license_content {
    file { "${nomachine::terminalserver::base_path}/etc/server.lic":
      ensure  => $nomachine::terminalserver::package_ensure,
      content => $nomachine::terminalserver::server_license_content,
      mode    => '0400',
      owner   => 'nx',
      group   => 'root',
    }
  }

  if $nomachine::terminalserver::node_license_content {
    file { "${nomachine::terminalserver::base_path}/etc/node.lic":
      ensure  => $nomachine::terminalserver::package_ensure,
      content => $nomachine::terminalserver::node_license_content,
      mode    => '0400',
      owner   => 'root',
      group   => 'root',
    }
  }

  unless $nomachine::terminalserver::package_ensure == 'absent' {
    $nomachine::terminalserver::server_config.each | $key, $value | {
      augeas { "server_config/${key}":
        incl    => "${nomachine::terminalserver::base_path}/etc/server.cfg",
        lens    => 'Spacevars.simple_lns',
        onlyif  => "get ${key} != '${value}'",
        changes => "set ${key} '${value}'",
        notify  => Service['nxserver'],
      }
    }
    $nomachine::terminalserver::node_config.each | $key, $value | {
      augeas { "node_config/${key}":
        incl    => "${nomachine::terminalserver::base_path}/etc/node.cfg",
        lens    => 'Spacevars.simple_lns',
        onlyif  => "get ${key} != '${value}'",
        changes => "set ${key} '${value}'",
        notify  => Service['nxserver'],
      }
    }
  }

}
