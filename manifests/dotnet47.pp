# Install the .NET Framework 4.7 DevPack
class windows_sdks::dotnet47(
  $source = 'https://download.microsoft.com/download/A/1/D/A1D07600-6915-4CB8-A931-9A980EF47BB7/NDP47-DevPack-KB3186612-ENU.exe',
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
  package { 'Microsoft .NET Framework 4.7 SDK':
    source          => "${temp_folder}/${filename}",
    install_options => ['/quiet', '/norestart'],
  }
}
