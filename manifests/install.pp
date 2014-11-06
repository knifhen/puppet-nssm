# Author::    Liam Bennett (mailto:lbennett@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class nssm::install
#
# This private class is meant to be called from `nssm`.
# It downloads the package and installs it.
#
class nssm::install {
  $download_dir = 'c:\\Windows\\Temp'
  $download_file = "nssm-${nssm::version}.zip"
  $download_path = regsubst("${download_dir}\\${download_file}", '\\\\', '\\', 'G')
  $install_dir_win = regsubst("${nssm::install_dir}", '\\\\', '\\', 'G')

  file { $nssm::install_dir: ensure => directory; }

  download_file { 'nssm-download':
    url                   => $nssm::install_url,
    destination_directory => $download_dir,
  }

  case $::architecture {
    'x86_64', 'amd64' : { $bitness = '64' }
    default           : { $bitness = '32' }
  }

  exec { 'unzip-nssm':
    command  => "\$shell = New-Object -COMObject Shell.Application; \$zipfile = \$shell.NameSpace(\"${download_path}\"); foreach(\$item in \$zipfile.Items()){ \$shell.NameSpace(\"${install_dir_win}\").CopyHere(\$item, 20)};",
    provider => powershell,
    creates  => "${nssm::install_dir}\\nssm-${nssm::version}\\win${bitness}",
    require  => Download_file['nssm-download']
  }
}
