# Install NoMachine Terminal Server
#
# @summary Manage NoMachine Terminal Server
#
# @example
#   include nomachine::terminalserver
#
# @param package_ensure
#   Desired package state.
#   Valid values are `present`, `latest`, `absent`, or a specific version.
#
# @param base_package
#   Name of the NoMachine Terminal Server package.
#
# @param base_path
#   Installation directory for NoMachine.
#
# @param service_ensure
#   Desired state of the NoMachine service.
#
# @param service_enable
#   Whether the NoMachine service should be enabled at boot.
#
# @param server_config
#   Hash of NoMachine server.cfg settings to manage.
#
# @param node_config
#   Hash of NoMachine node.cfg settings to manage.
#
# @param dependency_packages
#   Additional packages required before installing NoMachine.
#
# @param server_license_content
#   Contents of the server license file.
#
# @param node_license_content
#   Contents of the node license file.
#
class nomachine::terminalserver (
  Variant[Enum['present', 'latest', 'absent'], String] $package_ensure,
  String $base_package,
  String $base_path,
  String $service_ensure,
  Boolean $service_enable,
  Hash $server_config = {},
  Hash $node_config = {},
  Array[String] $dependency_packages = [],
  Optional[String] $server_license_content = undef,
  Optional[String] $node_license_content = undef,
) {
  class { 'nomachine::terminalserver::package':
    package_ensure      => $package_ensure,
    base_package        => $base_package,
    dependency_packages => $dependency_packages,
  }

  class { 'nomachine::terminalserver::config':
    package_ensure         => $package_ensure,
    base_path              => $base_path,
    server_config          => $server_config,
    node_config            => $node_config,
    server_license_content => $server_license_content,
    node_license_content   => $node_license_content,
  }

  class { 'nomachine::terminalserver::service':
    package_ensure => $package_ensure,
    service_ensure => $service_ensure,
    service_enable => $service_enable,
  }

  contain nomachine::terminalserver::package
  contain nomachine::terminalserver::config
  contain nomachine::terminalserver::service

  Class['nomachine::terminalserver::package']
  -> Class['nomachine::terminalserver::config']
  ~> Class['nomachine::terminalserver::service']
}
