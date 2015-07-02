require 'spec_helper'

RSpec.describe 'When running the ruby buildpack' do
  before(:all) { compile_buildpack('ruby') }

  it 'installs gems' do
    expect(@output).to include 'Installing rack 1.6.4'
  end

  it 'has bundler' do
    expect(bprun('bundle exec ruby --version')).to include '1.9.3'
  end
end
