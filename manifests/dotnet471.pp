# Install the .NET Framework 4.7 DevPack
class windows_sdks::dotnet471(
  $source = 'https://download.microsoft.com/download/9/0/1/901B684B-659E-4CBD-BEC8-B3F06967C2E7/NDP471-DevPack-ENU.exe',
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
  package { 'Microsoft .NET Framework 4.7.1 SDK':
    source          => "${temp_folder}/${filename}",
    install_options => ['/quiet', '/norestart'],
  }
}
