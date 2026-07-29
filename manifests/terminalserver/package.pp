# Install NoMachine Terminal Server package
#
# @summary Install NoMachine Terminal Server package
#
# @example
#   include nomachine::terminalserver::package
#
# @param base_package
#   Name of the NoMachine Terminal Server package.
#
# @param dependency_packages
#   Array of additional packages required before installing NoMachine.
#
# @param package_ensure
#   Desired package state.
#   Valid values are `present`, `latest`, `absent`, or a specific package version.
class nomachine::terminalserver::package (
  String $base_package = $nomachine::terminalserver::base_package,
  Array[String] $dependency_packages = $nomachine::terminalserver::dependency_packages,
  Variant[Enum['present', 'latest', 'absent'], String] $package_ensure = $nomachine::terminalserver::package_ensure,
) {
  $merged_packages = [
    $base_package,
  ] + $dependency_packages

  package { $merged_packages:
    ensure => $package_ensure,
  }
}
