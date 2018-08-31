# Install NoMachine Terminal Server package
#
# @summary Install NoMachine Terminal Server package
#
# @example
#   include nomachine::terminalserver::package
class nomachine::terminalserver::package inherits nomachine::terminalserver {

  $merged_packages = concat( [$nomachine::terminalserver::base_package], $nomachine::terminalserver::dependancy_packages )

  if $nomachine::terminalserver::package_ensure == 'present' {
    $package_ensure = $nomachine::terminalserver::package_version
    $package_provider = undef
  } else {
    if ($::osfamily == 'Suse') {
      $package_ensure = 'absent'
    } else {
      $package_ensure = 'purged'
    }
  }

  ensure_packages( $merged_packages, { ensure => $package_ensure } )

}
