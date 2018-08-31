# Install NoMachine Terminal Server
#
# @summary Install NoMachine Terminal Server
#
# @example
#   include nomachine::terminalserver
class nomachine::terminalserver (
  String $package_ensure,
  String $package_version,
  String $base_package,
  String $base_path,
  String $service_ensure,
  String $service_enable,
  Optional[Hash]   $server_config = {},
  Optional[Hash]   $node_config = {},
  Optional[Array]  $dependancy_packages = [],
  Optional[String] $server_license_content = undef,
  Optional[String] $node_license_content = undef,
){

  contain ::nomachine::terminalserver::package
  contain ::nomachine::terminalserver::config
  contain ::nomachine::terminalserver::service

  Class['::nomachine::terminalserver::package']
  -> Class['::nomachine::terminalserver::config']
  -> Class['::nomachine::terminalserver::service']

}
