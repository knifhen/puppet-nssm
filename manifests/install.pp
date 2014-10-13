# Author::    Liam Bennett (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class nssm::install
#
# This private class is meant to be called from `nssm`.
# It downloads the package and installs it.
#
class nssm::install {

  download_file { 'nssm-download':
    url                   => $nssm::install_url,
    destination_directory => 'C:\\Windows\\Temp'
  }

  case $::architecture {
    'x86_64', 'amd64': {
      $bitness = '64'
    }
    default: {
      $bitness = '32'
    }
  }

  exec { 'unzip-nssm':
    command  => "\$shell = New-Object -COMObject Shell.Application; \$zipfile = \$shell.NameSpace(\"nssm-${nssm::version}.zip\"); foreach(\$item in \$zipfile.Items()){ \$shell.NameSpace(\"${nssm::install_dir}\").CopyHere(\$item, 20)",
    provider => powershell,
    creates  => "${nssm::install_dir}\\nssm-${nssm::version}\\win${bitness}",
    require  => Download_file['nssm-download']
  }
}
