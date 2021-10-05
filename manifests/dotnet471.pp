# Install the .NET Framework 4.7 DevPack
class windows_sdks::dotnet471(
  $source = 'https://download.visualstudio.microsoft.com/download/pr/e5eb8d37-5bbd-4fb7-a71d-b749e010ef9f/601437d729667ecd29020a829fbc4881/ndp471-devpack-enu.exe',
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
