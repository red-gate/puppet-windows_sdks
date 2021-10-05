# Install the .NET Framework 4.6.2 SDK
class windows_sdks::dotnet462(
  $source = 'https://download.visualstudio.microsoft.com/download/pr/ea744c52-1db4-4173-943d-a5d18e7e0d97/105c0e17be525bb0cebc7795d7aa1c32/ndp462-devpack-kb3151934-enu.exe',
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
