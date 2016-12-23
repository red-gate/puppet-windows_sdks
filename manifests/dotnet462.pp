# Install the .NET Framework 4.6.2 SDK
class windows_sdks::dotnet462(
  $source = 'https://download.microsoft.com/download/E/F/D/EFD52638-B804-4865-BB57-47F4B9C80269/NDP462-DevPack-KB3151934-ENU.exe',
  $temp_folder = 'C:/Windows/Temp'
  ) {

  require archive

  $filename = inline_template('<%= File.basename(@source) %>')

  ensure_resource('file', $temp_folder, { ensure => directory })

  archive { "${temp_folder}/${filename}":
    source  => $source,
    require => File[$temp_folder],
  }
  ->
  package { 'Microsoft .NET Framework 4.6.2 SDK':
    source          => "${temp_folder}/${filename}",
    install_options => ['/quiet', '/norestart'],
  }
}
