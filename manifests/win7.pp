# Install the Microsoft Windows SDK for Windows 7 (7.1)
#
# $url: URL of the SDK Iso download. (defaults to the x64 version)
#       if installing x86, you could use https://download.microsoft.com/download/F/1/0/F10113F5-B750-4969-A255-274341AC6BCE/GRMSDK_EN_DVD.iso
#
# $tempFolder: The folder where the iso will be extracted to and the install started from.
class windows_sdks::win7(
  $url = 'https://download.microsoft.com/download/F/1/0/F10113F5-B750-4969-A255-274341AC6BCE/GRMSDKX_EN_DVD.iso',
  $tempFolder = 'c:/temp') {

  require archive

  ensure_resource('file', [$tempFolder, "${tempFolder}/WinSDK.7.1"], {'ensure' => 'directory'})

  archive { "${tempFolder}/WinSDK.7.1.iso":
    extract      => true,
    extract_path => "${tempFolder}/WinSDK.7.1",
    source       => $url,
    creates      => "${tempFolder}/WinSDK.7.1/setup.exe",
    cleanup      => true,
    require      => File["${tempFolder}/WinSDK.7.1"],
  }
  ->
  package { 'Microsoft Windows SDK for Windows 7 (7.1)' :
    ensure          => installed,
    source          => "${tempFolder}/WinSDK.7.1/setup.exe",
    install_options => ['-q','-params:ADDLOCAL=ALL'],
  }
  ->
  windows_env { 'WINDOWSSDK_VERSION=7.1': }
}
