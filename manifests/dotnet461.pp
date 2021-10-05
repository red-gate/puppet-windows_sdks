# Install the .NET Framework 4.6.1 SDK
class windows_sdks::dotnet461($tempfolder = 'C:/temp') {
  require archive

  ensure_resource('file', $tempfolder, { ensure => directory })

  archive { "${tempfolder}/NDP461-DevPack-KB3105179-ENU.exe":
    source  => 'https://download.visualstudio.microsoft.com/download/pr/33a48e6c-c0d1-4321-946b-042b92bad691/a9a88bd451286ab9ea015ecc2208d725/ndp461-devpack-kb3105179-enu.exe',
    require => File[$tempfolder],
  }
  ->
  package { 'Microsoft .NET Framework 4.6.1 SDK':
    source          => "${tempfolder}/NDP461-DevPack-KB3105179-ENU.exe",
    install_options => ['/quiet', '/norestart'],
  }
}
