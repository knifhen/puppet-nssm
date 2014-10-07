# Author::    Liam Bennett (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nssm
#
# Module to install NSSM (the Non-Sucking Service Manager)
#
# === Parameters
#
# [*install_url*]
# The url to download the nssm package from
#
# [*install_dir*]
# The directory to install the package to
#
# [*version*]
# The version of nssm to install
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
