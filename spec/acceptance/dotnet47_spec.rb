# Encoding: utf-8
require_relative 'spec_windowshelper'

describe package('Microsoft .NET Framework 4.7 SDK') do
  it { should be_installed }
end
