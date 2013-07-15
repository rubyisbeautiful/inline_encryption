require 'spec_helper'

describe InlineEncryption do

  it 'should load Base' do
    expect{ InlineEncryption::Base }.not_to raise_error
  end

  it 'should be extended by Base' do
    InlineEncryption.respond_to?(:config).should be_true
  end

end
