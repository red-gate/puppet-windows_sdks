# Install the .NET Framework 4.6.1 SDK
class windows_sdks::dotnet461($tempfolder = 'C:/temp') {
  require archive

  ensure_resource('file', $tempfolder, { ensure => directory })

  archive { "${tempfolder}/NDP461-DevPack-KB3105179-ENU.exe":
    source  => 'https://download.microsoft.com/download/F/1/D/F1DEB8DB-D277-4EF9-9F48-3A65D4D8F965/NDP461-DevPack-KB3105179-ENU.exe',
    require => File[$tempfolder],
  }
  ->
  package { 'Microsoft .NET Framework 4.6.1 SDK':
    source          => "${tempfolder}/NDP461-DevPack-KB3105179-ENU.exe",
    install_options => ['/quiet', '/norestart'],
  }
}
