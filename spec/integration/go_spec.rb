require 'spec_helper'

RSpec.describe 'When running the go buildpack' do
  before(:all) { compile_buildpack('go') }

  it 'installs go' do
    expect(@output).to include 'Installing go1.4.2'
  end

  it 'compiles the application as the InstallPath name in Godeps' do
    expect(bprun('ls bin/go-online')).to include 'go-online'
  end
end
