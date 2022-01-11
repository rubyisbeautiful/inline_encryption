# frozen_string_literal: true

require 'spec_helper'

describe InlineEncryption do
  it 'should load Base' do
    expect { InlineEncryption::Base }.not_to raise_error
  end

  it 'should be extended by Base' do
    expect(InlineEncryption.respond_to?(:config)).to be_truthy
  end
end
