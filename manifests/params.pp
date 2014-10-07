# Author::    Liam Bennett (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class nssm::params
#
# This class is meant to be called from `nssm`
# It sets variables according to platform
#
class nssm::params {
  $version     = '2.23'
  $install_url = "http://nssm.cc/release/nssm-${version}.zip"

  $install_dir = "C:\\Program Files\\nssm"
}
