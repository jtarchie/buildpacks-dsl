require 'spec_helper'

describe Buildpack::Dsl do
  it 'has a version number' do
    expect(Buildpack::Dsl::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
