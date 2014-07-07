# == Class: nssm
#
# Full description of class nssm here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class nssm (
  $install_url = $nssm::params::install_url,
  $install_dir = $nssm::params::install_dir,
  $version     = $nssm::params::version
) inherits nssm::params {

  if $::osfamily != 'windows' {
    fail("${::osfamily} not supported")
  }

  anchor { 'nssm::begin': } ->
  class { 'nssm::install': } ->
  anchor { 'nssm::end': }
}
