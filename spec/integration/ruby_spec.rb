require 'spec_helper'

RSpec.describe 'When running the ruby buildpack' do
  before(:all) { compile_buildpack('ruby') }

  it 'installs gems' do
    expect(@output).to include 'Installing rack 1.6.4'
  end

  it 'has bundler and installs a Ruby 2.2.2' do
    expect(bprun('which ruby')).to include 'vendor/ruby'
    expect(bprun('bundle exec ruby --version')).to include '2.2.2'
  end
end
