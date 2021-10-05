# Install the .NET Framework 4.7 DevPack
class windows_sdks::dotnet47(
  $source = 'https://download.visualstudio.microsoft.com/download/pr/fe069d49-7999-4ac8-bf8d-625282915070/d52a6891b5014014e1f12df252fab620/ndp47-devpack-kb3186612-enu.exe',
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
