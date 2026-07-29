# Manage NoMachine Terminal Server configurations
#
# @summary Manage NoMachine Terminal Server configurations
#
# @example
#   include nomachine::terminalserver::config
#
# @param package_ensure
#   Current package state.
#   Configuration management is skipped when the package is absent.
#
# @param base_path
#   Installation directory for NoMachine.
#
# @param server_config
#   Hash of NoMachine server.cfg settings to manage.
#   Keys correspond to NoMachine server configuration directives.
#
# @param node_config
#   Hash of NoMachine node.cfg settings to manage.
#   Keys correspond to NoMachine node configuration directives.
#
# @param server_license_content
#   Contents of the NoMachine server license file.
#   When provided, it is written to `${base_path}/etc/server.lic`.
#
# @param node_license_content
#   Contents of the NoMachine node license file.
#   When provided, it is written to `${base_path}/etc/node.lic`.
class nomachine::terminalserver::config (
  Variant[Enum['present', 'latest', 'absent'], String] $package_ensure = $nomachine::terminalserver::package_ensure,
  String $base_path = $nomachine::terminalserver::base_path,
  Hash $server_config = $nomachine::terminalserver::server_config,
  Hash $node_config = $nomachine::terminalserver::node_config,
  Optional[String] $server_license_content = $nomachine::terminalserver::server_license_content,
  Optional[String] $node_license_content = $nomachine::terminalserver::node_license_content,
) {
  if $server_license_content {
    file { "${base_path}/etc/server.lic":
      ensure  => $package_ensure,
      content => $server_license_content,
      mode    => '0400',
      owner   => 'nx',
      group   => 'root',
    }
  }

  if $node_license_content {
    file { "${base_path}/etc/node.lic":
      ensure  => $package_ensure,
      content => $node_license_content,
      mode    => '0400',
      owner   => 'root',
      group   => 'root',
    }
  }

  if $package_ensure != 'absent' {
    $server_config.each |$key, $value| {
      augeas { "server_config/${key}":
        incl    => "${base_path}/etc/server.cfg",
        lens    => 'Spacevars.simple_lns',
        onlyif  => "get ${key} != '${value}'",
        changes => "set ${key} '${value}'",
      }
    }

    $node_config.each |$key, $value| {
      augeas { "node_config/${key}":
        incl    => "${base_path}/etc/node.cfg",
        lens    => 'Spacevars.simple_lns',
        onlyif  => "get ${key} != '${value}'",
        changes => "set ${key} '${value}'",
      }
    }
  }
}
